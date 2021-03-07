import 'package:diamond_app/about-team/blend_mask.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './indie_3d_model_controller.dart';
import './indie_3d_model.dart';

class _Indie3dTextClipper extends CustomClipper<Rect> {
  final double y;
  final double height;

  _Indie3dTextClipper({this.y = 0, this.height = 0});

  @override
  getClip(Size size) {
    return Rect.fromLTWH(0, height + y, size.width, size.height - height);
  }

  @override
  bool shouldReclip(_Indie3dTextClipper oldClipper) {
    return true;
  }
}

class Indie3dPage extends StatelessWidget {
  final String topTitle;
  final String bottomTitle;
  final Color backgroundColor;
  final ImageProvider image;
  final int pageIndex;
  final double bottomTitleScale;

  final contact;

  final Indie3dModelController controller;

  final double topTitleClipProgress;
  final double bottomTitleClipProgress;
  final double backgroundShapeOpacity;

  Indie3dPage({
    this.topTitle = "",
    this.bottomTitle = "",
    this.contact,
    this.backgroundColor,
    this.image,
    this.pageIndex = 0,
    this.controller,
    this.topTitleClipProgress = 0.0,
    this.bottomTitleClipProgress = 0.0,
    this.bottomTitleScale = 1.0,
    this.backgroundShapeOpacity = 0.85,
  });

  @override
  Widget build(context) {
    final appSize = MediaQuery.of(context).size;
    final textScale = appSize.aspectRatio > 1? 1.15 : .8;
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          if (controller.initialized) ... {
            BlendMask(
              blendMode: BlendMode.hardLight,
              opacity: backgroundShapeOpacity,
              child: Indie3dModel(controller: controller, pageIndex: pageIndex * 2 + 0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: appSize.height * (appSize.aspectRatio > 1? 1 : .80),
                child: Image(fit: BoxFit.fitHeight, image: image),
              ),
            ),
            BlendMask(
              blendMode: BlendMode.exclusion,
              child: Indie3dModel(controller: controller, pageIndex: pageIndex * 2 + 1),
            ),
            Align(
              alignment: Alignment.topRight,
              child: BlendMask(
                blendMode: BlendMode.difference,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 60, 8, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildClippedText(topTitle, topTitleClipProgress, 75 * textScale, 0, 6, 1),
                      SizedBox(
                        height: 10,
                      ),
                      _buildClippedText(bottomTitle, bottomTitleClipProgress, 50 * textScale * bottomTitleScale, 0, 8, .9),
                    ],
                  ),
                ),
              ),
            ),
            BlendMask(
              opacity: 0.24,
              blendMode: BlendMode.colorDodge,
              child: Image(
                width: appSize.width,
                fit: BoxFit.none,
                image: AssetImage('images/noise.png',),
              ),
            ),
          } else ... {
            Center(
              child: Text(
                'Loading assets...',
                style: TextStyle(
                  letterSpacing: 1.1,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          },
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0x00000000), const Color(0x99000000)],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 60),
              child: InkWell(
                onTap: (){
                  showDialog(context: context,builder: (context) {
                    return AlertDialog(

                      backgroundColor: Colors.teal,
                      content: Container(
                        height: 300,
                        child: SafeArea(
                            child: Column(
                              //change the size of column
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            children: [

                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Data Scientist",
                                                style: TextStyle(
                                                    fontFamily: 'Source Sans Pro',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    letterSpacing: 2.5),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            children: [

                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Mobile Developer",
                                                style: TextStyle(
                                                    fontFamily: 'Source Sans Pro',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    letterSpacing: 2.5),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [

                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Web Developer",
                                                style: TextStyle(
                                                    fontFamily: 'Source Sans Pro',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    letterSpacing: 2.5),
                                              ),
                                            ],
                                          ),


                                        ],
                                      ),

                                    ],
                                  ),

                                ),
                                SizedBox(
                                  child: Divider(
                                    color: Colors.teal.shade50,
                                    height: 20,
                                  ),
                                ),
                                Card(
                                    color: Colors.white,
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.phone,
                                        size: 20,
                                        color: Colors.teal,
                                      ),
                                      title: Text(
                                        this.contact["tel"],
                                        style: TextStyle(
                                            color: Colors.teal.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'Source Sans Pro'),
                                      ),
                                    )),
                                Card(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),

                                    color: Colors.white,
                                    child: ListTile(

                                      title: Text(
                                        this.contact["email"],
                                        style: TextStyle(
                                            color: Colors.teal.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily: 'Source Sans Pro'),
                                      ),
                                    )),
                                Card(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    color: Colors.white,
                                    child:    RichText(
                                        text: TextSpan(
                                            children: [

                                              TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.green.shade700,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                      fontFamily: 'Source Sans Pro'),
                                                  text: this.contact["github"],
                                                  recognizer: TapGestureRecognizer()..onTap =  () async{
                                                    var url = this.contact["github"];
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  }
                                              ),
                                            ]
                                        ))),
                              ],
                            )),
                      ),
                    );
                  },);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  color: Colors.white,
                  child: Text(
                    'CONTACT',
                    style: TextStyle(
                      letterSpacing: 1.1,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ClipRect _buildClippedText(String text, double progress, double fontSize, double yOffset, double spacing, double height) {
    return ClipRect(
      clipper: _Indie3dTextClipper(height: progress * fontSize, y: yOffset),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Staatliches',
          letterSpacing: spacing,
          height: height,
          color: Colors.white,
        ),
      ),
    );
  }
}
