enum CommandType {
  open,
  close,
  scroll,
}

List<String> commandList = [
  "open",
  "close",
  "scroll",
];

extension CommandTypeExtension on CommandType {
  String toCommand() {
    return commandList[index];
  }
}

extension CommandTypeString on String {
  CommandType? toCommand() {
    final index = commandList.indexWhere((e) => e == this);
    if (index == -1) {
      return null;
    }
    return CommandType.values[index];
  }
}
