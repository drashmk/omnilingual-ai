import 'package:chat/const/languages.dart';
import 'package:chat/providers/settings_provider.dart';
import 'package:chat/theme.dart';
import 'package:chat/widgets/language_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatConfig extends StatefulWidget {
  const ChatConfig({super.key});

  @override
  State<ChatConfig> createState() => _ChatConfigState();
}

class _ChatConfigState extends State<ChatConfig> {
  String aiLanguage = PlatformDispatcher.instance.locale.languageCode;
  String userLanguage = PlatformDispatcher.instance.locale.languageCode;

  void _aiLanguageHandler() {
    final settingsProvider = context.read<SettingsProvider>();

    setState(() {
      aiLanguage = settingsProvider.aiLanguage.value;
    });
  }

  void _userLanguageHandler() {
    final settingsProvider = context.read<SettingsProvider>();
    setState(() {
      userLanguage = settingsProvider.userLanguage.value;
    });
  }

  @override
  void initState() {
    final settingsProvider = context.read<SettingsProvider>();
    setState(() {
      userLanguage = settingsProvider.userLanguage.value;
      aiLanguage = settingsProvider.aiLanguage.value;
    });
    settingsProvider.userLanguage.addListener(_userLanguageHandler);
    settingsProvider.aiLanguage.addListener(_aiLanguageHandler);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    final settingsProvider = context.read<SettingsProvider>();
    settingsProvider.userLanguage.removeListener(_userLanguageHandler);
    settingsProvider.aiLanguage.removeListener(_aiLanguageHandler);
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.read<SettingsProvider>();
    final bgColor = Theme.of(context).colorScheme.primary;
    final textColor = getReadableColor(bgColor);

    return Center(
      child: Theme(
        data: ThemeData(
            iconTheme: Theme.of(context).iconTheme.copyWith(color: textColor),
            textTheme: Theme.of(context).textTheme.copyWith(
                bodyLarge: const TextStyle(color: Colors.black),
                bodySmall: TextStyle(color: textColor),
                bodyMedium: TextStyle(color: textColor))),
        child: Card(
          elevation: 12,
          color: bgColor,
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Tooltip(
                    message: 'AI language',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.smart_toy_outlined),
                        ),
                        ConstrainedBox(
                          constraints:
                              const BoxConstraints(maxWidth: 160, minWidth: 80),
                          child: LanguageDropdown(
                            onChanged: (language) {
                              if (language != null) {
                                settingsProvider.setAiLanguage(language.code);
                              }
                            },
                            selectedLanguage: languages.singleWhere(
                                (element) => element.code == aiLanguage),
                          ),
                        )
                      ],
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Tooltip(
                    message: 'Your language',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ConstrainedBox(
                          constraints:
                              const BoxConstraints(maxWidth: 160, minWidth: 80),
                          child: LanguageDropdown(
                            onChanged: (language) {
                              if (language != null) {
                                settingsProvider.setUserLanguage(language.code);
                              }
                            },
                            selectedLanguage: languages.singleWhere(
                                (element) => element.code == userLanguage),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Icon(Icons.person),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
