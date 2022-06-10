import 'dart:io';

import 'package:args/args.dart';

import 'command/command.dart';
import 'enum/command_type.dart';
void main(List<String> arguments) {
  handleExitApp();
  final parser = ArgParser();
  for (final item in CommandType.values) {
    parser.addCommand(item.toCommand());
  }
  final res = parser.parse(arguments);
  final command = res.command;
  if (command == null) {
    print("No Such Command!");
    return;
  }

  final commandName = command.name!;
  final args = command.arguments;
  final commandType = commandName.toCommand()!;
  final cmd = Command.fromType(commandType, args);
  cmd.run();
}

void handleExitApp() {
  ProcessSignal.sigint.watch().listen((_) {
    print("Stopped mkpv Server");
    exit(0);
  });
}
