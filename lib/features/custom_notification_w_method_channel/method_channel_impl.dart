import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNotificationMethodChannelImplPage extends StatefulWidget {
  const CustomNotificationMethodChannelImplPage({super.key});

  @override
  State<CustomNotificationMethodChannelImplPage> createState() => _CustomNotificationMethodChannelImplPageState();
}

class _CustomNotificationMethodChannelImplPageState extends State<CustomNotificationMethodChannelImplPage> {
  final MethodChannel m = const MethodChannel('CUSTOMNOTIFICATION');

  @override
  void initState() {
    super.initState();
  }


  Future<void> _initializeMethodChannel() async {
    await m.invokeMethod<String>('showNotification');
    // final String result = await m.invokeMethod('getWifiInfo',{"text":text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Notification')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: TextButton(
                  onPressed: (){
                    _initializeMethodChannel();
                  },
                  child: const Text('Show Notification'),),),
        ],
      ),
    );
  }
}
