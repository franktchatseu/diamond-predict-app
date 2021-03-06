
import 'package:flutter/material.dart';

import 'content_card.dart';
import 'gooey_carousel.dart';

class GooeyEdgeDemo extends StatefulWidget {
  GooeyEdgeDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GooeyEdgeDemoState createState() => _GooeyEdgeDemoState();
}

class _GooeyEdgeDemoState extends State<GooeyEdgeDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GooeyCarousel(
        children: <Widget>[
          ContentCard(
            color: 'Red',
            altColor: Color(0xFF4259B2),
            title: "Prédire le Prix de votre Diamand",
            subtitle: 'Predict the Price of your Diamond',
          ),
          ContentCard(
            color: 'Blue',
            altColor: Color(0xFF904E93),
            title: "Savourez le fruit d'une intélligence artificiel",
            subtitle:
            'Savor the fruit of artificial intelligence.',
          ),
          ContentCard(
            color: 'Yellow',
            altColor: Color(0xFFFFB138),
            title: "Faites votre prédiction en un clic",
            subtitle:
            'Make your prediction in one click.',
          ),
        ],
      ),
    );
  }
}