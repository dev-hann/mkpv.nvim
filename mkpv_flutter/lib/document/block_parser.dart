import 'package:flutter_mkpv/document/document.dart';
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
}
