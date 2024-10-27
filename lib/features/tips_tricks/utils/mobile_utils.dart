import 'dart:io';

import 'package:flutter/foundation.dart';

//
bool isCanvasKitRenderer() {
  // Use defaultTargetPlatform and klsWeb
  // * * * will explode on web *:
  if (Platform.isIOS) {}
  // Checking upfront for kIsWeb will prevent a runtime error when running on Flutter web
  if (!kIsWeb && Platform.isIOS) {}
  // Instead, use defaultTargetPlatform from foundation.dart, which, unlike 3rd party packages,
  // allows tree-shaking of your conditional code
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {}
  // for more : https://github.com/gskinnerTeam/flutter-universal-platform
  // for more : https://github.com/gskinnerTeam/flutter-universal-platform/issues/29
  return false;
}
