import 'package:mkpv_socket/mkpv_socket.dart';
import 'package:mkpv_socket/socket/socket_server.dart';

class SocketService {
  final MkpvSocketServer server = MkpvSocketServer();

  Future<Stream<MkpvSocket>> bind() async {
    return server.bind();
  }

  void addClient(MkpvSocket client) {
    server.addClient(client);
  }

  void removeClient(MkpvSocket client) {
    server.removeClient(client);
  }

  void notifyClients(Request request) {
    final clientList = server.clientList;
    for (final client in clientList) {
      client.send(request);
    }
  }

  Future<MkpvSocket> connect() async {
    return await MkpvSocket.connect();
  }
}
