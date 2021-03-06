import 'package:diamond_app/form_ui/form_diamond.dart';
import 'package:flutter/material.dart';
import 'introduction-page/demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  static String _pkg = "gooey_edge";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GooeyEdgeDemo(title: 'Gooey Edge Demo'),
      routes: <String, WidgetBuilder>{
        '/predict': (BuildContext context) => DiamondForm(),

      },
    );
  }
}

