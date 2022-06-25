import 'package:flutter_mkpv/document/block_parser.dart';
import 'package:markdown/markdown.dart';

class MKDocument extends Document {
  MKDocument() : super(extensionSet: ExtensionSet.gitHubWeb);

  String render(String html) {
    if (html.isEmpty) return "";
    final splitLines = html.replaceAll('\r\n', '\n').split('\n');
    return HtmlRenderer().render(parseLines(splitLines));
  }

  @override
  List<Node> parseLines(List<String> lines) {
    final nodes = MKBlockParser(lines, this).parseLines();
    _parseInlineContent(nodes);
    return nodes;
  }

  void _parseInlineContent(List<Node> nodes) {
    for (var i = 0; i < nodes.length; i++) {
      var node = nodes[i];
      if (node is UnparsedContent) {
        var inlineNodes = parseInline(node.textContent);
        nodes.removeAt(i);
        nodes.insertAll(i, inlineNodes);
        i += inlineNodes.length - 1;
      } else if (node is Element && node.children != null) {
        _parseInlineContent(node.children!);
      }
    }
  }
}
