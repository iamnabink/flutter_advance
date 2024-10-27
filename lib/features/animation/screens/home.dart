import 'package:flutter/material.dart';
import 'package:flutter_advance/features/animation/shared/screenTitle.dart';
import 'package:flutter_advance/features/animation/shared/tripList.dart';

class TweenAnimation extends StatefulWidget {
  const TweenAnimation({super.key});

  @override
  _TweenAnimationState createState() => _TweenAnimationState();
}

class _TweenAnimationState extends State<TweenAnimation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Tween Animation')),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topLeft,
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            SizedBox(
              height: 160,
              child: ScreenTitle(text: 'Tween Animation'),
            ),
            Flexible(
              child: TripList(),
            ),
            //Sandbox(),
          ],
        ),
      ),
    );
  }
}

