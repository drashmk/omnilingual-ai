class ChatMessage {
  String? aiMessage;
  String? translated;
  String? userLanguage;
  String? aiLanguage;
  String? translatedRequest;

  ChatMessage(
      {this.aiMessage,
      this.translated,
      this.userLanguage,
      this.aiLanguage,
      this.translatedRequest});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    aiMessage = json['ai_message'];
    translated = json['translated'];
    userLanguage = json['user_language'];
    aiLanguage = json['ai_language'];
    translatedRequest = json['translated_request'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ai_message'] = aiMessage;
    data['translated'] = translated;
    data['user_language'] = userLanguage;
    data['ai_language'] = aiLanguage;
    data['translated_request'] = translatedRequest;
    return data;
  }

  String get translatedMessage => translated ?? aiInputMessage;

  String get aiInputMessage => aiMessage ?? '';
}
