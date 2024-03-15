import 'package:flutter/material.dart';

///Basic Theme for the application
ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge!.copyWith(
        fontFamily: "Roboto",
        fontSize: 57.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      displayMedium: base.displayMedium!.copyWith(
        fontFamily: "Roboto",
        fontSize: 45.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      displaySmall: base.displaySmall!.copyWith(
        fontFamily: "Roboto",
        fontSize: 36.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      headlineLarge: base.headlineLarge!.copyWith(
        fontFamily: "Roboto",
        fontSize: 32.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      headlineMedium: base.headlineMedium!.copyWith(
        fontFamily: "Roboto",
        fontSize: 28.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      headlineSmall: base.headlineSmall!.copyWith(
        fontFamily: "Roboto",
        fontSize: 24.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      titleLarge: base.titleLarge!.copyWith(
        fontFamily: "Roboto",
        fontSize: 22.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: base.titleMedium!.copyWith(
        fontFamily: "Roboto",
        fontSize: 16.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.15,
      ),
      titleSmall: base.titleSmall!.copyWith(
        fontFamily: "Roboto",
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.1,
      ),
      labelLarge: base.labelLarge!.copyWith(
        fontFamily: "Roboto",
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.1,
      ),
      labelMedium: base.labelMedium!.copyWith(
        fontFamily: "Roboto",
        fontSize: 12.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5,
      ),
      labelSmall: base.labelSmall!.copyWith(
        fontFamily: "Roboto",
        fontSize: 11.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5,
      ),
      bodyLarge: base.bodyLarge!.copyWith(
        fontFamily: "Roboto",
        fontSize: 16.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.15,
      ),
      bodyMedium: base.bodyMedium!.copyWith(
        fontFamily: "Roboto",
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
      ),
      bodySmall: base.bodySmall!.copyWith(
        fontFamily: "Roboto",
        fontSize: 12.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.4,
      ),
    );
  }

  ///
  final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.white,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    secondary: const Color(0xFF017BFE),
    error: Colors.red,
    onError: Colors.red,
    tertiary: Colors.grey.shade400,
    onTertiary: Colors.grey.shade200,
    background: Colors.grey.shade300,
    onBackground: Colors.blue.shade100,
    surface: Colors.grey.shade700,
    onSurface: Colors.black,
  );

  ///base theme as light theme
  final ThemeData base = ThemeData.light();

  //return primary theme data
  return ThemeData(
    //Giving colorscheme to themeData here
    //To access all predefined colors through Theme.of(context).colorScheme
    textTheme: _basicTextTheme(base.textTheme),
    iconTheme: IconThemeData(color: colorScheme.onPrimary),
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(),
      fillColor: Colors.white,
      hintStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: const Color(0xffF2F2F7),
    secondaryHeaderColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(colorScheme.secondary),
        backgroundColor: MaterialStateProperty.all(
          colorScheme.secondary.withOpacity(0.2),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.secondary,
      centerTitle: false,
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      titleTextStyle: const TextStyle(
          fontFamily: "Roboto",
          fontSize: 18.0,
          // color: crayola,
          fontWeight: FontWeight.bold),
      toolbarTextStyle: const TextStyle(
        fontFamily: "Roboto",
        fontSize: 18.0,
        // color: crayola,
        fontWeight: FontWeight.bold,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: const TextStyle(color: Colors.orangeAccent),
      unselectedLabelColor: Colors.blue.shade50,
      unselectedLabelStyle: const TextStyle(color: Colors.black),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(
            width: 1,
            color: colorScheme.secondary,
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size(150, 40)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: BorderSide(
              width: 3,
              color: colorScheme.secondary,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        overlayColor: MaterialStateProperty.all(colorScheme.surface),
        foregroundColor: MaterialStateProperty.all(colorScheme.onSecondary),
        backgroundColor: MaterialStateProperty.all(colorScheme.secondary),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(
            double.maxFinite,
            45,
          ),
        ),
        // shadowColor: MaterialStateProperty.all(colorScheme.background),
        elevation: MaterialStateProperty.all<double>(0),
      ),
    ),
    colorScheme: colorScheme,
  );
}


