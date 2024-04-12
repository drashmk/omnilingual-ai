import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:chat/chat/chat_config.dart';
import 'package:chat/chat/chat_ui.dart';
import 'package:chat/widgets/clear_chat_button.dart';
import 'package:chat/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  Future<void> _showSettingsDialog(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext buildContext) => const SettingsDialog());
  }

  Future<void> _showAboutDialog(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) => const AboutDialog(
              applicationLegalese:
                  'Omnilingual AI: Engage in natural conversations with AI, write and get responses in your language and model of choice.\n'
                  '\n\n'
                  'Developed for the Cloudflare AI Challenge by Dragan Atanasov.\n'
                  'www.datanasov.com hello@datanasov.com',
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        )),
        elevation: 8,
        automaticallyImplyLeading: true,
        centerTitle: true,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
        leading: IconButton(
            tooltip: 'Settings',
            onPressed: () {
              _showSettingsDialog(context);
            },
            icon: const Icon(Icons.settings_outlined)),
        actions: [
          IconButton(
              tooltip: 'About',
              onPressed: () {
                _showAboutDialog(context);
              },
              icon: const Icon(Icons.info_outline)),
          IconButton(
              tooltip: 'Toggle Theme',
              onPressed: () {
                AdaptiveTheme.of(context).toggleThemeMode();
              },
              icon: const Icon(Icons.brightness_medium_outlined)),
          const ClearChatButton(),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: const Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: ChatUi(),
                ),
                Positioned(left: 8, right: 8, top: 16, child: ChatConfig())
              ],
            )),
      ),
    );
  }
}
