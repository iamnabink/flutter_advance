import 'dart:js' as js;

bool isCanvasKitRenderer() {
  return true;
  return js.context['flutterCanvasKit'] != null;
}
