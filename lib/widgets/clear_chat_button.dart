import 'package:chat/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClearChatButton extends StatefulWidget {
  const ClearChatButton({super.key});

  @override
  State<ClearChatButton> createState() => _ClearChatButtonState();
}

class _ClearChatButtonState extends State<ClearChatButton> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.read<SettingsProvider>();

    return IconButton(
        tooltip: 'Clear chat',
        onPressed: () {
          settingsProvider.clearMessages();
        },
        icon: const Icon(Icons.delete_forever_outlined));
  }
}
