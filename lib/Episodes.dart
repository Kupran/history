import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:provider/provider.dart';

import 'InputName.dart';
import 'Object.dart';
import 'Scenes.dart';
import 'Shop.dart';
import 'UserInfoGlaf.dart';

class Episodes extends StatefulWidget with WidgetsBindingObserver {
  List listParametr;
  bool withAnimal;
  String onClickMeseng;
  String onClickMusic;
  String nameHERO;
  String nameANIMAL;
  int keyy;
  int diamonds;
  String language;
  List<Episode> listEpisodes;
  String storyDocumentID;
  var mapSave;

  Episodes(
      this.listEpisodes,
      this.mapSave,
      this.keyy,
      this.diamonds,
      this.language,
      this.nameHERO,
      this.nameANIMAL,
      this.onClickMeseng,
      this.onClickMusic,
      this.storyDocumentID,
      this.withAnimal,
      this.listParametr);

  @override
  Episodestate createState() => Episodestate(this.listEpisodes, this.mapSave,
      this.keyy, this.diamonds, this.language, this.storyDocumentID);
}

class Nimp {
  String name;
  String description;
  String imageUrl;
  String imageName;
  String nameAudio;
  String urlAudio;
  String language;
  // List<Scene> listScenes;
  String episodeDocumentId;

  Nimp(
    this.name,
    this.description,
    this.language,
    this.imageUrl,
    this.imageName,
    // this.listScenes,
    this.nameAudio,
    this.urlAudio,
    this.episodeDocumentId,
  );
}

class Episodestate extends State<Episodes> {
  LoopPageController controller = new LoopPageController();
  var mapSave;
  int keyy;
  int diamonds;
  String language;
  List<Episode> listEpisodes;
  String storyDocumentID;

  Episodestate(
    this.listEpisodes,
    this.mapSave,
    this.keyy,
    this.diamonds,
    this.language,
    this.storyDocumentID,
  );
  String nameHERO;
  String nameANIMAL;
  // int key;
  String description;

  var nameAudio;
  var listScenes;
  var scenes;
  int index;
  String order;
  String name;
  String save_order;
  var babki;
  List<Nimp> listSort = List();
  var image;
  String episodedocumentID;
  String wardrobeName;
  List listParametrUser = List();
  functiaListParametrsPerebor() {
    listParametrUser.clear();
    for (var i = 0; i < widget.listParametr.length; i++) {
      listParametrUser.add(0);
    }
  }

  @override
  void initState() {
    super.initState();
    functiaListParametrsPerebor();
    print(widget.onClickMeseng);
    print(widget.onClickMusic);
    print(language);
    functiaPereborStories(language);
    description = listSort[0].description;
    nameAudio = listSort[0].nameAudio;
    image = listSort[0].imageName;
    // listScenes = listSort[0].listScenes;
    print(listSort.length);
    name = listSort[0].name;
    episodedocumentID = listSort[0].episodeDocumentId;
  }

  functiaPereborStories(String language) {
    listSort.clear();
    for (var t = 0; t < widget.listEpisodes.length; t++) {
      for (var i = 0; i < widget.listEpisodes[t].listValues.length; i++) {
        if (widget.listEpisodes[t].listValues[i].language == language) {
          listSort.add(Nimp(
            widget.listEpisodes[t].listValues[i].name,
            widget.listEpisodes[t].listValues[i].description,
            widget.listEpisodes[t].listValues[i].language,
            widget.listEpisodes[t].imageUrl,
            widget.listEpisodes[t].imageName,
            // widget.listEpisodes[t].listScenes,
            widget.listEpisodes[t].nameAudio,
            widget.listEpisodes[t].urlAudio,
            widget.listEpisodes[t].episodeDocumentID,
          ));
        }
      }
    }
  }

  List listParametrInt = List();
  functiaPereborParametr() {
    for (var i = 0; i < widget.listParametr.length; i++) {
      listParametrInt[widget.listParametr[i]] = 0;
    }
    return listParametrInt;
  }

  int priceClothes = 0;
  List listParametrsUserAll = List();
  List maps = List();
  @override
  Widget build(BuildContext context) {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async => false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Nunito",
          ),
          home: Scaffold(
              body: Stack(
            children: [
              Container(
                height: height * 0.6,
                width: width,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: mapSave[image].image,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.085, left: width * 0.07),
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
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.085, right: width * 0.07),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: height * 0.008,
                                        right: width * 0.03),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: height * 0.035,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(86, 0, 39, 0.7),
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              height * 1)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.12),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Shop(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  child: Center(
                                                    child: StreamBuilder(
                                                        stream:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "users")
                                                                .doc(
                                                                    userFireBase
                                                                        .uid)
                                                                .snapshots(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Container(
                                                              child: Text(widget
                                                                  .key
                                                                  .toString()),
                                                            );
                                                          } else {
                                                            diamonds = snapshot
                                                                .data['key'];
                                                            return Container(
                                                              child: Text(
                                                                snapshot
                                                                    .data['key']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        height *
                                                                            0.02),
                                                              ),
                                                            );
                                                          }
                                                        }),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.01),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Shop(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      constraints: BoxConstraints(
                                          minWidth: width * 0.2,
                                          minHeight: height * 0.035),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: height * 0.05,
                                    width: width * 0.11,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        // border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(height * 1)),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/key.png",
                                        height: height * 0.04,
                                        // width: 50,
                                        // color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.008),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: height * 0.035,
                                      // width: width * 0.25,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(86, 0, 39, 0.7),
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              height * 1)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.12),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                child: StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("users")
                                                        .doc(userFireBase.uid)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (!snapshot.hasData) {
                                                        return Container(
                                                          child: Text(widget
                                                              .diamonds
                                                              .toString()),
                                                        );
                                                      } else {
                                                        diamonds = snapshot
                                                            .data['diamonds'];
                                                        return Container(
                                                          child: Text(
                                                            snapshot.data[
                                                                    'diamonds']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    height *
                                                                        0.02),
                                                          ),
                                                        );
                                                      }
                                                    }),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.01),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Shop(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: height * 0.025,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      constraints: BoxConstraints(
                                          minWidth: width * 0.2,
                                          minHeight: height * 0.035),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: height * 0.05,
                                    width: width * 0.11,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        // border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(height * 1)),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/diamondsLitle.png",
                                        height: height * 0.05,
                                        // width: 50,
                                        // color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          constraints: BoxConstraints(
                            minHeight: height * 0.05,
                            minWidth: width * 0.45,
                          ),
                        ),
                        onTap: () {
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    color: Color.fromRGBO(86, 0, 39, 1),
                    height: height * 0.4,
                    width: width,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(height * 0.01),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  // color: Colors.red,
                                  height: height * 0.08,
                                  // color: Colors.white,
                                  width: width,
                                  child: ListView(
                                    padding: EdgeInsets.only(top: 0),
                                    children: [
                                      Center(
                                          child: Text(
                                        // name,
                                        description,
                                        style: TextStyle(
                                            fontFamily: 'Nunito-Regular',
                                            fontSize: height * 0.02,
                                            color: Colors.white),
                                      )),
                                    ],
                                  ),
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.0),
                            child: Container(
                              // color: Colors.red,
                              height: height * 0.13,
                              width: width,
                              // color: Colors.red,
                              child: Center(
                                child: LoopPageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  controller: controller,
                                  itemCount: listSort.length,
                                  itemBuilder: (_, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Container(
                                          width: width,
                                          height: height * 0.13,
                                          child: ListView(
                                              padding: EdgeInsets.all(0),
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: height * 0.01,
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      listSort[index].name,
                                                      style: TextStyle(
                                                          fontSize:
                                                              height * 0.03,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                          constraints: BoxConstraints(
                                            minHeight: height * 0.05,
                                          ),
                                        ),
                                      ],
                                    ));
                                  },
                                  onPageChanged: onPageViewChange,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: height * 0.05),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        listParametrsUserAll.clear();
                                        FirebaseAnalytics().logEvent(
                                            name: '$episodedocumentID',
                                            parameters: null);
                                        final firestore =
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(userFireBase.uid)
                                                .collection('history')
                                                .doc(episodedocumentID)
                                                .get();
                                        final firestore1 =
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(userFireBase.uid)
                                                .collection('history')
                                                .doc(widget.storyDocumentID +
                                                    "Wardrobe")
                                                .get();
                                        if (firestore1.data() == null) {
                                          maps.clear();
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userFireBase.uid)
                                              .collection('history')
                                              .doc(widget.storyDocumentID +
                                                  "Wardrobe")
                                              .set({
                                            'ListParametrsUserAll':
                                                listParametrUser,
                                          });
                                          listParametrsUserAll
                                              .addAll(listParametrUser);
                                        } else {
                                          maps.clear();
                                          maps.addAll(firestore1
                                              .data()['ListParametrsUserAll']);
                                          listParametrsUserAll.addAll(firestore1
                                              .data()['ListParametrsUserAll']);
                                        }

                                        if (firestore.data() == null) {
                                          functiaListParametrsPerebor();
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userFireBase.uid)
                                              .collection('history')
                                              .doc(episodedocumentID)
                                              .set({
                                            "save_order": "end",
                                            "nameHero": "end",
                                            "nameAnimal": "end",
                                            "wardrobeName": 'end',
                                            'listParametrs': listParametrUser,
                                          });
                                          save_order = "end";
                                          nameANIMAL = 'end';
                                          nameHERO = 'end';
                                          wardrobeName = 'end';
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => InputName(
                                                  wardrobeName,
                                                  nameHERO,
                                                  nameANIMAL,
                                                  nameAudio,
                                                  // listScenes,
                                                  episodedocumentID,
                                                  save_order,
                                                  keyy,
                                                  diamonds,
                                                  language,
                                                  widget.onClickMeseng,
                                                  widget.onClickMusic,
                                                  widget.storyDocumentID,
                                                  widget.withAnimal,
                                                  widget.listParametr,
                                                  listParametrUser,
                                                  listParametrsUserAll,
                                                  maps),
                                            ),
                                          );
                                        } else {
                                          save_order =
                                              firestore.data()["save_order"];
                                          nameHERO =
                                              firestore.data()['nameHero'];
                                          nameANIMAL =
                                              firestore.data()['nameAnimal'];
                                          wardrobeName =
                                              firestore.data()['wardrobeName'];
                                          listParametrUser =
                                              firestore.data()['listParametrs'];

                                          if (nameHERO == null ||
                                              nameANIMAL == null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => InputName(
                                                    wardrobeName,
                                                    nameHERO,
                                                    nameANIMAL,
                                                    nameAudio,
                                                    // listScenes,
                                                    episodedocumentID,
                                                    save_order,
                                                    keyy,
                                                    diamonds,
                                                    language,
                                                    widget.onClickMeseng,
                                                    widget.onClickMusic,
                                                    widget.storyDocumentID,
                                                    widget.withAnimal,
                                                    widget.listParametr,
                                                    listParametrUser,
                                                    listParametrsUserAll,
                                                    maps),
                                              ),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScenesState(
                                                          wardrobeName,
                                                          nameHERO,
                                                          nameANIMAL,
                                                          nameAudio,
                                                          // listScenes,
                                                          episodedocumentID,
                                                          save_order,
                                                          keyy,
                                                          diamonds,
                                                          language,
                                                          widget.onClickMeseng,
                                                          widget.onClickMusic,
                                                          widget
                                                              .storyDocumentID,
                                                          widget.listParametr,
                                                          listParametrUser,
                                                          listParametrsUserAll,
                                                          maps)),
                                            );
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: height * 0.08,
                                        width: width * 0.6,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(179, 68, 108, 1),
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              height * 0.01),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Играть',
                                            style: TextStyle(
                                                fontSize: height * 0.035,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        listParametrsUserAll.clear();
                                        var list = List();
                                        FirebaseAnalytics().logEvent(
                                            name: '$episodedocumentID',
                                            parameters: null);
                                        final firestore =
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(userFireBase.uid)
                                                .collection('history')
                                                .doc(episodedocumentID)
                                                .get();
                                        final firestore1 =
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(userFireBase.uid)
                                                .collection('history')
                                                .doc(widget.storyDocumentID +
                                                    "Wardrobe")
                                                .get();
                                        if (firestore1.data() == null) {
                                          maps.clear();
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userFireBase.uid)
                                              .collection('history')
                                              .doc(widget.storyDocumentID +
                                                  "Wardrobe")
                                              .set({
                                            'ListParametrsUserAll':
                                                listParametrUser,
                                            "maps": maps
                                          });

                                          listParametrsUserAll
                                              .addAll(listParametrUser);
                                        } else {
                                          maps.addAll(firestore1
                                              .data()['ListParametrsUserAll']);
                                          listParametrsUserAll.addAll(firestore1
                                              .data()['ListParametrsUserAll']);
                                        }
                                        if (firestore.data() == null) {
                                          functiaListParametrsPerebor();
                                          print('несуществует');
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userFireBase.uid)
                                              .collection('history')
                                              .doc(episodedocumentID)
                                              .set({
                                            "save_order": "end",
                                            "nameHero": "end",
                                            "nameAnimal": "end",
                                            "wardrobeName": 'end',
                                            'listParametrs': listParametrUser,
                                          });
                                          save_order = "end";
                                          nameANIMAL = 'end';
                                          nameHERO = 'end';
                                          wardrobeName = 'end';
                                        } else {
                                          List listUserAll = firestore1
                                              .data()['ListParametrsUserAll'];
                                          List listUserEpisodes =
                                              firestore.data()['listParametrs'];
                                          for (var i = 0;
                                              i < listUserAll.length;
                                              i++) {
                                            var d = listUserAll[i];
                                            var r = listUserEpisodes[i] == null
                                                ? 0
                                                : listUserEpisodes[i];
                                            list.add(d - r);
                                          }
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userFireBase.uid)
                                              .collection('history')
                                              .doc(widget.storyDocumentID +
                                                  "Wardrobe")
                                              .update({
                                            'ListParametrsUserAll': list,
                                          });
                                          functiaListParametrsPerebor();
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userFireBase.uid)
                                              .collection('history')
                                              .doc(episodedocumentID)
                                              .set({
                                            "save_order": "end",
                                            "nameHero": "end",
                                            "nameAnimal": "end",
                                            "wardrobeName": 'end',
                                            'listParametrs': listParametrUser,
                                          });
                                          save_order = "end";
                                          nameANIMAL = 'end';
                                          nameHERO = 'end';
                                          wardrobeName = 'end';
                                        }

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => InputName(
                                                  wardrobeName,
                                                  nameHERO,
                                                  nameANIMAL,
                                                  nameAudio,
                                                  // listScenes,
                                                  episodedocumentID,
                                                  save_order,
                                                  keyy,
                                                  diamonds,
                                                  language,
                                                  widget.onClickMeseng,
                                                  widget.onClickMusic,
                                                  widget.storyDocumentID,
                                                  widget.withAnimal,
                                                  widget.listParametr,
                                                  listParametrUser,
                                                  listParametrsUserAll,
                                                  maps),
                                            ));
                                      },
                                      child: Container(
                                        height: height * 0.08,
                                        width: width * 0.2,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(179, 68, 108, 1),
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              height * 0.01),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.restore,
                                            color: Colors.white,
                                            size: height * 0.05,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    )),
              ),
            ],
          )),
        ));
  }

  onPageViewChange(index) {
    description = listSort[index].description;
    name = listSort[index].name;
    episodedocumentID = listSort[index].episodeDocumentId;
    nameAudio = listSort[index].nameAudio;
    // listScenes = listSort[index].listScenes;
  }
}
