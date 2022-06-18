part of mkpv_command;

class OpenCommand extends MKPVCommand {
  @override
  String get name => 'open';

  @override
  String get description => 'Run MKPV Server & View.';

  @override
  void run() {
    final list = argResults!.arguments;
    if (list.isEmpty) {
      print("markdown Path can not be empty!");
      exit(0);
    }
    initWatch(list.first);
    initServer();
    openApp();
  }

  void openApp() {
    final home = Platform.environment['HOME'];
    final dir = '$home/.local/share/nvim/plugged/mkpv.nvim/app';
    Process.run("./flutter_mkpv", [], workingDirectory: "$dir/bundle/");
  }

  final WatcherService watcher = WatcherService();

  void initWatch(String filePath) {
    watcher.initWatch(filePath);
    watcher.addListener(watchListener);
  }

  void watchListener(WatchEvent event) {
    watcher.refreshData();
    updateMarkdown();
  }

  void updateMarkdown([MkpvSocket? client]) {
    final mk = parsingMarkdown(watcher.data);
    final request = Request.update(mk);
    if (client != null) {
      client.send(request);
    } else {
      server.notifyClients(request);
    }
  }

  // parsingMarkdown
  // Wrap Node with id by [Element].
  // when scroll to scope through id.
  String parsingMarkdown(String data) {
    final data = watcher.data;
    final splitLines = data.replaceAll('\r\n', '\n').split('\n');
    final doc = Document(extensionSet: ExtensionSet.gitHubWeb);
    final nodeList = doc.parseLines(splitLines);
    final nodeLen = nodeList.length;
    final List<Element> elementList = [];
    for (int index = 0; index < nodeLen; index++) {
      final element = Element("p", [nodeList[index]]);
      element.generatedId = "$index";
      elementList.add(element);
    }
    final res = HtmlRenderer().render(elementList);
    return res;
  }

  void disposeWatch() {
    watcher.removeListener(watchListener);
  }

  final SocketService server = SocketService();

  late StreamSubscription serverStream;
  Future initServer() async {
    final stream = await server.bind();
    serverStream = stream.listen(serverListener);
  }

  void serverListener(MkpvSocket socket) {
    void closeServer() {
      server.notifyClients(Request.close());
      socket.dispose();
      exit(0);
    }

    void onClientError(dynamic err) {
      print(err);
      server.removeClient(socket);
      socket.dispose();
    }

    void onClientDone() {
      print("client left");
      server.removeClient(socket);
      socket.dispose();
      if (server.isEmpty) {
        closeServer();
      }
    }

    void onClientData(Request request) {
      final type = request.type;
      switch (type) {
        case RequestType.connect:
          server.addClient(socket);
          updateMarkdown(socket);
          break;
        case RequestType.close:
          closeServer();
          break;
        case RequestType.update:
          break;
        case RequestType.scroll:
          server.notifyClients(request);
          break;
      }
    }

    socket.addListener(
      onData: onClientData,
      onError: onClientError,
      onDone: onClientDone,
    );
  }
}
