import 'dart:math';

import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Shop.dart';
import 'UserInfoGlaf.dart';

class ListViewW extends StatefulWidget {
  double height;
  double width;
  ListViewW(this.height, this.width);
  @override
  ListViewState createState() => ListViewState();
}

class ListViewState extends State<ListViewW> with TickerProviderStateMixin {
  Random random = new Random();
  AnimationController controllerr;
  ScrollController controller;
  ScrollController controller1;
  ScrollController controller2;
  double a = 0.0;
  Map map = Map();
  Map map1 = Map();
  Map map2 = Map();

  int number1 = 0;
  int number2 = 1;
  int number3 = 2;

  animateToIndex(i) {
    controller.animateTo(i,
        duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
    controller1.animateTo(i,
        duration: Duration(seconds: 3), curve: Curves.fastOutSlowIn);
    controller2.animateTo(i,
        duration: Duration(seconds: 4), curve: Curves.fastOutSlowIn);
  }

  var image1;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-5733111311327578~8777626269");
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          statusABDspin = true;
        });
      } else if (event == RewardedVideoAdEvent.loaded) {
        RewardedVideoAd.instance.show();
      }
    };
    functiMap();
    functiMap1();
    functiMap2();
    controller = ScrollController();
    controller1 = ScrollController();
    controller2 = ScrollController();
  }

  int z = 0;
  int z1 = 0;
  int x = 0;
  int x1 = 0;
  int c = 0;
  int c1 = 0;

  int v = 0;
  int v1 = 0;
  int b = 0;
  int b1 = 0;
  int n = 0;
  int n1 = 0;

  int s = 0;
  int s1 = 0;
  int d = 0;
  int d1 = 0;
  int f = 0;
  int f1 = 0;
  var randomNumber;
  List<int> list = List();
  List<int> list1 = List();
  List<int> list2 = List();
  bool first = true;
  functiWin() {
    print('Diamonds' + "$diamonds");

    diamonds = diamonds + 3;
    print('Diamonds2' + "$diamonds");
    FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .update({'diamonds': diamonds});
  }

  functiaSave() {
    Future.delayed(Duration(seconds: 5), () {
      if (z == v && v == s) {
        functiWin();
        setState(() {
          first = false;
          map[z1] = Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 2),
                    elevation: first ? 0 : 13.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(z), fit: BoxFit.fill)),
                      ),
                    )),
              ),
            ),
          );
          map1[v1] = Container(
            child: Center(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 2),
                    elevation: first ? 0 : 8.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(v), fit: BoxFit.fill)),
                      ),
                    ),
                  )),
            ),
          );
          map2[s1] = Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 2),
                    elevation: first ? 0 : 8.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(s), fit: BoxFit.fill)),
                      ),
                    )),
              ),
            ),
          );
        });
      } else if (z == b && b == f) {
        functiWin();
        setState(() {
          first = false;
          map[z1] = Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 2),
                    elevation: first ? 0 : 13.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(z), fit: BoxFit.fill)),
                      ),
                    )),
              ),
            ),
          );
          map1[b1] = Container(
            child: Center(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 2),
                    elevation: first ? 0 : 8.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(b), fit: BoxFit.fill)),
                      ),
                    ),
                  )),
            ),
          );
          map2[f1] = Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 2),
                    elevation: first ? 0 : 8.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(f), fit: BoxFit.fill)),
                      ),
                    )),
              ),
            ),
          );
        });
      } else if (c == b && b == s) {
        functiWin();
        setState(() {
          first = false;
          map[c1] = Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 1),
                    elevation: first ? 0 : 13.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(c), fit: BoxFit.fill)),
                      ),
                    )),
              ),
            ),
          );
          map1[b1] = Container(
            child: Center(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 1),
                    elevation: first ? 0 : 8.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(b), fit: BoxFit.fill)),
                      ),
                    ),
                  )),
            ),
          );
          map2[s1] = Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 1),
                    elevation: first ? 0 : 8.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(s), fit: BoxFit.fill)),
                      ),
                    )),
              ),
            ),
          );
        });
      } else if (c == n && n == f) {
        functiWin();
        setState(() {
          first = false;
          map[c1] = Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 1),
                    elevation: first ? 0 : 13.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(c), fit: BoxFit.fill)),
                      ),
                    )),
              ),
            ),
          );
          map1[n1] = Container(
            child: Center(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 1),
                    elevation: first ? 0 : 8.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(n), fit: BoxFit.fill)),
                      ),
                    ),
                  )),
            ),
          );
          map2[f1] = Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 1),
                    elevation: first ? 0 : 8.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(f), fit: BoxFit.fill)),
                      ),
                    )),
              ),
            ),
          );
        });
      }
      if (x == b && b == d) {
        functiWin();
        setState(() {
          first = false;
          map[x1] = Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 1),
                    elevation: first ? 0 : 13.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(x), fit: BoxFit.fill)),
                      ),
                    )),
              ),
            ),
          );
          map1[b1] = Container(
            child: Center(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 1),
                    elevation: first ? 0 : 8.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(b), fit: BoxFit.fill)),
                      ),
                    ),
                  )),
            ),
          );
          map2[d1] = Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: AnimatedPhysicalModel(
                    color: Colors.amber,
                    duration: Duration(seconds: 1),
                    elevation: first ? 0 : 8.0,
                    curve: Curves.fastOutSlowIn,
                    shape: BoxShape.rectangle,
                    shadowColor: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Container(
                        height: widget.height * 08,
                        width: widget.height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: functia(d), fit: BoxFit.fill)),
                      ),
                    )),
              ),
            ),
          );
        });
      }
      // if (s == d && d == f) {
      //   functiWin();
      //   setState(() {
      //     first = false;
      //     map2[s1] = Container(
      //       child: Center(
      //         child: Padding(
      //           padding: EdgeInsets.all(10),
      //           child: AnimatedPhysicalModel(
      //               color: Colors.amber,
      //               duration: Duration(seconds: 1),
      //               elevation: first ? 0 : 13.0,
      //               curve: Curves.fastOutSlowIn,
      //               shape: BoxShape.rectangle,
      //               shadowColor: Colors.black,
      //               borderRadius: BorderRadius.all(Radius.circular(10)),
      //               child: Center(
      //                 child: Container(
      //                   height: widget.height * 08,
      //                   width: widget.height * 0.1,
      //                   decoration: BoxDecoration(
      //                       image: DecorationImage(
      //                           image: functia(s), fit: BoxFit.fill)),
      //                 ),
      //               )),
      //         ),
      //       ),
      //     );
      //     map2[d1] = Container(
      //       child: Center(
      //         child: Padding(
      //             padding: EdgeInsets.all(10),
      //             child: AnimatedPhysicalModel(
      //               color: Colors.amber,
      //               duration: Duration(seconds: 1),
      //               elevation: first ? 0 : 8.0,
      //               curve: Curves.fastOutSlowIn,
      //               shape: BoxShape.rectangle,
      //               shadowColor: Colors.black,
      //               borderRadius: const BorderRadius.all(Radius.circular(10)),
      //               child: Center(
      //                 child: Container(
      //                   height: widget.height * 08,
      //                   width: widget.height * 0.1,
      //                   decoration: BoxDecoration(
      //                       image: DecorationImage(
      //                           image: functia(d), fit: BoxFit.fill)),
      //                 ),
      //               ),
      //             )),
      //       ),
      //     );
      //     map2[f1] = Container(
      //       child: Center(
      //         child: Padding(
      //           padding: EdgeInsets.all(10),
      //           child: AnimatedPhysicalModel(
      //               color: Colors.amber,
      //               duration: Duration(seconds: 1),
      //               elevation: first ? 0 : 8.0,
      //               curve: Curves.fastOutSlowIn,
      //               shape: BoxShape.rectangle,
      //               shadowColor: Colors.black,
      //               borderRadius: const BorderRadius.all(Radius.circular(10)),
      //               child: Center(
      //                 child: Container(
      //                   height: widget.height * 08,
      //                   width: widget.height * 0.1,
      //                   decoration: BoxDecoration(
      //                       image: DecorationImage(
      //                           image: functia(f), fit: BoxFit.fill)),
      //                 ),
      //               )),
      //         ),
      //       ),
      //     );
      //   });
      // }
    });
  }

  functia(int randomNumber) {
    print(randomNumber);
    switch (randomNumber) {
      case 0:
        {
          return Image.asset('assets/кольцо.png').image;
        }
        break;
      case 1:
        {
          return Image.asset('assets/корона.png').image;
        }
        break;
      case 2:
        {
          return Image.asset('assets/леденец.png').image;
        }
        break;
      case 3:
        {
          return Image.asset('assets/мишка.png').image;
        }

        break;
      case 4:
        {
          return Image.asset('assets/платье.png').image;
        }
        break;
      case 5:
        {
          return Image.asset('assets/butterfly.png').image;
        }
        break;
      case 6:
        {
          return Image.asset('assets/heart.png').image;
        }

        break;
      case 7:
        {
          return Image.asset('assets/heart2.png').image;
        }
        break;
      case 8:
        {
          return Image.asset('assets/wineglass.png').image;
        }
        break;
    }
  }

  functiMap() {
    for (var i = 0; i < 10000; i++) {
      first = true;
      var randomNumberr = random.nextInt(8);
      print(randomNumberr);

      list.add(randomNumberr);
      map[i] = Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: AnimatedPhysicalModel(
                color: Colors.white,
                duration: Duration(seconds: 1),
                elevation: first ? 0 : 6.0,
                curve: Curves.fastOutSlowIn,
                shape: BoxShape.rectangle,
                shadowColor: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Center(
                  child: Container(
                    height: widget.height * 08,
                    width: widget.height * 0.1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: functia(randomNumberr), fit: BoxFit.cover)),
                  ),
                )),
          ),
        ),
      );
    }
  }

  functiMap1() {
    for (var i = 0; i < 10000; i++) {
      first = true;
      var randomNumberr = random.nextInt(8);
      // if (randomNumberr <= 2) {
      //   randomNumberr = 10;
      // } else if (randomNumberr >= 2 && randomNumberr <= 6) {
      //   randomNumberr = 5;
      // } else if (randomNumberr >= 6) {
      //   randomNumberr = 0;
      // }
      list1.add(randomNumberr);
      map1[i] = Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: AnimatedPhysicalModel(
                color: Colors.white,
                duration: Duration(seconds: 1),
                elevation: first ? 0 : 6.0,
                curve: Curves.fastOutSlowIn,
                shape: BoxShape.rectangle,
                shadowColor: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Center(
                  child: Container(
                    height: widget.height * 08,
                    width: widget.height * 0.1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: functia(randomNumberr), fit: BoxFit.cover)),
                    // child: Center(
                    //     child: Text(
                    //   randomNumberr.toString(),
                    //   style: TextStyle(fontSize: 25),
                    // )),
                  ),
                )),
          ),
        ),
      );
    }
  }

  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  functiMap2() {
    for (var i = 0; i < 10000; i++) {
      first = true;
      var randomNumberr = random.nextInt(8);
      // if (randomNumberr <= 2) {
      //   randomNumberr = 10;
      // } else if (randomNumberr >= 2 && randomNumberr <= 6) {
      //   randomNumberr = 5;
      // } else if (randomNumberr >= 6) {
      //   randomNumberr = 0;
      // }
      list2.add(randomNumberr);
      map2[i] = Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: AnimatedPhysicalModel(
                color: Colors.white,
                duration: Duration(seconds: 1),
                elevation: first ? 0 : 6.0,
                curve: Curves.fastOutSlowIn,
                shape: BoxShape.rectangle,
                shadowColor: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Center(
                  child: Container(
                    height: widget.height * 08,
                    width: widget.height * 0.1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: functia(randomNumberr), fit: BoxFit.cover)),
                    // child: Center(
                    //     child: Text(
                    //   randomNumberr.toString(),
                    //   style: TextStyle(fontSize: 25),
                    // )),
                  ),
                )),
          ),
        ),
      );
    }
  }

  bool statusABDspin = false;
  var diamonds = 0;
  var spin = 0;
  var user;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    user = userFireBase.uid;
    if (statusABDspin == true) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userFireBase.uid)
          .update({"spin": 5});
      statusABDspin = false;
    }
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Container(
            height: height,
            width: width,
            child: Center(
                child: Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  color: Color.fromRGBO(86, 0, 39, 1),
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //       image: Image.asset("assets/game.jpg").image,
                  //       fit: BoxFit.cover),
                  // ),
                ),
                // Padding(
                //   padding:
                //       EdgeInsets.only(top: height * 0.085, left: width * 0.07),
                //   child: Align(
                //     alignment: Alignment.topLeft,
                //     child: InkWell(
                //       child: Container(
                //         height: height * 0.06,
                //         width: width * 0.13,
                //         child: Center(
                //           child: Icon(Icons.arrow_back,
                //               color: Colors.white, size: height * 0.04),
                //         ),
                //         decoration: BoxDecoration(
                //           color: Color.fromRGBO(179, 68, 108, 1),
                //           border: Border.all(color: Colors.white),
                //           borderRadius: BorderRadius.circular(height * 100),
                //         ),
                //       ),
                //       onTap: () {
                //         Navigator.pop(context);
                //       },
                //     ),
                //   ),
                // ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.085, right: width * 0.07),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: Container(
                        width: width,
                        height: height * 0.06,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: height * 0.04),
                              child: InkWell(
                                child: Container(
                                  height: height * 0.06,
                                  width: width * 0.13,
                                  child: Center(
                                    child: Icon(Icons.arrow_back,
                                        color: Colors.white,
                                        size: height * 0.04),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(179, 68, 108, 1),
                                    border: Border.all(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.circular(height * 100),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.008),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: height * 0.035,
                                    // width: width * 0.25,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(86, 0, 39, 0.7),
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(height * 1)),
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
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Container(
                                                        child: Text(diamonds
                                                            .toString()),
                                                      );
                                                    } else {
                                                      diamonds = snapshot
                                                          .data['diamonds'];
                                                      return Container(
                                                        child: Text(
                                                          snapshot
                                                              .data['diamonds']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: height *
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
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.00, left: width * 0.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: InkWell(
                                  child: Container(
                                    height: height * 0.06,
                                    width: width * 0.13,
                                    child: Center(
                                      child: Icon(Icons.info,
                                          color: Colors.white,
                                          size: height * 0.04),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(179, 68, 108, 1),
                                      border: Border.all(color: Colors.white),
                                      borderRadius:
                                          BorderRadius.circular(height * 100),
                                    ),
                                  ),
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (e) => AlertDialog(
                                      backgroundColor:
                                          Color.fromRGBO(86, 0, 39, 1),
                                      // elevation: 12,
                                      title: Center(
                                        child: Text(
                                          'Инструкция',
                                          style: TextStyle(
                                              fontSize: height * 0.04,
                                              fontFamily: 'Nunito',
                                              color: Colors.white),
                                        ),
                                      ),
                                      content: Container(
                                        height: height * 0.33,
                                        width: width * 0.1,
                                        // color: Colors.red,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              // color: Colors.red,
                                              height: height * 0.25,
                                              // width: width * 0.3,
                                              child: ListView(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'Испытай свою удачу.',
                                                          style: TextStyle(
                                                              fontSize: height *
                                                                  0.018,
                                                              fontFamily:
                                                                  'Nunito',
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Просмотр рекламы.',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    height *
                                                                        0.018,
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            '(',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    height *
                                                                        0.018,
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Container(
                                                            height:
                                                                height * 0.03,
                                                            width: width * 0.07,
                                                            decoration:
                                                                BoxDecoration(
                                                              // color: Colors.red,
                                                              image: DecorationImage(
                                                                  image: Image.asset(
                                                                          'assets/clover.png')
                                                                      .image),
                                                            ),
                                                          ),
                                                          Text(
                                                            ')',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    height *
                                                                        0.018,
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        ],
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'дает тебе 5 попыток выиграть',
                                                          style: TextStyle(
                                                              fontSize: height *
                                                                  0.018,
                                                              fontFamily:
                                                                  'Nunito',
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'кристаллы (от 0 до 3',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    height *
                                                                        0.018,
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Container(
                                                            height:
                                                                height * 0.04,
                                                            width: width * 0.07,
                                                            decoration:
                                                                BoxDecoration(
                                                              // color: Colors.red,
                                                              image: DecorationImage(
                                                                  image: Image.asset(
                                                                          'assets/diamondsLitle.png')
                                                                      .image),
                                                            ),
                                                          ),
                                                          Text(
                                                            ').',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    height *
                                                                        0.018,
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                'Чтобы получить ещё 5 \nпопыток, посмотри',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      height *
                                                                          0.018,
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'рекламу(',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    height *
                                                                        0.018,
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Container(
                                                            height:
                                                                height * 0.03,
                                                            width: width * 0.07,
                                                            decoration:
                                                                BoxDecoration(
                                                              // color: Colors.red,
                                                              image: DecorationImage(
                                                                  image: Image.asset(
                                                                          'assets/clover.png')
                                                                      .image),
                                                            ),
                                                          ),
                                                          Text(').',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    height *
                                                                        0.018,
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: Colors
                                                                    .white,
                                                              ))
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(e).pop();
                                              },
                                              child: Container(
                                                height: height * 0.06,
                                                width: width * 0.4,
                                                child: Center(
                                                  child: Text(
                                                    'Продолжить',
                                                    style: TextStyle(
                                                        fontSize: height * 0.02,
                                                        color: Colors.white,
                                                        fontFamily: "Nunito"),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        179, 68, 108, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            height * 0.01),
                                                    border: Border.all(
                                                        color: Colors.white)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        constraints: BoxConstraints(
                          minHeight: height * 0.05,
                          minWidth: width * 0.45,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: height * 0.5,
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: height * 0.36,
                              width: width * 0.3,
                              child: ListView.builder(
                                itemExtent: height * 0.12,
                                // itemExtent: height * 0.12,
                                padding: EdgeInsets.all(0),
                                controller: controller,
                                itemBuilder: (context, index) {
                                  if (number1 == index) {
                                    z = list[number1];
                                    // z = 10;
                                    z1 = number1;
                                  }
                                  if (number2 == index) {
                                    x = list[number2];
                                    // x = 10;
                                    x1 = number2;
                                  }
                                  if (number3 == index) {
                                    c = list[number3];
                                    // c = 10;
                                    c1 = number3;
                                  }
                                  return map[index];
                                },
                              ),
                            ),
                            Container(
                              height: height * 0.36,
                              width: width * 0.3,
                              // color: Colors.red,
                              child: InkWell(
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: height * 0.36,
                              width: width * 0.3,
                              child: ListView.builder(
                                padding: EdgeInsets.all(0),
                                controller: controller1,
                                itemExtent: height * 0.12,
                                // itemExtent: 100,
                                itemBuilder: (context, index) {
                                  if (number1 == index) {
                                    v = list1[number1];
                                    v1 = number1;
                                  }
                                  if (number2 == index) {
                                    b = list1[number2];
                                    b1 = number2;
                                  }
                                  if (number3 == index) {
                                    n = list1[number3];
                                    n1 = number3;
                                  }
                                  return map1[index];
                                },
                              ),
                            ),
                            Container(
                              height: height * 0.36,
                              width: width * 0.3,
                              // color: Colors.red,
                              child: InkWell(
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: height * 0.36,
                              width: width * 0.3,
                              child: ListView.builder(
                                padding: EdgeInsets.all(0),
                                controller: controller2,
                                itemExtent: height * 0.12,
                                // itemExtent: 100,
                                itemBuilder: (context, index) {
                                  print(index);
                                  print('index');
                                  if (number1 == index) {
                                    s = list2[number1];
                                    s1 = number1;
                                  }
                                  if (number2 == index) {
                                    d = list2[number2];
                                    d1 = number2;
                                  }
                                  if (number3 == index) {
                                    f = list2[number3];
                                    f1 = number3;
                                  }
                                  // return Container(
                                  //   child: Center(
                                  //     child: Text(index.toString(),
                                  //         style:
                                  //             TextStyle(color: Colors.white)),
                                  //   ),
                                  // );
                                  return map2[index];
                                },
                              ),
                            ),
                            Container(
                              height: height * 0.36,
                              width: width * 0.3,
                              // color: Colors.red,
                              child: InkWell(
                                onTap: () {},
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: height * 0.15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            FirebaseAnalytics()
                                .logEvent(name: 'Мини_игра', parameters: null);
                            if (spin == 0) {
                            } else {
                              spin = spin - 1;
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userFireBase.uid)
                                  .update({'spin': spin});
                              number1 = number1 + 100;
                              number2 = number2 + 100;
                              number3 = number3 + 100;
                              a = a + height * 0.12 * 100;
                              animateToIndex(a);
                              functiaSave();
                            }
                          },
                          child: Container(
                            height: height * 0.08,
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(179, 68, 108, 1),
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  BorderRadius.circular(height * 0.01),
                            ),
                            child: Center(
                              child: Text('Играть',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 0.035)),
                            ),
                            //
                          ),
                        ),
                        Container(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userFireBase.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                    height: height * 0.0,
                                    width: width * 0.0,
                                  );
                                } else {
                                  spin = snapshot.data['spin'];
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(left: height * 0.05),
                                    child: Container(
                                      height: height * 0.085,
                                      width: width * 0.2,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          color:
                                              Color.fromRGBO(179, 68, 108, 1),
                                          borderRadius: BorderRadius.circular(
                                              height * 1)),
                                      child: Center(
                                        child: snapshot.data['spin'] == 0
                                            ? InkWell(
                                                onTap: () {
                                                  videoAd.load(
                                                      adUnitId: RewardedVideoAd
                                                          .testAdUnitId);
                                                },
                                                child: Image.asset(
                                                    'assets/clover.png'),
                                              )
                                            : Text(
                                                snapshot.data['spin']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: height * 0.05,
                                                    color: Colors.white),
                                              ),
                                      ),
                                    ),
                                  );
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
          ),
        ));
  }
}
