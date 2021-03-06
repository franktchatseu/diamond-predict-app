import 'package:diamond_app/form_ui/form_diamond.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

const List<Key> keys = [
  Key('Network'),
  Key('Network Dialog'),
  Key('Flare'),
  Key('Flare Dialog'),
  Key('Asset'),
  Key('Asset dialog'),
];

class GifDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Nunito'),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text('Giffy Dialog Example'),
          ),
          body: MyHomePage(),
        ));
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String networkimg =
        'https://cdn.dribbble.com/users/750517/screenshots/8574989/media/7610aa397363fdfe6f2daa1145493aee.gif';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            key: keys[0],
            child: Text('Network Giffy'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => NetworkGiffyDialog(
                    key: keys[1],
                    image: Image.network(
                      networkimg,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      "Bienvenue, Frank",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    description: Text(
                      'Vous êtes actuellement un professionnel. vous pouvez directement créer votre premier établissement',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Google Sans'
                      ),
                    ),
                    entryAnimation: EntryAnimation.RIGHT,
                    onOkButtonPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>EtablishAdd()));

                    },

                    onlyOkButton: true,
                    buttonOkColor: Colors.teal.shade500,
                    buttonOkText: Text("Ajouter votre établissement",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Google Sans'),),
                  ));
            },
          ),
          RaisedButton(
            key: keys[2],
            child: Text('Flare Giffy'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => FlareGiffyDialog(
                    key: keys[3],
                    flarePath: 'assets/space_demo.flr',
                    flareAnimation: 'loading',
                    title: Text(
                      "Bienvenue, Frank",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    description: Text(
                      'Vous êtes actuellement un professionnel. vous pouvez directement créer votre premier établissement',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Google Sans'
                      ),
                    ),
                    entryAnimation: EntryAnimation.TOP_LEFT,
                    onOkButtonPressed: (){},
                  ));
            },
          ),
          RaisedButton(
            key: keys[4],
            child: Text('Asset Giffy'),
            onPressed: () {

              showDialog(
                  context: context,
                  builder: (context) => AssetGiffyDialog(

                    key: keys[5],
                    image: Image.asset('images/rappi_basket.gif'),
                    title: Text(
                      "Bienvenue, Frank",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    description: Text(
                      'Vous êtes actuellement un professionnel. vous pouvez directement créer votre premier établissement',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Google Sans'
                      ),
                    ),
                    entryAnimation: EntryAnimation.TOP_LEFT,
                    onOkButtonPressed: (){
                      //go to add etablish screen
                      Navigator.pop(context);
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>DiamondForm()));
                    },
                    onlyOkButton: true,
                    buttonOkColor: Colors.teal.shade500,
                    buttonOkText: Text("Ajouter votre établissement",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Google Sans'),),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
