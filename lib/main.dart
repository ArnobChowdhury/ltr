import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:ltr/screens/home.dart';
import 'package:ltr/screens/editor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltr/routes.dart';
import 'package:ltr/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize hive
  await HiveService.init();

  runApp(const LTR());
}

// change the name MyApp
class LTR extends StatelessWidget {
  const LTR({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LTR',
        theme: ThemeData(
            textTheme: GoogleFonts.rubikTextTheme(),
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color(0xFF2B2B2B),
              onPrimary: Colors.white,
              secondary: Color(0xFF55786C),
              onSecondary: Colors.white,
              tertiary: Color(0xFF6F5D83),
              onTertiary: Colors.black,
              error: Colors.red,
              onError: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade800),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            // textButtonTheme: TextButtonThemeData(
            //     style: TextButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(5.0)))),
            dialogTheme: const DialogTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))))),
        // darkTheme: ThemeData(), // overwrite for dark theme
        themeMode: ThemeMode.light, // for theme change
        // home: const Home(),
        routes: {
          Routes.home: (context) => const Home(),
          Routes.editor: (context) => const Editor(),
        },
        localizationsDelegates: const [
          AppFlowyEditorLocalizations.delegate
        ]);
  }
}
