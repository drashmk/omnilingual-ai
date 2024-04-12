import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class ChatBubbleContent extends StatelessWidget {
  final String content;

  final bool isSender;

  const ChatBubbleContent(
      {super.key,
      required this.content,
      this.isSender = false});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: content,
      styleSheet: MarkdownStyleSheet(
          textAlign: isSender ? WrapAlignment.end : WrapAlignment.start,
          p: const TextStyle(color: Colors.white)),
      selectable: true,
      shrinkWrap: true,
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        <md.InlineSyntax>[
          md.EmojiSyntax(),
          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
        ],
      ),
    );
  }
}
