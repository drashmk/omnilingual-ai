import 'package:chat/api/api_client.dart';
import 'package:chat/model/chat_message.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class AiChat {
  final ApiClient apiClient = ApiClient();

  Future<ChatMessage> sendMessage(
      List<types.Message> messages, Map<String, String> config) async {
    List<Map<String, String>> chatMessages = [];
    for (final message in messages) {
      if (message.metadata != null &&
          message.metadata!.containsKey('chat_message')) {
        ChatMessage chatMessage = message.metadata!['chat_message'];
        chatMessages.add({
          'role': message.author.id,
          'content': chatMessage.aiInputMessage
        });
      }
    }
    final List<Map<String, String>> reversed =
        chatMessages.reversed.toList(growable: false);

    return apiClient.sendChatRequest(reversed, config);
  }
}
