import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:flutter/material.dart';

import 'package:flutter_advance/features/animation/screens/home.dart';
import 'package:flutter_advance/features/counter/counter.dart';
import 'package:flutter_advance/features/custom_notification_w_method_channel/method_channel_impl.dart';
import 'package:flutter_advance/features/custom_paint/custom_paint.dart';
import 'package:flutter_advance/features/event_channel/event_channel.dart';
import 'package:flutter_advance/features/isolates/with_isolates_page.dart';
import 'package:flutter_advance/features/isolates/with_out_isolates_page.dart';
import 'package:flutter_advance/features/method_channel/method_channel_impl.dart';
import 'package:flutter_advance/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // Checkers and tools to ensure your app is accessible to all
      // app is accessible from day one, by checking your interface as you build it
      home: const AccessibilityTools(child: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return const CounterPage();
              },),);
            }, child: const Text('Counter'),),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return const TweenAnimation();
              },),);
            }, child: const Text('Animation'),),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return const CustomPainPage();
              },),);
            }, child: const Text('CustomPaint'),),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return const SpeedStreamPage();
              },),);
            }, child: const Text('EventChannel'),),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return const MethodChannelImplPage();
              },),);
            }, child: const Text('MethodChannel'),),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return const MethodChannelImplPage();
              },),);
            }, child: const Text('Method Channel With Notification'),),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return const WithoutIsolatePage();
              },),);
            }, child: const Text('WithoutIsolates'),),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return const WithIsolatePage();
              },),);
            }, child: const Text('WithIsolates'),),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return const CustomNotificationMethodChannelImplPage();
              },),);
            }, child: const Text('Custom Notification'),),

            // in-app subscription
            // CI-CD [FastLane]
          ],
        ),
      ),
    );
  }
}
