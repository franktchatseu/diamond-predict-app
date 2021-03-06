import 'dart:convert';

import 'package:diamond_app/form_ui/rounded_shadow.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

//
class DiamondForm extends StatefulWidget {
  @override
  _DiamondFormState createState() => _DiamondFormState();
}

class _DiamondFormState extends State<DiamondForm> {

  List<dynamic> cuts = [
    {
      'label': "Fair",
      'value':1
    },
    {
      'label': "Good",
      'value':2
    },
    {
      'label': "Very Good",
      'value':3
    },
    {
      'label': "Premium",
      'value':4
    },
    {
      'label': "Ideal",
      'value':5
    }
  ];

  dynamic _cut;

  //color list
  List<dynamic> colors = [
    {
      'label': "D (meilleur)",
      'value':1
    },
    {
      'label': "E",
      'value':2
    },
    {
      'label': "F",
      'value':3
    },
    {
      'label': "G",
      'value':4
    },
    {
      'label': "H",
      'value':5
    },
    {
      'label': "I",
      'value':4
    },
    {
      'label': "J (médiocre)",
      'value':4
    }
  ];
  dynamic _color;
  //clarety list
  List<dynamic> clareties = [
    {
      'label': "IF (meilleur)",
      'value':1
    },
    {
      'label': "VVS1",
      'value':2
    },

    {
      'label': "VVS2",
      'value':3
    },
    {
      'label': "VS1",
      'value':4
    },
    {
      'label': "I1",
      'value': 8
    }
    ,
    {
      'label': "VS2",
      'value': 5
    }
    ,

    {
    'label': "SI2",
    'value':7
    },
    {
      'label': "SI1 (médiocre)",
      'value':6
    },
  ];
  dynamic _clarety;
  //other proprety
  double _carat_name;
  double _depth;
  double _table;
  double _length;
  double _width;
  double _z_depth;

  bool loader = false;
  //dialog result
  void show_dialog(BuildContext con,dynamic result) {
    showDialog(
        context: con,
        builder: (con) => AssetGiffyDialog(
          key: Key('Asset'),
          image: Image.asset('images/rappi_basket.gif'),
          title: Text(
            "Hello !!!",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          description: Text(
            'le Prix estimé est de ${result} \$ ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, fontFamily: 'Google Sans'),
          ),
          entryAnimation: EntryAnimation.TOP_LEFT,
          onOkButtonPressed: () {
            //go to add etablish screen
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, "/predict");

          },
          onlyOkButton: true,
          buttonOkColor: Colors.teal.shade500,
          buttonOkText: Text(
            "Continuez à estimer",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Google Sans'),
          ),
        ));
  }

  // get prediction
   Future<void> prediction() async {
      this.setState(() {
        this.loader = true;
      });
     String url_server = 'https://diamondspricepredict.herokuapp.com/prediction-api';
     var data = {
       'carat': this._carat_name,
       "depth": this._depth,
       'table': this._table,
       'cut': this._cut['value'],
       'color': this._color['value'],
       'clarity': this._clarety['value'],
       'x': this._length,
       'y': _width,
       'z': _z_depth
     };
     print(data);

     var dio = new Dio();
     dio.options.contentType = Headers.formUrlEncodedContentType;
     final response = await dio.post(url_server, data: data,options: Options(
         followRedirects: false,
         validateStatus: (status) {
           return status <= 500;
         }
     ));
     if(response.statusCode ==200){
       print(response.data);
       var result=response.data["predict"];
       print(result);
       show_dialog(context,result);
     }
     else{
       print(response.data);

       showDialog(
           context: context,
           builder: (context) => AlertDialog(
             content: Text("Erreur de prédiction!"),
           ));
     }
     this.setState(() {
       this.loader = false;
     });
   }

  @override
  Widget build(BuildContext context) {
    double headerHeight = MediaQuery.of(context).size.height *.2 ;
    return Scaffold(
      drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.teal.shade500,Colors.amber.shade200])
                  ),
                  child: Center(
                    child: Container(
                      height: 140,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          image: DecorationImage(
                            fit:BoxFit.cover,
                            image: NetworkImage("https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__340.png"),
                          )
                      ),
                    )
                  )
              ),
              ListTile(
                leading: Icon(Icons.favorite_border,color: Colors.red,),
                title: Text('A Propos de nous',style: TextStyle(fontSize: 17,color: Colors.teal.shade900,fontFamily: 'Google Sans'),),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(Icons.settings,color: Colors.teal,),
                title: Text('Contact',style: TextStyle(fontSize: 17,color: Colors.teal.shade900,fontFamily: 'Google Sans'),),
                onTap: () {

                },
              ),
              ListTile(
                leading: Icon(Icons.settings,color: Colors.teal,),
                title: Text('Notre Team',style: TextStyle(fontSize: 17,color: Colors.teal.shade900,fontFamily: 'Google Sans'),),
                onTap: () {

                },
              ),
            ],
          ),),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Estimer le prix de votre diamand",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.asset("images/Header-Dark.png",fit: BoxFit.cover,)),
            ),
          ];
        },

        body: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Entrer le carat",
                    style: TextStyle(
                        fontFamily: "Google Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal.shade900),
                  ),
                  SizedBox(
                    height: 15,
                  ),
//vidéo link
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1.5, color: Colors.blueGrey),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,

                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Google Sans',
                          color: Colors.black87),
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          hintText: "enter the carat value",
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          hintStyle: TextStyle(fontSize: 16),
                          border: InputBorder.none),
                      onChanged: (value) {
                        setState(() {
                          this._carat_name = double.parse(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Entrer le Depth",
                    style: TextStyle(
                        fontFamily: "Google Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal.shade900),
                  ),
                  SizedBox(
                    height: 15,
                  ),
//vidéo link
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1.5, color: Colors.blueGrey),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,

                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Google Sans',
                          color: Colors.black87),
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          hintText: "enter the depth value",
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          hintStyle: TextStyle(fontSize: 16),
                          border: InputBorder.none),
                      onChanged: (value) {
                        setState(() {
                          this._depth = double.parse(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Entrer le Table",
                    style: TextStyle(
                        fontFamily: "Google Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal.shade900),
                  ),
                  SizedBox(
                    height: 15,
                  ),
//vidéo link
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1.5, color: Colors.blueGrey),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Google Sans',
                          color: Colors.black87),
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          hintText: "enter the table value",
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          hintStyle: TextStyle(fontSize: 16),
                          border: InputBorder.none),
                      onChanged: (value) {
                        setState(() {
                          this._table = double.parse(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " qualité de la coupure",
                    style: TextStyle(
                        fontFamily: "Google Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal.shade900),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1.5, color: Colors.blueGrey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: DropdownButton<dynamic>(
                        value: _cut,
                        hint: Text("Diamant bien taillé ?"),
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 35,
                          color: Colors.teal.shade900,
                        ),
                        isExpanded: true,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Google Sans',
                            color: Colors.black),
                        items: this.cuts.map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value: value,
                            child: Text(value["label"]),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            this._cut = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Préciser la couleur",
                    style: TextStyle(
                        fontFamily: "Google Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal.shade900),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1.5, color: Colors.blueGrey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: DropdownButton<dynamic>(
                        value: _color,
                        hint: Text("choose the color "),
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 35,
                          color: Colors.teal.shade900,
                        ),
                        isExpanded: true,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Google Sans',
                            color: Colors.black),
                        items: this.colors.map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value: value,
                            child: Text(value["label"]),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            this._color = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Clarté",
                    style: TextStyle(
                        fontFamily: "Google Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal.shade900),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1.5, color: Colors.blueGrey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: DropdownButton<dynamic>(
                        value: _clarety,
                        hint: Text("Purety "),
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 35,
                          color: Colors.teal.shade900,
                        ),
                        isExpanded: true,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Google Sans',
                            color: Colors.black),
                        items: this.clareties.map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value: value,
                            child: Text(value["label"]),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            this._clarety = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1.5, color: Colors.blueGrey),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Google Sans',
                            color: Colors.black87),
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            hintText: "length (mm)",
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            hintStyle: TextStyle(fontSize: 16),
                            border: InputBorder.none),
                        onChanged: (value) {
                          setState(() {
                            this._length = double.parse(value);
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1.5, color: Colors.blueGrey),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Google Sans',
                            color: Colors.black87),
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            hintText: "width (mm)",
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            hintStyle: TextStyle(fontSize: 16),
                            border: InputBorder.none),
                        onChanged: (value) {
                          setState(() {
                            this._width = double.parse(value);
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1.5, color: Colors.blueGrey),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Google Sans',
                            color: Colors.black87),
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            hintText: "depth (mm)",
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            hintStyle: TextStyle(fontSize: 16),
                            border: InputBorder.none),
                        onChanged: (value) {
                          setState(() {
                            this._z_depth = double.parse(value);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
              child: this.loader == false?FlatButton(
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.teal.shade500,
                  onPressed: () => {
                    prediction()
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Estimer le Prix",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white,
                            fontFamily: 'Google Sans'),
                      )
                    ],
                  )):CupertinoActivityIndicator(radius: 25,animating: true,),
            ),


          ],
        ),
      ),
    );
  }
}
