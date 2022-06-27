import 'package:flutter_mkpv/model/document.dart';
import 'package:markdown/markdown.dart';

class MKBlockParser extends BlockParser {
  MKBlockParser(List<String> lines, MKDocument document)
      : super(lines, document);

  int currentLine = 0;
  @override
  void advance() {
    super.advance();
    currentLine++;
  }

  Node wrapLine(Node node) {
    final element = Element("div", [node]);
    element.generatedId = "$currentLine";
    return element;
  }

  @override
  List<Node> parseLines() {
    var blocks = <Node>[];
    while (!isDone) {
      for (var syntax in blockSyntaxes) {
        if (syntax.canParse(this)) {
          var block = syntax.parse(this);
          if (block != null) blocks.add(wrapLine(block));
          break;
        }
      }
    }

    return blocks;
  }
}
