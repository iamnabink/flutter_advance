import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stackoverflow/test.dart';

import 'common.dart';
import 'home.dart';

// How do you create and initialize an object asynchronously,
// but access it synchronously in the rest of the app?
Future<void> main() async {
  final sharedPref = await SharedPreferences.getInstance();
  runApp(ProviderScope(
      overrides: [sharedPreferenceProvider.overrideWithValue(sharedPref)],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF2d2d2d),
      ),
      builder: (context, child) {
        final theme = Theme.of(context);

        return ProviderScope(
          overrides: [
            /// We override "themeProvider" with a valid theme instance.
            /// This allows providers such as "tagThemeProvider" to read the
            /// current theme, without having a BuildContext.
            themeProvider.overrideWithValue(theme),
          ],
          child: ListTileTheme(
            textColor: const Color(0xFFe7e8eb),
            child: child!,
          ),
        );
      },
      home: const MyHomePage(),
    );
  }
}
