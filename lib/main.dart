import 'package:flutter/material.dart';
import 'package:swifty_companion/pages/home.dart';
import 'package:swifty_companion/pages/signin.dart';
import 'package:swifty_companion/pages/profil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swifty_companion/config/theme.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print('Error loading environment file: $e');
  }

  runApp(MaterialApp(
    initialRoute: '/signin',
    routes: {
      '/': (context) => Home(),
      '/profil': (context) => Profil(),
      '/signin': (context) => SignIn(),
    },
    theme: AppTheme.theme,
  ));
}
