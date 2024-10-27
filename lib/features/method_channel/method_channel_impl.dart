import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelImplPage extends StatefulWidget {
  const MethodChannelImplPage({super.key});

  @override
  State<MethodChannelImplPage> createState() => _MethodChannelImplPageState();
}

class _MethodChannelImplPageState extends State<MethodChannelImplPage> {
  final MethodChannel m = const MethodChannel('WIFIINFO');

  @override
  void initState() {
    _initializeMethodChannel();
    super.initState();
  }

  String? wifiInfo;

  Future<void> _initializeMethodChannel() async {
    final w = await m.invokeMethod<String>('getWifiInfo');
    // final String result = await m.invokeMethod('getWifiInfo',{"text":text});

    setState(() {
      wifiInfo = w;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battery Health')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: TextButton(
                  onPressed: _initializeMethodChannel,
                  child: const Text('Know Bettery Health'),),),
          Text(wifiInfo ?? ''),
        ],
      ),
    );
  }
}
