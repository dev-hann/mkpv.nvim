import 'dart:async';

import 'package:mkpv_socket/mkpv_socket.dart';
import 'package:mkpv_socket/socket/socket_server.dart';

class SocketService {
  final MkpvSocketServer server = MkpvSocketServer();

  bool get isEmpty => server.clientList.isEmpty;

  Future<Stream<MkpvSocket>> bind() async {
    _initRequestStream();
    return server.bind();
  }

  void addClient(MkpvSocket client) {
    server.addClient(client);
  }

  void removeClient(MkpvSocket client) {
    server.removeClient(client);
  }

  final StreamController<Request> _requestController = StreamController();

  void _initRequestStream() {
    _requestController.stream.listen((request) async {
      await Future.delayed(Duration(milliseconds: 300));
      final clientList = server.clientList;
      for (final client in clientList) {
        client.send(request);
      }
    });
  }

  Future notifyClients(Request request) async {
    _requestController.add(request);
    // await Future.delayed(Duration(milliseconds: 300));
    // final clientList = server.clientList;
    // for (final client in clientList) {
    //   client.send(request);
    // }
  }

  Future<MkpvSocket> connect() async {
    return await MkpvSocket.connect();
  }
}
