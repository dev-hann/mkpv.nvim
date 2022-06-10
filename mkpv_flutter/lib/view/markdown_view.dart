import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_mkpv/view/markdown_view_model.dart';
import 'package:markdown/markdown.dart' as md;

class MarkdownView extends StatefulWidget {
  const MarkdownView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MarkdownViewState();
  }
}

class MarkdownViewState extends State<MarkdownView> {
  final MarkdownViewModel viewModel = MarkdownViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.loadingNotifier,
      builder: (_, isLoading, __) {
        if (isLoading) return const SizedBox();
        return Scaffold(
          body: SingleChildScrollView(
            controller: viewModel.scrollController,
            padding: const EdgeInsets.all(16),
            child: ValueListenableBuilder<String>(
              valueListenable: viewModel.markdownNotofier,
              builder: (_, markdown, __) {
                return MarkdownBody(
                  onTapLink: viewModel.onTapLink,
                  data: markdown,
                  selectable: true,
                  extensionSet: md.ExtensionSet.gitHubFlavored,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
