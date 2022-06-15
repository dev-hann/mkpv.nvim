part of mkpv_command;

class ScrollCommand extends MKPVCommand with SocketCommandMixin {
  @override
  String get name => 'scroll';

  @override
  String get description => 'View Scroll to Current Editor Line.';

  @override
  void run() async {
    final list = argResults!.arguments;
    await connect();
    final line = int.tryParse(list.first) ?? 1;
    send(RequestType.scroll, line);
    socket.dispose();
    exit(0);
  }
}
