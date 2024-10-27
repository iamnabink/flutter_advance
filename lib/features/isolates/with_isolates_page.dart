import 'dart:isolate';
import 'package:flutter/material.dart';
// ref: https://mr-soserious.medium.com/beyond-the-main-thread-isolates-in-flutter-development-9e57e628dfd2
class WithIsolatePage extends StatefulWidget {
  const WithIsolatePage({super.key});

  @override
  State<WithIsolatePage> createState() => _WithIsolatePageState();
}

class _WithIsolatePageState extends State<WithIsolatePage> {
  int value = 0;

  // Imagine this method performs a CPU-intensive task
  void heavyTask(int n) {
    final receivePort = ReceivePort();

    // Create an isolate and pass the receivePort's sendPort
    Isolate.spawn(isolateFunction, receivePort.sendPort);

    // Listen for messages from the isolate
    receivePort.listen((message) {
      setState(() {
        value = message as int;
      });
    });
  }

  static void isolateFunction(SendPort sendPort) {
    // Simulate a time-consuming task
    final result = heavyComputation(1000000000);

    // Send the result back to the main thread
    sendPort.send(result);
  }

  static int heavyComputation(int n) {
    int z = n;
    for (var i = 0; i < n; i++) {
      i % 2 == 0 ? z-- : z += 3;
    }
    return z + n;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 22),
            Text(
              'Value is: ',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '$value',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => heavyTask(1000000000),
        tooltip: 'Value',
        child: const Icon(Icons.add),
      ),
    );
  }
}