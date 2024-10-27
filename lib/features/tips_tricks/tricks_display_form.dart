import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_advance/features/tips_tricks/utils/utils.dart';


class TricksDisplayForm extends StatefulWidget {
  const TricksDisplayForm({super.key});

  @override
  State<TricksDisplayForm> createState() => _TricksDisplayFormState();
}

class _TricksDisplayFormState extends State<TricksDisplayForm> {
  @override
  Widget build(BuildContext context) {
    isCanvasKitRenderer(); // what does it prints?
    return const Scaffold(
      body: Column(
        children: [
          // TextField with Selection Height Style
          TextField(
            //Boxes based on the strut will have consistent heights
            // throughout the entire paragraph.
            selectionHeightStyle: BoxHeightStyle.strut,
            // selectionHeightStyle: BoxHeightStyle.tight,
          )
        ],
      ),
    );
  }
}
