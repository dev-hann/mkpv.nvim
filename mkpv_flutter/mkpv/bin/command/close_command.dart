import 'dart:io';

import 'package:mkpv_socket/mkpv_socket.dart';

import 'command.dart';

class CloseCommand extends SocketCommand {
  CloseCommand() : super([]);

  @override
  RequestType get type => RequestType.close;

  @override
  void run() async {
    await connect();
    send();
    socket.dispose();
    exit(0);
  }
}
