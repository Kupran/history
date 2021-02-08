import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:questbook/UserInfoGlaf.dart';

import 'Scenes.dart';

class InputName extends StatefulWidget {
  List maps;
  List listParametrsInt;
  List listParametrName;
  bool withAnimal;
  String wardrobeName;
  String onMesseng;
  String onMusic;
  String language;
  String nameHero;
  String nameAnimal;
  int diamonds;
  String nameAudio;
  String saveOrder;
  String episodedocumentID;
  int keyy;
  List listParametrsUserAll;
  // List<Scene> listScenes;
  String storyDocumentId;
  InputName(
      this.wardrobeName,
      this.nameHero,
      this.nameAnimal,
      this.nameAudio,
      // this.listScenes,
      this.episodedocumentID,
      this.saveOrder,
      this.keyy,
      this.diamonds,
      this.language,
      this.onMesseng,
      this.onMusic,
      this.storyDocumentId,
      this.withAnimal,
      this.listParametrName,
      this.listParametrsInt,
      this.listParametrsUserAll,
      map);
  @override
  StateInputName createState() => StateInputName();
}

class StateInputName extends State<InputName> {
  FocusNode focusNode = FocusNode();
  FocusNode focusNodeQ = FocusNode();
  TextEditingController nameHeroInput = new TextEditingController();
  TextEditingController nameAnimalInput = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
            color: Color.fromRGBO(86, 0, 39, 1),
            height: height,
            width: width,
            child: Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.085, left: width * 0.07),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.13,
                        child: Center(
                          child: Icon(Icons.arrow_back,
                              color: Colors.white, size: height * 0.04),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(179, 68, 108, 1),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(height * 100),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        // musicPlay('nameAudi', 2);
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: height * 0.3,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: width * 0.005,
                            color: Color.fromRGBO(175, 238, 238, 1)),
                        // color: Colors.blue,
                        borderRadius: BorderRadius.circular(height * 0.02)),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            height: height * 0.1,
                            width: width * 0.7,
                            child: TextFormField(
                              maxLength: 12,
                              onChanged: (a) {
                                widget.nameHero = a;
                              },

                              // maxLengthEnforced: false,
                              // textDirection: ,
                              style: TextStyle(
                                  color: Color.fromRGBO(239, 222, 205, 1)),
                              focusNode: focusNode,
                              controller: nameHeroInput,
                              cursorColor: Color.fromRGBO(175, 238, 238, 1),
                              decoration: InputDecoration(
                                  counterStyle: TextStyle(color: Colors.white),
                                  fillColor: Color.fromRGBO(175, 238, 238, 1),
                                  focusColor: Color.fromRGBO(175, 238, 238, 1),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(175, 238, 238, 1),
                                        width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(175, 238, 238, 1),
                                        width: 2),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color.fromRGBO(175, 238, 238, 1),
                                  )),
                                  labelText: 'Имя персонажа',
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(239, 222, 205, 1),
                                  )),
                            ),
                          ),
                          widget.withAnimal
                              ? Container(
                                  padding: EdgeInsets.only(top: 10),
                                  height: height * 0.1,
                                  width: width * 0.7,
                                  child: TextFormField(
                                    onChanged: (name) {
                                      widget.nameAnimal = name;
                                    },
                                    maxLength: 12,

                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(239, 222, 205, 1)),
                                    focusNode: focusNodeQ,
                                    controller: nameAnimalInput,
                                    cursorColor:
                                        Color.fromRGBO(175, 238, 238, 1),
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        counterStyle:
                                            TextStyle(color: Colors.white),
                                        fillColor:
                                            Color.fromRGBO(175, 238, 238, 1),
                                        focusColor:
                                            Color.fromRGBO(175, 238, 238, 1),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  175, 238, 238, 1),
                                              width: 2),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  175, 238, 238, 1),
                                              width: 2),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  175, 238, 238, 1),
                                              width: 2),
                                        ),
                                        labelText: 'Имя животного',
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(239, 222, 205, 1),
                                        )),
                                  ),
                                )
                              : Container(),
                          Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: InkWell(
                                onTap: () async {
                                  if (nameAnimalInput.text.length > 12 ||
                                      nameHeroInput.text.length > 12 ||
                                      focusNodeQ.hasFocus ||
                                      focusNode.hasFocus) {
                                  } else {
                                    if (widget.withAnimal == true) {
                                      if (nameAnimalInput.text.length < 1 ||
                                          nameAnimalInput.text.length > 12 ||
                                          nameHeroInput.text.length < 1 ||
                                          nameHeroInput.text.length > 12) {
                                      } else {
                                        widget.nameAnimal =
                                            nameAnimalInput.text;
                                        widget.nameHero = nameHeroInput.text;
                                        // setState(() {

                                        // });
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(userFireBase.uid)
                                            .collection('history')
                                            .doc(widget.episodedocumentID)
                                            .update({
                                          "save_order": widget.saveOrder,
                                          "nameHero": nameHeroInput.text,
                                          "nameAnimal": nameAnimalInput.text,
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ScenesState(
                                                  widget.wardrobeName,
                                                  widget.nameHero,
                                                  widget.nameAnimal,
                                                  widget.nameAudio,
                                                  // listScenes,
                                                  widget.episodedocumentID,
                                                  widget.saveOrder,
                                                  widget.keyy,
                                                  widget.diamonds,
                                                  widget.language,
                                                  widget.onMesseng,
                                                  widget.onMusic,
                                                  widget.storyDocumentId,
                                                  widget.listParametrName,
                                                  widget.listParametrsInt,
                                                  widget.listParametrsUserAll,
                                                  widget.maps),
                                            ));
                                      }
                                    } else {
                                      if (nameHeroInput.text.length < 1 ||
                                          nameHeroInput.text.length > 12) {
                                      } else {
                                        setState(() {
                                          widget.nameAnimal =
                                              nameAnimalInput.text;
                                          widget.nameHero = nameHeroInput.text;
                                        });
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(userFireBase.uid)
                                            .collection('history')
                                            .doc(widget.episodedocumentID)
                                            .update({
                                          "save_order": widget.saveOrder,
                                          "nameHero": nameHeroInput.text,
                                          "nameAnimal": nameAnimalInput.text,
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ScenesState(
                                                  widget.wardrobeName,
                                                  widget.nameHero,
                                                  widget.nameAnimal,
                                                  widget.nameAudio,
                                                  // listScenes,
                                                  widget.episodedocumentID,
                                                  widget.saveOrder,
                                                  widget.keyy,
                                                  widget.diamonds,
                                                  widget.language,
                                                  widget.onMesseng,
                                                  widget.onMusic,
                                                  widget.storyDocumentId,
                                                  widget.listParametrName,
                                                  widget.listParametrsInt,
                                                  widget.listParametrsUserAll,
                                                  widget.maps),
                                            ));
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  height: height * 0.05,
                                  width: width * 0.3,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(179, 68, 108, 1),
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          height * 0.005)),
                                  child: Center(
                                    child: Text(
                                      "Сохранить",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
