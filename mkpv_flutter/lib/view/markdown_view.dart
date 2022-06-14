import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_mkpv/view/markdown_view_model.dart';
import 'package:markdown/markdown.dart';

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

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      mini: true,
      onPressed: viewModel.onTapMode,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<bool>(
          valueListenable: viewModel.darkModeNotifier,
          builder: (_, isDark, __) {
            if (isDark) return const Icon(Icons.dark_mode);
            return const Icon(Icons.light_mode);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.loadingNotifier,
      builder: (_, isLoading, __) {
        if (isLoading) return const SizedBox();
        return Scaffold(
          floatingActionButton: _floatingActionButton(),
          body: SingleChildScrollView(
            controller: viewModel.scrollController,
            padding: const EdgeInsets.all(16),
            child: ValueListenableBuilder<String>(
              valueListenable: viewModel.markdownNotofier,
              builder: (_, markdown, __) {
                return MarkdownBody(
                  data: markdown,
                  extensionSet: ExtensionSet.gitHubWeb,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
