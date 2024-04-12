import 'package:chat/model/chat_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:rest_api_package/rest_api_package.dart';

class ApiClient {
  static const String devUrl = 'http://localhost:8787/api';
  static const String releaseUrl =
      'https://omnilingual-ai.dragan.workers.dev/api';
  late final String apiUrl;
  late final RestApiHttpService restApiClient;
  static final _log = Logger('ApiClient');

  ApiClient() {
    apiUrl = kDebugMode ? devUrl : releaseUrl;
    initClient();
  }

  Future<void> initClient() async {
    _log.info('Init client');
    restApiClient = RestApiHttpService(
      Dio(BaseOptions(
          receiveTimeout: const Duration(seconds: 60),
          connectTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60))),
      apiUrl,
    );
  }

  Future<ChatMessage> sendChatRequest(
      List<Map<String, String>> messages, Map<String, String> config) async {
    _log.info('send request');

    Map<String, dynamic> body = {'messages': messages, 'config': config};
    final chatRequest = RestApiRequest(
      endPoint: '/chat',
      requestMethod: RequestMethod.POST,
      useNewDioInstance: false,
      body: body,
    );

    try {
      return await restApiClient.requestAndHandle(
        chatRequest,
        parseModel: ChatMessage.fromJson,
      );
    } catch (e) {
      return ChatMessage(
          aiMessage: 'Unable to reach the server, please try again later.');
    }
  }
}
