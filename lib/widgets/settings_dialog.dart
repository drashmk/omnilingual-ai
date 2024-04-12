import 'package:chat/const/ai_models.dart';
import 'package:chat/const/languages.dart';
import 'package:chat/providers/settings_provider.dart';
import 'package:chat/widgets/ai_model_dropdown.dart';
import 'package:chat/widgets/language_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
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
    final settingsProvider = context.read<SettingsProvider>();
    settingsProvider.userLanguage.removeListener(_userLanguageHandler);
    settingsProvider.aiLanguage.removeListener(_aiLanguageHandler);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.read<SettingsProvider>();

    return AlertDialog(
      title: const Text('Settings'),
      elevation: 12,
      content: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 360),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('AI Model'),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 180, minWidth: 80),
                    child: AiModelDropdown(
                      onChanged: (model) {
                        if (model != null) {
                          settingsProvider.setAiModel(model.code);
                        }
                      },
                      selectedValue: aiModels.singleWhere((element) =>
                          element.code == settingsProvider.aiModel),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('AI Language'),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 180, minWidth: 80),
                    child: LanguageDropdown(
                      onChanged: (language) {
                        if (language != null) {
                          settingsProvider.setAiLanguage(language.code);
                        }
                      },
                      selectedLanguage: languages
                          .singleWhere((element) => element.code == aiLanguage),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('User Language'),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 180, minWidth: 80),
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
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
