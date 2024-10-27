// import 'package:flutter/material.dart';
// import 'package:flutter_advance/features/custom_localization/localization/demo_localization.dart';
// import 'package:flutter_advance/features/custom_localization/router/custom_router.dart';
// import 'package:flutter_advance/features/custom_localization/router/route_constants.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
//
// import 'localization/language_constants.dart';
//
//
// class LocalizationPage extends StatefulWidget {
//   const LocalizationPage({Key? key}) : super(key: key);
//   static void setLocale(BuildContext context, Locale newLocale) {
//     _LocalizationPageState? state = context.findAncestorStateOfType<_LocalizationPageState>();
//     state?.setLocale(newLocale);
//   }
//
//   @override
//   _LocalizationPageState createState() => _LocalizationPageState();
// }
//
// class _LocalizationPageState extends State<LocalizationPage> {
//   late Locale _locale;
//   setLocale(Locale locale) {
//     setState(() {
//       _locale = locale;
//     });
//   }
//
//   @override
//   void didChangeDependencies() {
//     getLocale().then((locale) {
//       setState(() {
//         this._locale = locale;
//       });
//     });
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (this._locale == null) {
//       return Container(
//         child: Center(
//           child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!)),
//         ),
//       );
//     } else {
//       return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: "Flutter Localization Demo",
//         theme: ThemeData(primarySwatch: Colors.blue),
//         locale: _locale,
//         supportedLocales: [
//           Locale("en", "US"),
//           Locale("fa", "IR"),
//           Locale("ar", "SA"),
//           Locale("hi", "IN")
//         ],
//         localizationsDelegates: [
//           DemoLocalization.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ],
//         localeResolutionCallback: (locale, supportedLocales) {
//           for (var supportedLocale in supportedLocales) {
//             if (supportedLocale.languageCode == locale?.languageCode &&
//                 supportedLocale.countryCode == locale?.countryCode) {
//               return supportedLocale;
//             }
//           }
//           return supportedLocales.first;
//         },
//         onGenerateRoute: CustomRouter.generatedRoute,
//         initialRoute: homeRoute,
//       );
//     }
//   }
// }
