import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/generated/l10n.dart';
import 'package:xno_game_ui/provider/language_provider.dart';
import 'package:xno_game_ui/utils/constants.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IconButton(
        onPressed: () => languageProvider.changeLanguage(),
        icon: const Icon(
          Icons.language,
          color: white,
          size: 24,
        ),
        tooltip: S.of(context).changeLanguage,
      ),
    );
  }
}
