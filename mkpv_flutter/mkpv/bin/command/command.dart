import 'package:args/command_runner.dart';
import 'package:mkpv_socket/mkpv_socket.dart';
import 'package:mkpv_socket/socket/socket_server.dart';

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
