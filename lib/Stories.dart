import 'dart:async';
import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:card_selector/card_selector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stack_card/flutter_stack_card.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:questbook/firebasebig.dart';
import 'package:questbook/Object.dart';
import 'package:questbook/main.dart';
import 'package:questbook/pushLocal.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Episodes.dart';
import 'Game.dart';
import 'Shop.dart';
import 'UserInfoGlaf.dart';

class Stories extends StatefulWidget {
  List<Story> listStories;
  List<Language> listLanguage;
  String language;
  String onClickMesseng;
  String onClickMusic;
  var hour;
  var minuts;
  var seconds;
  List listStoriesBuy;

  Stories(
    this.listStories,
    this.listLanguage,
    this.language,
    this.onClickMesseng,
    this.onClickMusic,
    this.hour,
    this.minuts,
    this.seconds,
    this.listStoriesBuy,
  );

  @override
  StoriesState createState() =>
      StoriesState(this.language, this.onClickMesseng, this.onClickMusic);
}

class Nimp {
  List listParametrs;
  String name;
  String description;
  String language;
  String imageUrl;
  String imageName;
  bool withAnimal;
  var story_cost;
  // List<Garderob> listGarderob;
  List<Episode> listEpisodes;
  String documentID;

  Nimp(
    this.name,
    this.description,
    this.language,
    this.imageUrl,
    this.imageName,
    this.listEpisodes,
    this.documentID,
    this.withAnimal,
    this.listParametrs,
    this.story_cost,
  );
}

class StoriesState extends State<Stories> {
  String onClickMesseng;
  String onClickMusic;
  String language;
  String nameHERO;
  String nameANIMAL;
  StoriesState(this.language, this.onClickMesseng, this.onClickMusic);

  List<Nimp> listSort = List();
  int yun;
  functiaPereborStories(String language) {
    // print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaa');
    if (statusSaveImage == true) {
      print("${widget.listStories.length}" + "Длинна массива 1111");
      listSort.clear();
      for (var t = 0; t < widget.listStories.length; t++) {
        for (var i = 0; i < widget.listStories[t].listValues.length; i++) {
          if (widget.listStories[t].listValues[i].language == language) {
            listSort.add(Nimp(
              widget.listStories[t].listValues[i].name,
              widget.listStories[t].listValues[i].description,
              widget.listStories[t].listValues[i].language,
              widget.listStories[t].imageUrl,
              widget.listStories[t].imageName,
              widget.listStories[t].listEpisodes,
              widget.listStories[t].storyDocumentId,
              widget.listStories[t].withAnimal,
              widget.listStories[t].listValues[i].listParametr,
              widget.listStories[t].price,
              // widget.listStories[t].listGarderob,
            ));
          }
        }
      }
      return listSort;
    } else {
      return;
    }
  }

  bool statusSort = true;
  String c;
  String n;
  int number;
  var episode;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['ca-app-pub-5733111311327578/3537742028'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  var time;
  var times;
  var second;
  var iw = 0;
  int numbeee = 0;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }

  DateTime dateTime = DateTime.now();
  int coins = 0;
  int nameSeee = 0;
  var imageImage;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  RewardedVideoAd videoAdA = RewardedVideoAd.instance;
  // functiaTimeNow([int hour, int minuts, int seconds]) {}
  bool statusTimeSaveNow = false;
  functiaTimeNow() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File fileDay = new File('$dir/day');
    File fileHour = new File('$dir/hour');
    File fileMinuts = new File('$dir/minuts');
    File fileSeconds = new File('$dir/seconds');
    fileHour.delete();
    fileMinuts.delete();
    fileSeconds.delete();
    int minutstut = 0;
    int hourtut = 0;
    int dayTut = 0;
    if (!fileSeconds.existsSync()) {
      var retesttt = dateTime.second + 59;
      if (retesttt > 60) {
        seconds = 59;
        retesttt = retesttt - 60;
        minutstut = 1;
        var bytes = retesttt.toString();
        await fileSeconds.writeAsString(bytes);
      } else {
        seconds = 59;
        var bytes = retesttt.toString();
        await fileSeconds.writeAsString(bytes);
      }
    } else {
      var retesttt = dateTime.second + 59;
      if (retesttt > 60) {
        seconds = 59;
        retesttt = retesttt - 60;
        minutstut = 1;
        var bytes = retesttt.toString();
        await fileSeconds.writeAsString(bytes);
      } else {
        seconds = 59;
        var bytes = retesttt.toString();
        await fileSeconds.writeAsString(bytes);
      }
    }
    if (!fileMinuts.existsSync()) {
      var retesttt = dateTime.minute + 29 + minutstut;
      if (retesttt > 60) {
        minuts = 29;
        retesttt = retesttt - 60;
        hourtut = 1;
        var bytes = retesttt.toString();
        await fileMinuts.writeAsString(bytes);
      } else {
        minuts = 29;
        var bytes = retesttt.toString();
        await fileMinuts.writeAsString(bytes);
      }
    } else {
      var retesttt = dateTime.minute + 29 + minutstut;
      if (retesttt > 60) {
        minuts = 29;
        retesttt = retesttt - 60;
        hourtut = 1;
        var bytes = retesttt.toString();
        await fileMinuts.writeAsString(bytes);
      } else {
        minuts = 29;
        var bytes = retesttt.toString();
        await fileMinuts.writeAsString(bytes);
      }
    }
    if (!fileHour.existsSync()) {
      var retesttt = dateTime.hour + 1 + hourtut;
      if (retesttt > 24) {
        hour = 1;
        retesttt = retesttt - 24;
        dayTut = 1;
        var bytes = retesttt.toString();
        await fileHour.writeAsString(bytes);
      } else {
        hour = 1;
        var bytes = retesttt.toString();
        await fileHour.writeAsString(bytes);
      }
    } else {
      var retesttt = dateTime.hour + 1 + hourtut;
      if (retesttt > 24) {
        hour = 1;
        retesttt = retesttt - 24;
        dayTut = 1;
        var bytes = retesttt.toString();
        await fileHour.writeAsString(bytes);
      } else {
        hour = 1;
        var bytes = retesttt.toString();
        await fileHour.writeAsString(bytes);
      }
    }
    if (!fileDay.existsSync()) {
      var retesttt = dateTime.day + dayTut;
      if (retesttt > 30) {
        retesttt = retesttt - 30;
        var bytes = retesttt.toString();
        await fileDay.writeAsString(bytes);
      } else {
        var bytes = retesttt.toString();
        await fileDay.writeAsString(bytes);
      }
    } else {
      var retesttt = dateTime.day + dayTut;
      if (retesttt > 30) {
        retesttt = retesttt - 30;
        var bytes = retesttt.toString();
        await fileDay.writeAsString(bytes);
      } else {
        var bytes = retesttt.toString();
        await fileDay.writeAsString(bytes);
      }
    }
  }

  bool statusABD;
  bool statusABDspin = false;
  bool withAnimal;
  List listParametrs;
  StreamController<int> streamController = StreamController<int>.broadcast();
  functiaStreamDDDD(String documentId) {
    Stream stream = streamController.stream;
    var d = 0;
    if (widget.listStoriesBuy.length != null) {
      for (var i = 0; i < widget.listStoriesBuy.length; i++) {
        if (documentId == widget.listStoriesBuy[i]) {
          streamController.add(0);
          return stream;
        } else {
          d = d + 1;
        }
      }
    } else {
      streamController.add(12);
      return stream;
    }
    if (d == widget.listStoriesBuy.length) {
      streamController.add(12);
      return stream;
    }
  }

  functiaPereborStoriesListFirebase() {
    for (var i = 0; i < listSort.length; i++) {
      for (var j = 0; j < widget.listStoriesBuy.length; j++) {
        if (listSort[i].documentID == widget.listStoriesBuy[j]) {
          listSort[i].story_cost = 0;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    statusSaveImage = true;
    hour = widget.hour;
    minuts = widget.minuts;
    seconds = widget.seconds;

    functiaPereborStories(language);
    functiaPereborStoriesListFirebase();

    priceStory = listSort[0].story_cost;
    documentId = listSort[0].documentID;
    functiaStreamDDDD(documentId);
    listParametrs = listSort[0].listParametrs;
    c = listSort[0].description;
    n = listSort[0].name;
    withAnimal = listSort[0].withAnimal;
    episode = listSort[0].listEpisodes;

    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-5733111311327578~8777626269");
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print(rewardAmount);
      if (event == RewardedVideoAdEvent.rewarded) {
        if (statusABD == true) {
          setState(() {
            statusTimeSaveNow = true;
            statustime = true;
            // _controller.start();
            coins = rewardAmount;
            hour = 1;
            minuts = 29;
            seconds = 59;
          });
        } else {
          setState(() {
            statusABDspin = true;
            colMini = 5;
          });
        }
      } else if (event == RewardedVideoAdEvent.loaded) {
        RewardedVideoAd.instance.show();
        if (statusABD == true) {
          setState(() {
            statusTimeSaveNow = true;
            statustime = true;
            // _controller.start();
            hour = 1;
            minuts = 29;
            seconds = 59;
          });
        }
      }
    };
  }

  Map mapSave = new Map();
  bool statusTimeE = true;
  bool statusSaveImage = true;

  functiaSaveImage(var height, var width, var hei, var wit) async {
    if (statusSaveImage == true) {
      print('aasdqwwqeqweqweqwe');
      imageCache.clear();
      imageCache.clearLiveImages();
      Map map = new Map();
      Set sett = new Set();
      String dir = (await getApplicationDocumentsDirectory()).path;
      for (var i = 0; i < widget.listStories.length; i++) {
        String nameImage = widget.listStories[i].imageName;
        String nameImageEpisode =
            widget.listStories[i].listEpisodes[0].imageName;
        if (nameImage.isNotEmpty && nameImageEpisode.isNotEmpty) {
          sett.add(nameImage);
          sett.add(nameImageEpisode);
        }
      }
      for (var i in sett) {
        File file = new File('$dir/$i');
        var imagen = await file.readAsBytes();
        var imageB = Image.memory(
          imagen,
          // height: height * 0.25,
          // width: width * 0.8,
          cacheHeight: 1000,
          // cacheHeight: hei,
          // cacheWidth: wit,
          cacheWidth: 800,
          scale: 1,
          repeat: ImageRepeat.noRepeat,
          // filterQuality: FilterQuality.none,
        );
        await precacheImage(
          imageB.image,
          context,
        );
        print(imageCache.currentSizeBytes);

        map[i] = imageB;
      }
      // statusImageInt = 3;
      statustimeE = false;
      statusSaveImage = false;
      return map;
    } else {
      return;
    }
  }

  String timeLev = "";
  int hour;
  int minuts;
  int seconds;

  functiaTimer([int hourr, int minutss, int secondss]) {
    if (hour == 0 && minuts == 0 && seconds == 0) {
      setState(() {
        statustimeEE = false;
        statustime = false;
      });
    } else {
      statustimeEE = true;
    }
    Future.delayed(Duration(seconds: 1), () {
      if (seconds == 0) {
        minuts = minutss - 1;
        seconds = 59;
      } else {
        seconds = secondss - 1;
      }
      if (minuts == 0 && seconds == 0) {
        if (hour == 0) {
          // minuts = 59;
        } else {
          hour = hourr - 1;
          minuts = 59;
          seconds = 59;
        }
      } else {
        // minutsrtp = minutss - 1;
      }
      setState(() {
        timeLev = "0" +
            "$hour" +
            ":" +
            "${minuts < 10 ? "0" : ""}" "$minuts" +
            ":" +
            "${seconds < 10 ? "0" : ""}" +
            "$seconds";
      });
    });
  }

  Set set = Set();
  var status = false;
  var priceStory;

  var image;
  var d;
  var babki;
  int diamonds;
  int keyy;
  var wor = true;
  var documentId;
  bool statustime = true;
  bool statustimeE = true;
  int statusImageInt = 0;

  int colMini = 0;
  bool statusTrue = false;
  bool statustimeEE = true;
  final CustomTimerController _controller = new CustomTimerController();
  @override
  Widget build(BuildContext context) {
    functiaTimer(hour, minuts, seconds);
    functiaPereborStories(language);
    functiaPereborStoriesListFirebase();
    // functiaSaveImageFile();
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var dor = height * 0.25;
    var dir = width * 0.8;
    if (statusABDspin == true) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userFireBase.uid)
          .update({"spin": 5});
      statusABDspin = false;
    }
    return MaterialApp(
      theme: ThemeData(fontFamily: "Nunito"),
      home: Scaffold(
        body: Container(
          height: height,
          width: width,
          color: Color.fromRGBO(86, 0, 39, 1),
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              statusSaveImage == true
                  ? Stack(
                      children: [
                        FutureBuilder(
                          future: functiaSaveImage(
                              height, width, dor.toInt(), dir.toInt()),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                  // color: Colors.white,
                                  height: height,
                                  width: width,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ));
                            } else {
                              mapSave = snapshot.data;
                              image = mapSave;
                              statusTrue = true;
                              return Stack(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: height * 0.20,
                                        // color: Colors.red,
                                        width: width,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 0.05),
                                              child: Container(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: height * 0.05,
                                                      left: height * 0.04),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: InkWell(
                                                        child: Image.asset(
                                                          "assets/logoggogogogogoggogoInsta.png",
                                                          height: height * 0.07,
                                                          // width: 50,
                                                          // color: Colors.red,
                                                        ),
                                                        onTap: () {
                                                          launch(
                                                              // FirebaseAnalytics (). logEvent (имя: 'A_Product', параметры: ноль);
                                                              'https://instagram.com/be_on_toppp?igshid=1mb7t40ncn9a');
                                                        }),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 0.05),
                                              child: Container(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: height * 0.035,
                                                      right: height * 0.03),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: InkWell(
                                                      child: Image.asset(
                                                        "assets/settingsNew.png",
                                                        height: height * 0.09,
                                                        // width: 50,
                                                        // color: Colors.red,
                                                      ),
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (_) {
                                                              return Muisda(
                                                                  widget
                                                                      .listLanguage,
                                                                  language,
                                                                  onClickMesseng,
                                                                  onClickMusic,
                                                                  onLanguageSelect: (String
                                                                          languageState,
                                                                      var onClickMessen,
                                                                      var onClickMusicc) {
                                                                setState(() {
                                                                  statustimeE =
                                                                      true;
                                                                  statusSaveImage =
                                                                      true;
                                                                  onClickMesseng =
                                                                      onClickMessen;
                                                                  onClickMusic =
                                                                      onClickMusicc;
                                                                  // nameSeee = 0;
                                                                  language =
                                                                      languageState;

                                                                  functiaPereborStories(
                                                                      language);
                                                                  functiaPereborStoriesListFirebase();
                                                                  functia(functiaPereborStories(
                                                                      language));
                                                                  functiaPereborStoriesListFirebase();
                                                                  // functiaW();
                                                                  var lenght =
                                                                      listSort.length -
                                                                          1;
                                                                  documentId =
                                                                      listSort[
                                                                              0]
                                                                          .documentID;
                                                                  c = listSort[
                                                                          0]
                                                                      .description;
                                                                  // var g = listSort[lenght]
                                                                  //     .imageName;
                                                                  // statusImageInput = false;
                                                                  // iageGo = mapSave[g].image;
                                                                  n = listSort[
                                                                          0]
                                                                      .name;
                                                                  episode =
                                                                      listSort[
                                                                              0]
                                                                          .listEpisodes;
                                                                });
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .doc(userFireBase
                                                                        .uid)
                                                                    .update({
                                                                  "diamonds":
                                                                      diamonds,
                                                                  "key": keyy,
                                                                  "onClickMesseng":
                                                                      onClickMesseng,
                                                                  "onClickMusic":
                                                                      onClickMusic,
                                                                  "language":
                                                                      language,
                                                                });
                                                              });
                                                            });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // height: height * 0.65,
                                        width: width,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              functia(listSort),
                                              Container(
                                                // height: height * 0.18,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      n.toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              height * 0.03),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.01,
                                                          left: width * 0.1,
                                                          right: width * 0.1),
                                                      child: Container(
                                                          height: height * 0.13,
                                                          // color: Colors.red,
                                                          // width: width,
                                                          child: ListView(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 0),
                                                            children: [
                                                              Text(
                                                                c.toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Nunito-Regular",
                                                                  fontSize:
                                                                      height *
                                                                          0.02,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * 0.03),
                                                child: InkWell(
                                                  onTap: () {
                                                    FirebaseAnalytics().logEvent(
                                                        name:
                                                            'Инста главного экрана',
                                                        parameters: null);
                                                    if (keyy < priceStory) {
                                                    } else {
                                                      keyy = keyy - priceStory;
                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(userFireBase.uid)
                                                          .update(
                                                              {"key": keyy});
                                                      widget
                                                          .listStories[
                                                              indexStories]
                                                          .price = 0;
                                                      listSort[indexStories]
                                                          .story_cost = 0;
                                                      widget.listStoriesBuy
                                                          .add(documentId);

                                                      if (priceStory == 0) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                Episodes(
                                                                    episode,
                                                                    image,
                                                                    keyy,
                                                                    diamonds,
                                                                    language,
                                                                    nameHERO,
                                                                    nameANIMAL,
                                                                    onClickMesseng,
                                                                    onClickMusic,
                                                                    documentId,
                                                                    withAnimal,
                                                                    listParametrs),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    height: height * 0.08,
                                                    width: width * 0.6,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          179, 68, 108, 1),
                                                      border: Border.all(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              height * 0.01),
                                                    ),
                                                    child: Center(
                                                        child: StreamBuilder(
                                                            stream:
                                                                functiaStreamDDDD(
                                                                    documentId),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot.data ==
                                                                      0 ||
                                                                  snapshot.data ==
                                                                      "") {
                                                                return Text(
                                                                    'Играть',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            height *
                                                                                0.035));
                                                              } else {
                                                                return priceStory ==
                                                                        0
                                                                    ? Text(
                                                                        'Играть',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: height * 0.035))
                                                                    : Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            '$priceStory',
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: height * 0.04),
                                                                          ),
                                                                          Image
                                                                              .asset(
                                                                            'assets/key.png',
                                                                            height:
                                                                                height * 0.07,
                                                                          )
                                                                        ],
                                                                      );
                                                              }
                                                            })),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            }
                          },
                        )
                      ],
                    )
                  : Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: height * 0.20,
                              // color: Colors.red,
                              width: width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.05),
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: height * 0.05,
                                            left: height * 0.04),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            child: Image.asset(
                                              "assets/logoggogogogogoggogoInsta.png",
                                              height: height * 0.07,
                                              // width: 50,
                                              // color: Colors.red,
                                            ),
                                            onTap: () => launch(
                                                'https://instagram.com/be_on_toppp?igshid=1mb7t40ncn9a'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.05),
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: height * 0.035,
                                            right: height * 0.03),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            child: Image.asset(
                                              "assets/settingsNew.png",
                                              height: height * 0.09,
                                              // width: 50,
                                              // color: Colors.red,
                                            ),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return Muisda(
                                                        widget.listLanguage,
                                                        language,
                                                        onClickMesseng,
                                                        onClickMusic,
                                                        onLanguageSelect: (String
                                                                languageState,
                                                            var onClickMessen,
                                                            var onClickMusicc) {
                                                      setState(() {
                                                        statusSaveImage = true;
                                                        onClickMesseng =
                                                            onClickMessen;
                                                        onClickMusic =
                                                            onClickMusicc;
                                                        // nameSeee = 0;
                                                        language =
                                                            languageState;

                                                        functiaPereborStories(
                                                            language);
                                                        functiaPereborStoriesListFirebase();
                                                        functia(
                                                            functiaPereborStories(
                                                                language));
                                                        functiaPereborStoriesListFirebase();
                                                        // functiaW();
                                                        var lenght =
                                                            listSort.length - 1;
                                                        documentId = listSort[0]
                                                            .documentID;
                                                        c = listSort[0]
                                                            .description;
                                                        // var g = listSort[lenght]
                                                        //     .imageName;
                                                        // statusImageInput = false;
                                                        // iageGo = mapSave[g].image;
                                                        n = listSort[0].name;
                                                        episode = listSort[0]
                                                            .listEpisodes;
                                                      });
                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(userFireBase.uid)
                                                          .update({
                                                        "diamonds": diamonds,
                                                        "key": keyy,
                                                        "onClickMesseng":
                                                            onClickMesseng,
                                                        "onClickMusic":
                                                            onClickMusic,
                                                        "language": language,
                                                      });
                                                    });
                                                  });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // height: height * 0.2,
                              width: width,
                              child: Center(
                                child: Column(
                                  children: [
                                    functia(listSort),
                                    Container(
                                      // height: height * 0.18,
                                      // color: Colors.red,
                                      child: Column(
                                        children: [
                                          Text(
                                            n.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: height * 0.03),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: height * 0.01,
                                                left: width * 0.1,
                                                right: width * 0.1),
                                            child: Container(
                                                height: height * 0.13,
                                                // color: Colors.red,
                                                // width: width,
                                                child: ListView(
                                                  padding:
                                                      EdgeInsets.only(top: 0),
                                                  children: [
                                                    Text(
                                                      c.toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Nunito-Regular",
                                                        fontSize: height * 0.02,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: height * 0.03),
                                      child: InkWell(
                                        onTap: () {
                                          if (keyy < priceStory) {
                                          } else {
                                            keyy = keyy - priceStory;

                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(userFireBase.uid)
                                                .update({"key": keyy});
                                            widget.listStories[indexStories]
                                                .price = 0;
                                            listSort[indexStories].story_cost =
                                                0;
                                            widget.listStoriesBuy
                                                .add(documentId);
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(userFireBase.uid)
                                                .collection('history')
                                                .doc('StoriesBuy')
                                                .update({
                                              "storiesBuy":
                                                  widget.listStoriesBuy
                                            });
                                            // functiaStreamDDDD(documentId);
                                            if (priceStory == 0) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Episodes(
                                                          episode,
                                                          image,
                                                          keyy,
                                                          diamonds,
                                                          language,
                                                          nameHERO,
                                                          nameANIMAL,
                                                          onClickMesseng,
                                                          onClickMusic,
                                                          documentId,
                                                          withAnimal,
                                                          listParametrs),
                                                ),
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
                                              child: StreamBuilder(
                                                  stream: functiaStreamDDDD(
                                                      documentId),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.data == 0 ||
                                                        snapshot.data == "") {
                                                      return Text('Играть',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: height *
                                                                  0.035));
                                                    } else {
                                                      return priceStory == 0
                                                          ? Text('Играть',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      height *
                                                                          0.035))
                                                          : Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  '$priceStory',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          height *
                                                                              0.04),
                                                                ),
                                                                Image.asset(
                                                                  'assets/key.png',
                                                                  height:
                                                                      height *
                                                                          0.07,
                                                                )
                                                              ],
                                                            );
                                                    }
                                                  })),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              // statusTrue
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // color: Colors.red,
                  height: height * 0.15,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.015),
                        child: Container(
                          child: Container(
                              height: height * 0.1,
                              width: width * 0.2,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.025),
                                    child: Center(
                                        child: InkWell(
                                            child: Image.asset(
                                              'assets/Мини-игра.png',
                                              height: height * 0.07,
                                            ),
                                            onTap: () async {
                                              FirebaseAnalytics().logEvent(
                                                  name: 'Мини гра',
                                                  parameters: null);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListViewW(height, width),
                                                ),
                                              );
                                            })),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: height * 0.015),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          padding:
                                              EdgeInsets.all(height * 0.006),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              color: Color.fromRGBO(
                                                  179, 68, 108, 1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height)),
                                          child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(userFireBase.uid)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container(
                                                  height: 0,
                                                  width: 0,
                                                );
                                              } else {
                                                colMini = snapshot.data['spin'];
                                                return Text(
                                                  "${snapshot.data['spin']}",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ))
                                ],
                              )),
                        ),
                      ),
                      Container(
                        height: height * 0.1,
                        width: width * 0.6,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // height: height * 0.1,
                              width: width * 0.21,
                              constraints: BoxConstraints(
                                minWidth: width * 0.2,
                                maxHeight: width * 0.25,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: height * 0.006),
                                    alignment: Alignment.topLeft,
                                    child: Image.asset(
                                      "assets/key.png",
                                      height: height * 0.08,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.all(height * 0.005),
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(userFireBase.uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              keyy = 0;
                                              return Container(
                                                height: 0,
                                                width: 0,
                                              );
                                            } else {
                                              keyy = snapshot.data['key'];
                                              return Container(
                                                child: Text(
                                                  snapshot.data['key']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            }
                                          }),
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(179, 68, 108, 1),
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              height * 0.1)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              // width: width * 0.1,
                              // color: Colors.amber,
                              child: Center(
                                  child: InkWell(
                                child: Icon(
                                  Icons.add,
                                  size: width * 0.1,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  FirebaseAnalytics().logEvent(
                                      name: 'Магазин', parameters: null);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Shop(
                                        language,
                                        onClickMesseng,
                                        onClickMusic,
                                      ),
                                    ),
                                  );
                                },
                              )),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                minWidth: width * 0.2,
                                maxHeight: width * 0.25,
                              ),
                              // width: width * 0.2,
                              // color: Colors.red,
                              child: Stack(
                                children: [
                                  Container(
                                    // color: Colors.amber,
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      "assets/diamondsBig.png",
                                      height: height * 0.1,
                                      // width: 50,
                                      // color: Colors.red,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      padding: EdgeInsets.all(height * 0.005),
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(userFireBase.uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              diamonds = 0;
                                              return Container(
                                                height: 0,
                                                width: 0,
                                              );
                                            } else {
                                              diamonds =
                                                  snapshot.data['diamonds'];
                                              return Container(
                                                child: Text(
                                                  snapshot.data['diamonds']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            }
                                          }),
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(179, 68, 108, 1),
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              height * 0.1)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.1,
                        width: width * 0.2,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            statustime
                                ? Center(
                                    child: Text(timeLev,
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  )
                                : Container(),
                            InkWell(
                                onTap: () async {
                                  if (statustimeEE == true) {
                                  } else {
                                    statusABD = true;
                                    videoAd.load(
                                        adUnitId: RewardedVideoAd.testAdUnitId);
                                    await notificationPlugin
                                        .repeatNotification();
                                    await functiaTimeNow();
                                  }
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(bottom: height * 0.005),
                                  child: Container(
                                    child: Center(
                                      child: Image.asset(
                                        "assets/abs.png",
                                        height: height * 0.07,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        )),
                      )
                    ],
                  ),
                ),
              )
              // : Container()
            ],
          ),
        ),
      ),
    );
  }

  var indux;
  var indesSwap = 0;
  var listGarderob;
  var iageGo;
  bool statusImageInput = true;
  var indexStories = 0;

  Widget functia([List<Nimp> list]) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: height * 0.05),
      child: Container(
        height: height * 0.30,
        width: width,
        child: Center(
          child: Container(
            // padding: EdgeInsets.,
            child: new StackCard.builder(
                stackOffset: Offset(50, 0),
                stackType: StackType.right,
                itemCount: list.length,
                // displayIndicator: /* Flag to display the indicator */,
                // displayIndicatorBuilder: /* Customize the indicator */,
                onSwap: (index) {
                  indexStories = index;
                  // statusImageInput = true;
                  indesSwap = index;
                  setState(() {
                    // listGarderob = list[index].listGarderob;
                    priceStory = list[index].story_cost;
                    listParametrs = list[index].listParametrs;
                    documentId = list[index].documentID;
                    n = list[index].name;
                    episode = list[index].listEpisodes;
                    c = list[index].description;
                    functiaStreamDDDD(documentId);
                  });
                },
                itemBuilder: (context, index) {
                  indux = listSort[index].imageName;
                  return Container(
                    height: height * 0.25,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(height * 0.02),
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        // image: statusImageInput ? mapSave[indux].image : iageGo,
                        image: mapSave[indux].image,
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    streamController.close();
    super.dispose();
  }
}

const String testDevice = 'ca-app-pub-5733111311327578~8777626269';

class Muisda extends StatefulWidget {
  List<Language> listLanguage;
  String language;
  String onClickMessen;
  String onClickMusic;
  Muisda(
      this.listLanguage, this.language, this.onClickMessen, this.onClickMusic,
      {this.onLanguageSelect});

  final LanguageCallback onLanguageSelect;

  @override
  nameState createState() =>
      nameState(this.language, this.onClickMessen, this.onClickMusic);
}

class nameState extends State<Muisda> {
  String language;
  String onClickMessen;
  String onClickMusic;
  nameState(this.language, this.onClickMessen, this.onClickMusic);
  Color colorOnnNotification;
  Color colorOffNotification;
  Color colorOnnMusic;
  Color colorOffMusic;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  functiaA() {
    print(onClickMusic);
    print(onClickMessen);
    if (onClickMusic == 'on') {
      colorOnnMusic = Color.fromRGBO(241, 156, 187, 1);
    } else {
      // colorOnnMusic = Colors.white;
      colorOffMusic = Color.fromRGBO(241, 156, 187, 1);
    }
    if (onClickMessen == 'on') {
      colorOnnNotification = Color.fromRGBO(241, 156, 187, 1);
      // colorOffNotification = Colors.white;
    } else {
      colorOffNotification = Color.fromRGBO(241, 156, 187, 1);
      // colorOnnNotification = Colors.white;
    }
  }

  int count = 0;
  int count1 = 0;

  int index = 0;
  var d = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    functiaA();
    return Container(
      child: Center(
        child: Container(
          height: height * 0.9,
          width: width * 0.9,
          child: Column(
            children: [
              Material(
                borderRadius: BorderRadius.circular(100),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: height * 0.08,
                    width: width * 0.9,
                    child: Center(
                      child: Container(
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                "НАСТРОЙКИ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: "Nunito"),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding: EdgeInsets.only(right: width * 0.05),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Container(
                                      height: height * 0.06,
                                      width: width * 0.13,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: Color.fromRGBO(179, 68, 108, 1),
                                        // border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(height * 100),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: height * 0.04,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height * 0.01),
                      color: Color.fromRGBO(145, 30, 66, 1),
                    ),
                  ),
                ),
              ),
              Center(
                child: Material(
                  child: Container(
                    color: Color.fromRGBO(86, 0, 39, 1),
                    height: height * 0.8,
                    width: width * 0.8,
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.075,
                          width: width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.05),
                                child: Center(
                                  child: Material(
                                    color: Color.fromRGBO(86, 0, 39, 1),
                                    child: Text(
                                      'Уведомления',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.03),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              onClickMessen = 'on';
                                              colorOnnNotification = Colors.red;
                                              colorOffNotification =
                                                  Color.fromRGBO(0, 0, 0, 0);
                                              widget.onLanguageSelect(language,
                                                  onClickMessen, onClickMusic);
                                            });
                                          },
                                          child: Container(
                                            height: height * 0.06,
                                            width: width * 0.1973,
                                            child: Center(
                                              child: Text(
                                                "вкл",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Nunito",
                                                    fontSize: 20),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: colorOnnNotification,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.009),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              onClickMessen = 'off';
                                              colorOnnNotification =
                                                  Color.fromRGBO(0, 0, 0, 0);
                                              // colorOffNotification = Colors.red;
                                              widget.onLanguageSelect(language,
                                                  onClickMessen, onClickMusic);
                                            });
                                          },
                                          child: Container(
                                            height: height * 0.06,
                                            width: width * 0.1973,
                                            child: Center(
                                              child: Text(
                                                "выкл",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Nunito",
                                                    fontSize: 20),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: colorOffNotification,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.009),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(179, 68, 108, 1),
                                    border: Border.all(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.circular(height * 0.012),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.075,
                          width: width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.05),
                                child: Center(
                                  child: Material(
                                    color: Color.fromRGBO(86, 0, 39, 1),
                                    child: Text(
                                      'Звук',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.03),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              onClickMusic = 'on';
                                              colorOnnMusic = Colors.red;
                                              colorOffMusic =
                                                  Color.fromRGBO(0, 0, 0, 0);
                                              widget.onLanguageSelect(language,
                                                  onClickMessen, onClickMusic);
                                            });
                                          },
                                          child: Container(
                                            height: height * 0.06,
                                            width: width * 0.1973,
                                            child: Center(
                                              child: Text(
                                                "вкл",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Nunito",
                                                    fontSize: 20),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: colorOnnMusic,
                                              // border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.009),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              onClickMusic = 'off';
                                              colorOnnMusic =
                                                  Color.fromRGBO(0, 0, 0, 0);
                                              colorOffMusic =
                                                  Color.fromRGBO(0, 0, 0, 0);
                                              widget.onLanguageSelect(language,
                                                  onClickMessen, onClickMusic);
                                            });
                                          },
                                          child: Container(
                                            height: height * 0.06,
                                            width: width * 0.1973,
                                            child: Center(
                                              child: Text(
                                                "выкл",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Nunito",
                                                    fontSize: 20),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: colorOffMusic,
                                              // border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.009),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(179, 68, 108, 1),
                                    // border: Border.all(width: 2),
                                    border: Border.all(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.circular(height * 0.012),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.075,
                          width: width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.05),
                                child: Center(
                                  child: Material(
                                    color: Color.fromRGBO(86, 0, 39, 1),
                                    child: Text(
                                      'Язык',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.03),
                                child: Container(
                                  height: height * 0.07,
                                  width: width * 0.4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: width * 0.02),
                                        child: InkWell(
                                          child: Container(
                                            child: InkWell(
                                              onTap: () {
                                                for (var i = d;
                                                    i <
                                                        widget.listLanguage
                                                            .length;
                                                    i++) {
                                                  setState(() {
                                                    print(d);
                                                    d = i;
                                                    print(d);
                                                    language = widget
                                                        .listLanguage[i].short;
                                                    widget.onLanguageSelect(
                                                        language,
                                                        onClickMessen,
                                                        onClickMusic);
                                                  });
                                                }
                                              },
                                              child: Icon(
                                                Icons.arrow_left_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.red,
                                        height: height * 0.06,
                                        width: width * 0.2,
                                        child: Center(
                                          child: Text(
                                            language.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Nunito",
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: width * 0.02),
                                        child: InkWell(
                                          child: Container(
                                            // height: height * 0.06,
                                            child: InkWell(
                                              onTap: () {
                                                for (var i = count;
                                                    i <
                                                        widget.listLanguage
                                                            .length;
                                                    i++) {
                                                  setState(() {
                                                    print(count);
                                                    count = i;
                                                    print(count);
                                                    language = widget
                                                        .listLanguage[i].short;
                                                    widget.onLanguageSelect(
                                                        language,
                                                        onClickMessen,
                                                        onClickMusic);
                                                  });
                                                  break;
                                                }
                                              },
                                              child: Icon(
                                                Icons.arrow_right_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(179, 68, 108, 1),
                                    border: Border.all(color: Colors.white),
                                    // border: Border.all(width: 2),
                                    borderRadius:
                                        BorderRadius.circular(height * 0.012),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.075,
                          width: width * 0.8,
                          child: Center(
                            child: Text(
                              'Вход',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Nunito",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.075,
                          width: width * 0.8,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                // await firebaseAuth.signOut();
                                signOutGoogle();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeS()),
                                );
                              },
                              child: Container(
                                height: height * 0.1,
                                width: width * 0.7,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(179, 68, 108, 1),
                                    border: Border.all(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.circular(height * 0.01)),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Выход",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontSize: 18),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.075,
                          width: width * 0.8,
                          child: Center(
                            child: Text(
                              'Помощь и поддержка',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Nunito",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: height * 0.01),
                          child: Container(
                            height: height * 0.075,
                            width: width * 0.8,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.35,
                                    child: Center(
                                      child: Text(
                                        "Поддержка",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Nunito",
                                            fontSize: 18),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(179, 68, 108, 1),
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(
                                            height * 0.01)),
                                  ),
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.35,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(179, 68, 108, 1),
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(
                                            height * 0.01)),
                                    child: Center(
                                      child: Text(
                                        "Инструменты",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Nunito",
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.075,
                          width: width * 0.8,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.35,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(179, 68, 108, 1),
                                      border: Border.all(color: Colors.white),
                                      borderRadius:
                                          BorderRadius.circular(height * 0.01)),
                                  child: Center(
                                    child: Text(
                                      'Конфиденц.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.35,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(179, 68, 108, 1),
                                      border: Border.all(color: Colors.white),
                                      borderRadius:
                                          BorderRadius.circular(height * 0.01)),
                                  child: Center(
                                    child: Text(
                                      'Условия',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: height * 0.075,
                            width: width * 0.8,
                            child: Center(
                              child: Text(
                                'Комьюнити',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Nunito",
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.075,
                          width: width * 0.8,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.35,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(179, 68, 108, 1),
                                      border: Border.all(color: Colors.white),
                                      borderRadius:
                                          BorderRadius.circular(height * 0.01)),
                                  child: Center(
                                    child: Text(
                                      'Инстаzz',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.35,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(179, 68, 108, 1),
                                      border: Border.all(color: Colors.white),
                                      borderRadius:
                                          BorderRadius.circular(height * 0.01)),
                                  child: Center(
                                    child: Text(
                                      'Вконтакте',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signOutGoogle() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();

    print("User Signed Out");
  }
}

typedef LanguageCallback = void Function(
    String language, String onClickMesseng, String onClickMusic);
