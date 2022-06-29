part of mkpv_command;

class UpdateCommand extends MKPVCommand with SocketCommandMixin {
  UpdateCommand() {
    argParser
      ..addOption("markdown", abbr: "m")
      ..addOption("scroll", abbr: "s");
  }

  @override
  String get name => 'update';

  @override
  String get description => 'updated markdown.';
  @override
  void run() async {
    print("@@@");
    print(argParser.options);

    // await connect();
    // final line = int.tryParse(list.first) ?? 1;
    // send(RequestType.scroll, line);
    // socket.dispose();
    exit(0);
  }
}
