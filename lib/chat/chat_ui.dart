import 'dart:convert';
import 'dart:math';

import 'package:chat/chat/flip_chat_bubble.dart';
import 'package:chat/model/chat_message.dart';
import 'package:chat/providers/main_provider.dart';
import 'package:chat/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatUi extends StatefulWidget {
  const ChatUi({super.key});

  @override
  ChatUiState createState() => ChatUiState();
}

class ChatUiState extends State<ChatUi> {
  final _user =
      const types.User(id: 'user', firstName: 'The', lastName: 'User');
  final _system = const types.User(id: 'system', firstName: 'A', lastName: 'I');
  bool isLoading = false;

  Widget _bubbleBuilder(
    Widget child, {
    required message,
    required nextMessageInGroup,
  }) {
    return FlipChatBubble(
      message: message,
      nextMessageInGroup: nextMessageInGroup,
      isSender: _user.id == message.author.id ||
          message.type == types.MessageType.image,
      child: child,
    );
  }

  void _handleSendPressed(types.PartialText message) {
    if (isLoading) {
      return;
    }
    final settingsProvider = context.read<SettingsProvider>();

    ChatMessage chatMessage = ChatMessage(
        aiMessage: message.text,
        translated: message.text,
        userLanguage: settingsProvider.userLanguage.value);
    final textMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: message.text,
        metadata: {'chat_message': chatMessage});

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();

    return Scaffold(
      body: ValueListenableBuilder<List<types.Message>>(
        builder: (BuildContext context, messages, Widget? child) => Chat(
          messages: messages,
          onSendPressed: _handleSendPressed,
          user: _user,
          theme: DefaultChatTheme(
              backgroundColor: Theme.of(context).colorScheme.background,
              inputBackgroundColor:
                  Theme.of(context).colorScheme.inversePrimary,
              inputBorderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              inputTextColor: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .computeLuminance() <
                      0.5
                  ? Colors.white
                  : Colors.black),
          bubbleBuilder: _bubbleBuilder,
          showUserAvatars: false,
          inputOptions: const InputOptions(
              autocorrect: true,
              autofocus: true,
              enableSuggestions: true,
              keyboardType: TextInputType.text,
              sendButtonVisibilityMode: SendButtonVisibilityMode.always
              ),
          typingIndicatorOptions: TypingIndicatorOptions(
              typingMode: TypingIndicatorMode.avatar,
              typingUsers: isLoading ? [_system] : []),
        ),
        valueListenable: settingsProvider.messages,
      ),
    );
  }

  Future<void> _addMessage(types.Message message) async {
    final mainProvider = context.read<MainProvider>();
    final settingsProvider = context.read<SettingsProvider>();

    setState(() {
      isLoading = true;
    });

    settingsProvider.addMessage(message);
    ChatMessage response = await mainProvider.ai.sendMessage(
        settingsProvider.messages.value, settingsProvider.getApiConfig());
    if (response.translatedRequest != null &&
        response.translatedRequest!.isNotEmpty &&
        settingsProvider.messages.value.isNotEmpty) {
      var lastMessage = settingsProvider.messages.value.first;
      ChatMessage chatMessage = lastMessage.metadata!['chat_message'];
      chatMessage.aiMessage = response.translatedRequest;
      settingsProvider.messages.value.removeAt(0);
      settingsProvider.addMessage(lastMessage);
    }
    setState(() {
      isLoading = false;
    });
    settingsProvider.addMessage(types.TextMessage(
        author: _system,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: response.translatedMessage,
        metadata: {'chat_message': response}));
  }
}
