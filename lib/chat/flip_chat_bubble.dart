import 'package:chat/chat/chat_bubble.dart';
import 'package:chat/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_flip_card/flutter_flip_card.dart';

class FlipChatBubble extends StatefulWidget {
  final Widget child;
  final types.Message message;
  final bool isSender;
  final nextMessageInGroup;

  const FlipChatBubble(
      {super.key,
      required this.child,
      required this.message,
      required this.isSender,
      required this.nextMessageInGroup});

  @override
  State<FlipChatBubble> createState() => _FlipChatBubbleState();
}

class _FlipChatBubbleState extends State<FlipChatBubble> {
  final controller = FlipCardController();
  bool isFront = true;

  void _flipBubble() {
    controller.flipcard();
    setState(() {
      isFront = !isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    ChatMessage chatMessage = widget.message.metadata!['chat_message'];
    return AnimatedSize(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 200),
      child: FlipCard(
        rotateSide: RotateSide.bottom,
        onTapFlipping: false,
        axis: FlipAxis.vertical,
        controller: controller,
        frontWidget: ChatBubble(
          message: chatMessage.translatedMessage,
          onPressed: _flipBubble,
          nextMessageInGroup: widget.nextMessageInGroup,
          isSender: widget.isSender,
          hasTranslation:
              chatMessage.aiInputMessage != chatMessage.translatedMessage,
          buttonText: 'Original',
        ),
        backWidget: ChatBubble(
          message: chatMessage.aiInputMessage,
          onPressed: _flipBubble,
          nextMessageInGroup: widget.nextMessageInGroup,
          isSender: widget.isSender,
          hasTranslation:
              chatMessage.aiInputMessage != chatMessage.translatedMessage,
          buttonText: 'Translation',
        ),
      ),
    );
  }
}
