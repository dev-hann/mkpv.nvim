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

  void watchListener(WatchEvent event) async {
    watcher.refreshData();
    await updateMarkdown();
  }

  Future updateMarkdown([MkpvSocket? client]) async {
    final request = Request.update(watcher.data);
    if (client != null) {
      client.send(request);
    } else {
      await server.notifyClients(request);
    }
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
    void closeServer() async {
      await server.notifyClients(Request.close());
      socket.dispose();
      exit(0);
    }

    void onClientError(dynamic err) {
      server.removeClient(socket);
      socket.dispose();
    }

    void onClientDone() {
      server.removeClient(socket);
      socket.dispose();
      if (server.isEmpty) {
        closeServer();
      }
    }

    Future onClientData(Request request) async {
      final type = request.type;
      switch (type) {
        case RequestType.connect:
          server.addClient(socket);
          await updateMarkdown(socket);
          break;
        case RequestType.close:
          closeServer();
          break;
        case RequestType.update:
          break;
        case RequestType.scroll:
          await server.notifyClients(request);
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
