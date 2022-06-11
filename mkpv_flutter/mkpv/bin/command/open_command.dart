import 'dart:async';
import 'dart:io';

import 'package:mkpv_socket/mkpv_socket.dart';
import 'package:mkpv_socket/socket/socket_server.dart';
import 'package:watcher/watcher.dart';

import '../service/socket/socket_service.dart';
import '../service/watcher/watcher_service.dart';
import 'command.dart';

class OpenCommand extends Command {
  OpenCommand(super.arguments);

  @override
  void run() {
    if (arguments.isEmpty || arguments.first.isEmpty) {
      print("markdown Path can not be empty!");
      exit(0);
    }
    initWatch(arguments.first);
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
    final request = Request.update(watcher.data);
    if (client != null) {
      client.send(request);
    } else {
      server.notifyClients(request);
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
    void onClientData(Request request) {
      final type = request.type;
      switch (type) {
        case RequestType.connect:
          server.addClient(socket);
          // print("connected !! $socket");
          updateMarkdown(socket);
          break;
        case RequestType.close:
          socket.dispose();
          exit(0);
        case RequestType.update:
          break;
        case RequestType.scroll:
          server.notifyClients(request);
          break;
      }
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
    }

    socket.addListener(
      onData: onClientData,
      onError: onClientError,
      onDone: onClientDone,
    );
  }
}
