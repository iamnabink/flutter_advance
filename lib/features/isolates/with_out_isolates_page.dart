import 'package:flutter/material.dart';

// ref: https://mr-soserious.medium.com/beyond-the-main-thread-isolates-in-flutter-development-9e57e628dfd2

class WithoutIsolatePage extends StatefulWidget {
  const WithoutIsolatePage({super.key});

  @override
  State<WithoutIsolatePage> createState() => _WithoutIsolatePageState();
}

class _WithoutIsolatePageState extends State<WithoutIsolatePage> {
  int value = 0;

  // Imagine this method performs a CPU-intensive task
  void heavyTask(int n) {
    int z = n;
    for (var i = 0; i < n; i++) {
      i % 2 == 0 ? z-- : z += 3;
    }
    setState(() {
      value = z + n;
    });
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