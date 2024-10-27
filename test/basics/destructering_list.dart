import 'package:flutter/foundation.dart';

// It is now possible to destructure using Dart 3. This code is now valid:
void main() {
  final [first, ...last] = [11, 2, 3, 4, 51];
  if (kDebugMode) {
    print(first); // 1
    print(last); // 5
  }
}
