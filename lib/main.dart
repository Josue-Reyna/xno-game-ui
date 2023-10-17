import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:xno_game_ui/generated/l10n.dart';
import 'package:xno_game_ui/l10n/l10n.dart';
import 'package:xno_game_ui/provider/language_provider.dart';
import 'package:xno_game_ui/provider/room_data_provider.dart';
import 'package:xno_game_ui/screens/create_room_screen.dart';
import 'package:xno_game_ui/screens/game_board.dart';
import 'package:xno_game_ui/screens/game_screen.dart';
import 'package:xno_game_ui/screens/join_room_screen.dart';
import 'package:xno_game_ui/screens/main_menu_screen.dart';
import 'package:xno_game_ui/screens/same_device_screen.dart';
import 'package:xno_game_ui/utils/constants.dart';

Future<void> main() async {
  await dotenv.load(fileName: "dotenv");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RoomDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        ),
      ],
      builder: (context, _) {
        final languageProvider = Provider.of<LanguageProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'X\'s & O\'s',
          theme: ThemeData(
            fontFamily: 'PressStart2P',
            brightness: Brightness.dark,
            scaffoldBackgroundColor: backgroundColor,
            dialogBackgroundColor: backgroundColor,
            snackBarTheme: const SnackBarThemeData(
              contentTextStyle: TextStyle(
                color: white,
                fontFamily: 'PressStart2P',
              ),
            ),
          ),
          routes: {
            MainMenuScreen.route: (context) => const MainMenuScreen(),
            CreateRoomScreen.route: (context) => const CreateRoomScreen(),
            JoinRoomScreen.route: (context) => const JoinRoomScreen(),
            SameDeviceScreen.route: (context) => const SameDeviceScreen(),
            GameScreen.route: (context) => const GameScreen(),
            GameBoard.route: (context) => const GameBoard(),
          },
          supportedLocales: L10n.all,
          locale: Locale(languageProvider.whatLanguage),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: MainMenuScreen.route,
        );
      },
    );
  }
}
