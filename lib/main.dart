import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ltr/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  // initialize hive
  await Hive.initFlutter();

  await Hive.openBox('subjects');

  runApp(const MyApp());
}

// change the name MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            background: Colors.white,
            onBackground: Colors.black,
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
      home: const Home(),
    );
  }
}
