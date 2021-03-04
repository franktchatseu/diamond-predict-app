import 'package:flutter/material.dart';
import 'introduction-page/demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  static String _pkg = "gooey_edge";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GooeyEdgeDemo(title: 'Gooey Edge Demo'),
    );
  }
}

