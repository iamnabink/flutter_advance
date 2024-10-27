import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpeedStreamPage extends StatefulWidget {
  const SpeedStreamPage({super.key});

  @override
  _SpeedStreamPageState createState() => _SpeedStreamPageState();
}

class _SpeedStreamPageState extends State<SpeedStreamPage> {
  static const EventChannel _eventChannel = EventChannel('SPEEDSTREAM');
  Stream<Map<String, dynamic>>? _speedStream;

  @override
  void initState() {
    super.initState();
    _speedStream = _eventChannel.receiveBroadcastStream().map(_convertToMap);
  }

  Map<String, dynamic> _convertToMap(dynamic event) {
    if (event is Map) {
      return Map<String, dynamic>.from(event);
    } else {
      throw ArgumentError('Expected a Map<String, dynamic> but received $event');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Speed Test'),
      ),
      body: Center(
        child: StreamBuilder<Map<String, dynamic>>(
          stream: _speedStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final downSpeed = snapshot.data!['downSpeed'];
              final upSpeed = snapshot.data!['upSpeed'];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Download speed: $downSpeed Kbps'),
                  Text('Upload speed: $upSpeed Kbps'),
                ],
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}
