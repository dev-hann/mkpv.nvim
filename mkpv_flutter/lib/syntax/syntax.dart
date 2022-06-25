library mk_syntax;

import 'package:markdown/markdown.dart';

part 'line_syntax_mixin.dart';
part 'syntax_empty.dart';
part 'syntax_header.dart';
part 'syntax_paragraph.dart';
part 'syntax_setext_header.dart';
part 'syntax_table.dart';
part 'syntax_list.dart';
part 'syntax_fenced_code_block.dart';

abstract class MKSyntax extends BlockSyntax {}
