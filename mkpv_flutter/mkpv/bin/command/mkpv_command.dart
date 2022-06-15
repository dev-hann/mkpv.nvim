library mkpv_command;
import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:markdown/markdown.dart';
import 'package:mkpv_socket/mkpv_socket.dart';
import 'package:mkpv_socket/socket/socket_server.dart';
import 'package:watcher/watcher.dart';

import '../service/socket/socket_service.dart';
import '../service/watcher/watcher_service.dart';

part 'command_open.dart';
part 'command_close.dart';
part 'command_scroll.dart';

abstract class MKPVCommand extends Command {
  @override
  void run();
}

mixin SocketCommandMixin on MKPVCommand {
  late MkpvSocket socket;
  Future connect({String? address, int? port}) async {
    socket = await MkpvSocket.connect();
  }

  void send(RequestType requestType, [dynamic data]) {
    socket.send(Request(requestType.index, data));
  }

  void dispose() {
    socket.dispose();
  }
}
