import 'package:flutter/material.dart';

class CustomPainPage extends StatefulWidget {
  const CustomPainPage({super.key});

  @override
  State<CustomPainPage> createState() => _CustomPainPageState();
}

class _CustomPainPageState extends State<CustomPainPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Custom Paint')),
      body: Center(
        child: Container(
          height: 400,
          color: Colors.black,
          width: 500,
          child: Center(
            child: CustomPaint(
              foregroundPainter: CustomPantWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPantWidget extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 4..color = Colors.red;
    canvas.drawCircle(Offset(size.width*0.1, size.height*0.1), 100, paint);
    // canvas.drawRect(Rect.fromPoints(Offset(size.width*0.1, size.height*0.1),Offset(size.width*0.1, size.height*0.1)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
