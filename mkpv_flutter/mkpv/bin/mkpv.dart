import 'dart:io';

import 'package:args/command_runner.dart';

import 'command/close_command.dart';
import 'command/open_command.dart';
import 'command/srcoll_command.dart';

void main(List<String> arguments) {
  final runner = CommandRunner("mkpv", "Markdown Perview for Vim.")
    ..addCommand(OpenCommand())
    ..addCommand(CloseCommand())
    ..addCommand(ScrollCommand());

  runner.run(arguments).catchError((e) {
    if (e is! UsageException) {
      throw e;
    }
    print(e);
    exit(64);
  });
}
