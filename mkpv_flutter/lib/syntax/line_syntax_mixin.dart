part of mk_syntax;

mixin LineSyntaxMixin on BlockSyntax {
  Node wrapLineNode(List<String> lines, String current, Node child) {
    final line = findLine(lines, current);

    final element = Element("div", [child]);
    element.generatedId = "${line + 1}";
    return element;
  }

  int findLine(List<String> lines, String current);
}

mixin SingleLineSyntaxMixin on BlockSyntax {
  Node wrapLineNode(List<String> lines, String current, Node child) {
    final line = findLine(lines, current);

    final element = Element("div", [child]);
    element.generatedId = "${line + 1}";
    return element;
  }

  int findLine(List<String> lines, String current) {
    final index = lines.indexWhere((e) => e == current);
    print(index);
    lines.removeAt(index);
    return index;
  }
}
