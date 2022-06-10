import 'dart:io';

import 'package:mkpv_socket/mkpv_socket.dart';

import 'command.dart';

class ScrollCommand extends SocketCommand {
  ScrollCommand(super.arguments);

  @override
  RequestType get type => RequestType.scroll;

  @override
  void run() async {
    await connect();
    final position = double.tryParse(arguments.first) ?? 0.0;
    send(position);
    socket.dispose();
    exit(0);
  }
}
