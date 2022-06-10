library mkpv_socket;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mkpv_socket/request/request.dart';
part 'socket.dart';

const String defaultAddress = 'localhost';
const int defaultPort = 55555;

typedef ServerCallback = Function(MkpvSocket, dynamic);

class MkpvSocketServer {
  Future<Stream<MkpvSocket>> bind({String? address, int? port}) async {
    final stream = await ServerSocket.bind(
      address ?? defaultAddress,
      port ?? defaultPort,
    );
    return stream.map((e) {
      return MkpvSocket(e);
    });
  }

  final List<MkpvSocket> clientList = [];

  void addClient(MkpvSocket client) {
    if (clientList.contains(client)) return;
    clientList.add(client);
  }

  void removeClient(MkpvSocket client) {
    clientList.remove(client);
  }
}
