import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mkpv/const/css_dark.dart';
import 'package:flutter_mkpv/const/css_light.dart';
import 'package:html/dom.dart';
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
        // jumpToScroll(request.data);
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
    markdownNotofier.value = wrapHTML(data);
  }

  String wrapHTML(String data) {
    return '''
      <body>
      $data
      </body>
        ''';
  }

  final AutoScrollController scrollController = AutoScrollController();
  void jumpToScroll(int line) {
    // scrollController.scrollToIndex(line,
    //     preferPosition: AutoScrollPosition.middle);
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
    print(url);
    print("@#@#@#");
    if (url == null) return;
    launchUrlString(url);
  }

  void onAnchorTap(String? url, RenderContext context,
    Map<String, String> attributes, dynamic element) {
    print("@@#");
  }
}
