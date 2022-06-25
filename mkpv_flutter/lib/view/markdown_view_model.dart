import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mkpv/const/css_dark.dart';
import 'package:flutter_mkpv/const/css_light.dart';
import 'package:flutter_mkpv/syntax/syntax.dart';
import 'package:markdown/markdown.dart' as mk;
import 'package:mkpv_socket/mkpv_socket.dart';
import 'package:mkpv_socket/socket/socket_server.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MarkdownViewModel {
  final ValueNotifier<bool> loadingNotifier = ValueNotifier(true);
  late MkpvSocket socket;
  void init() async {
    socket = await MkpvSocket.connect();
    socket.addListener(onData: onData);
    socket.send(Request.connect());
    initStyle();
    loadingNotifier.value = false;
  }

  void onData(Request request) {
    switch (request.type) {
      case RequestType.connect:
        break;
      case RequestType.scroll:
        // TODO: line converto to id.
        jumpToScroll("${request.data}");
        break;
      case RequestType.update:
        updateMarkdown(request.data);
        return;
      case RequestType.close:
        exit(0);
    }
  }

  void dispose() {
    socket.dispose();
  }

  final ValueNotifier<String> markdownNotofier = ValueNotifier("");
  void updateMarkdown(String data) {
    markdownNotofier.value = parsingMarkdown(data);
  }

  // parsing Markdown
  // Wrap Node with id by [Element].
  // when scroll to scope through id.
  String parsingMarkdown(String data) {
    if (data.isEmpty) return "";
    final splitLines = data.replaceAll('\r\n', '\n').split('\n');
    // final doc = mk.Document(extensionSet: mk.ExtensionSet.gitHubWeb);
    final doc = mk.Document(
      withDefaultBlockSyntaxes: false,
      extensionSet: mk.ExtensionSet.none,
      blockSyntaxes: [
        mk.HeaderSyntax(),
        // MKEmptySyntax(),
        // MKSetextHeaderSyntax(splitLines),
        // MKHeaderSyntax(splitLines),
        // MKFencedCodeBolckSyntax(splitLines),
        // MKUnorderedListSyntax(splitLines),
        // MKOrderedListSyntax(splitLines),
        // MKTableSyntax(splitLines),
        // MKParagraphSyntax(splitLines),
      ],
    );
    final res = mk.HtmlRenderer().render(doc.parseLines(splitLines));
    print(res);
    return res;
  }

  final AutoScrollController scrollController = AutoScrollController();
  final GlobalKey anchorKey = GlobalKey();
  void jumpToScroll(String id) {
    final anchor = AnchorKey.forId(anchorKey, id)?.currentContext;
    if (anchor == null) return;
    Scrollable.ensureVisible(anchor);
  }

  late Map<String, Style> _light;
  late Map<String, Style> _dark;
  void initStyle() {
    _light = Style.fromCss(cssLight, onCssParseError);
    _dark = Style.fromCss(cssDark, onCssParseError);
  }

  final ValueNotifier<bool> darkModeNotifier = ValueNotifier(false);
  bool get isDark => darkModeNotifier.value;
  void onTapMode() {
    darkModeNotifier.value = !darkModeNotifier.value;
  }

  Color get background =>
      isDark ? const Color(0xFF0d1117) : const Color(0xFFFFFFFF);

  Map<String, Style> get style {
    if (isDark) {
      return _dark;
    }
    return _light;
  }

  String? onCssParseError(String css, List errors) {
    return "hello err";
  }

  void onTapLink(String? url, RenderContext context,
      Map<String, String> attributes, dynamic element) {
    if (url == null) return;
    launchUrlString(url);
  }

  void onAnchorTap(String? url, RenderContext context,
      Map<String, String> attributes, dynamic element) {}
}
