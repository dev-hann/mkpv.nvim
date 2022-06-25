part of mk_syntax;

class MKHeaderSyntax extends HeaderSyntax with SingleLineSyntaxMixin {
  MKHeaderSyntax(this.lines);
  final List<String> lines;
  @override
  Node parse(BlockParser parser) {
    print("DFFDFDFDFDF");
    return wrapLineNode(lines, parser.current, super.parse(parser));
  }
}
