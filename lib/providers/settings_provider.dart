import 'dart:convert';
import 'dart:ui';

import 'package:chat/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class SettingsProvider {
  ValueNotifier<String> userLanguage =
      ValueNotifier(PlatformDispatcher.instance.locale.languageCode);
  ValueNotifier<String> aiLanguage =
      ValueNotifier(PlatformDispatcher.instance.locale.languageCode);

  String aiModel = '@hf/thebloke/openhermes-2.5-mistral-7b-awq';

  String aiSystemMessage = 'You are a friendly assistant';

  List<String> chatMessages = [];
  ValueNotifier<List<types.Message>> messages = ValueNotifier([]);

  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();

  SettingsProvider() {
    initSettings();
  }

  Future<void> initSettings() async {
    final prefs = await instanceFuture;
    userLanguage.value = prefs.getString('userLanguage') ?? userLanguage.value;
    aiLanguage.value = prefs.getString('aiLanguage') ?? userLanguage.value;
    aiModel = prefs.getString('aiModel') ??
        '@hf/thebloke/openhermes-2.5-mistral-7b-awq';
    initMessages();
  }

  Future<void> setUserLanguage(String language) async {
    final prefs = await instanceFuture;
    userLanguage.value = language;
    prefs.setString('userLanguage', language);
  }

  Future<void> setAiLanguage(String language) async {
    final prefs = await instanceFuture;
    aiLanguage.value = language;
    prefs.setString('aiLanguage', language);
  }

  Future<void> saveMessages() async {
    final prefs = await instanceFuture;
    chatMessages.clear();
    messages.value.asMap().forEach((index, value) =>
        chatMessages.insert(index, json.encode(value.toJson())));
    prefs.setStringList('messages', chatMessages);
  }

  Future<void> addMessage(types.Message message, {int index = 0}) async {
    messages.value.insert(index, message);
    await saveMessages();
  }

  Future<void> clearMessages() async {
    final prefs = await instanceFuture;
    chatMessages.clear();
    messages.value.clear();
    messages.notifyListeners();
    prefs.setStringList('messages', chatMessages);
  }

  Future<void> initMessages() async {
    final prefs = await instanceFuture;
    chatMessages = prefs.getStringList('messages') ?? [];
    messages.value.clear();
    List<types.Message> list = [];
    chatMessages.asMap().forEach((index, value) {
      types.Message message = types.Message.fromJson(json.decode(value));
      if (message.metadata!.containsKey('chat_message')) {
        message.metadata!['chat_message'] =
            ChatMessage.fromJson(message.metadata!['chat_message']);
        list.insert(index, message);
      }
    });

    messages.value.addAll(list);
    messages.notifyListeners();
  }

  Future<void> setAiModel(String model) async {
    final prefs = await instanceFuture;
    aiModel = model;
    prefs.setString('aiModel', model);
  }

  Map<String, String> getApiConfig() => {
        'model': aiModel,
        'systemMessage': aiSystemMessage,
        'userLanguage': userLanguage.value,
        'aiLanguage': aiLanguage.value
      };
}
