part of mkpv_command;

class CloseCommand extends MKPVCommand with SocketCommandMixin {
  @override
  String get description => 'Close MkPV Server & View.';

  @override
  String get name => 'close';

  @override
  void run() async {
    await connect();
    send(Request.close());
    socket.dispose();
    exit(0);
  }
}
