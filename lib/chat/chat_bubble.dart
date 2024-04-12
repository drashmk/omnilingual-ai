import 'package:chat/chat/bubble_background.dart';
import 'package:chat/chat/chat_bubble_content.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isSender;
  final nextMessageInGroup;
  final VoidCallback? onPressed;
  final String message;

  final bool hasTranslation;

  final String buttonText;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.isSender,
      required this.nextMessageInGroup,
      required this.onPressed,
      required this.hasTranslation,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: BubbleBackground(
          colors: [
            if (isSender) ...[
              Colors.blue.shade400,
              Colors.deepPurple.shade800,
            ] else ...[
              Colors.red.shade400,
              Colors.blue.shade800,
            ],
          ],
          child: DefaultTextStyle.merge(
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ChatBubbleContent(content: message),
                  hasTranslation
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                          ),
                          onPressed: onPressed,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(buttonText,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  )),
                              const Icon(
                                Icons.arrow_right_alt_outlined,
                                size: 14,
                              )
                            ],
                          ))
                      : Container()
                ],
              ),
            ),
          ),
        ));
  }
}
