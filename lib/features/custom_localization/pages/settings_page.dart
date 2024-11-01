import 'package:flutter/material.dart';
import 'package:flutter_advance/features/custom_localization/classes/language.dart';
import 'package:flutter_advance/features/custom_localization/localization/language_constants.dart';
import 'package:flutter_advance/features/custom_localization/main.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    // MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'settings')),
      ),
      body: Container(
        child: Center(
            child: DropdownButton<Language>(
          iconSize: 30,
          hint: Text(getTranslated(context, 'change_language')),
          onChanged: ( language) {
           if(language != null) _changeLanguage(language);
          },
          items: Language.languageList()
              .map<DropdownMenuItem<Language>>(
                (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(e.name)
                    ],
                  ),
                ),
              )
              .toList(),
        )),
      ),
    );
  }
}
