import 'dart:io';

import 'package:mkpv_socket/mkpv_socket.dart';

import 'command.dart';

class CloseCommand extends MKPVCommand with SocketCommandMixin {
  @override
  String get description => 'Close MkPV Server & View.';

  @override
  String get name => 'close';

  @override
  void run() async {
    await connect();
    send(RequestType.close);
    socket.dispose();
    exit(0);
  }
}
