import 'package:mkpv_socket/mkpv_socket.dart';
import 'package:mkpv_socket/socket/socket_server.dart';

import '../enum/command_type.dart';
import 'close_command.dart';
import 'open_command.dart';
import 'srcoll_command.dart';

abstract class Command {
  Command(this.arguments);
  final List<String> arguments;
  void run();

  static Command fromType(CommandType type, List<String> args) {
    switch (type) {
      case CommandType.open:
        return OpenCommand(args);
      case CommandType.close:
        return CloseCommand();
      case CommandType.scroll:
        return ScrollCommand(args);
    }
  }
}

abstract class SocketCommand extends Command {
  SocketCommand(super.arguments);
  RequestType get type;
  late MkpvSocket socket;
  Future connect({String? address, int? port}) async {
    socket = await MkpvSocket.connect();
  }

  void send([dynamic data]) {
    socket.send(Request(type.index, data));
  }

  void dispose() {
    socket.dispose();
  }
}
