import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:questbook/UserInfoGlaf.dart';

class Shop extends StatefulWidget {
  String language;
  String onClickMesseng;
  String onClickMusic;
  Shop([this.language, this.onClickMesseng, this.onClickMusic]);
  @override
  ShopState createState() => ShopState();
}

class ShopState extends State<Shop> {
  Color colorKey = Color.fromRGBO(241, 156, 187, 1);
  Color colorM = Color.fromRGBO(0, 0, 0, 0);
  Color colorSwap = Color.fromRGBO(0, 0, 0, 0);
  final String testID = 'price';
  final String test1ID = 'key';

  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  bool available = true;

  List<ProductDetails> _products = [];

  List<PurchaseDetails> _purchases = [];

  StreamSubscription _subscription;

  int credits = 0;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _initialize() async {
    var _available = await _iap.isAvailable();

    if (_available) {
      await _getProducts();
      await _getPastPurchases();

      _verifyPurchase();
    }
    _subscription = _iap.purchaseUpdatedStream.listen((data) => setState(() {
          print('NEW PURCHASE');
          _purchases.addAll(data);
          _verifyPurchase();
        }));
  }

  void _buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  }

  Future<void> _getProducts() async {
    Set<String> ids = Set.from([
      testID,
      'test_a',
      test1ID,
      'test_a1',
    ]);
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    setState(() {
      _products = response.productDetails;
    });
  }

  Future<void> _getPastPurchases() async {
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();

    for (PurchaseDetails purchase in response.pastPurchases) {
      if (Platform.isIOS) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
    }
    setState(() {
      _purchases = response.pastPurchases;
    });
  }

  PurchaseDetails _hasPurchased(String productID) {
    return _purchases.firstWhere((purchase) => purchase.productID == productID,
        orElse: () => null);
  }

  void _verifyPurchase() {
    PurchaseDetails purchase = _hasPurchased(testID);
    PurchaseDetails purchase1 = _hasPurchased(test1ID);

    if (purchase != null && purchase.status == PurchaseStatus.purchased) {
      credits = 10;
    }
    if (purchase1 != null && purchase1.status == PurchaseStatus.purchased) {
      credits = 30;
    }
  }

  void _spendCredits(PurchaseDetails purchase) async {
    setState(() {
      credits--;
    });

    if (credits == 0) {
      var res = await _iap.consumePurchase(purchase);
      await _getPastPurchases();
    }
  }

  Image imageAll = Image.asset('assets/shopAll.png');
  Image imageLitle = Image.asset('assets/diamondsLitle.png');
  Image imageMidle = Image.asset('assets/diamondsMidle.png');
  Image imageBig = Image.asset('assets/diamondsBig.png');
  bool statuss = false;

  var diamonds;
  var key;

  @override
  Widget build(BuildContext context) {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async => false,
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'Nunito'),
          home: Scaffold(
            backgroundColor: Color.fromRGBO(86, 0, 39, 1),
            body: Stack(
              children: [
                Container(
                  height: height * 0.46,
                  width: width,
                  child: Stack(
                    children: [
                      Container(
                          height: height * 0.3,
                          width: width,
                          child: Row(
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
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(
                              //       top: height * 0.085, right: width * 0.07),
                              //   child: Align(
                              //     alignment: Alignment.topRight,
                              //     child: InkWell(
                              //       child: Image.asset(
                              //         "assets/setings.png",
                              //         height: height * 0.055,
                              //         // width: 50,
                              //         // color: Colors.red,
                              //       ),
                              //       onTap: () {
                              //         // showDialog(
                              //         //     context: context,
                              //         //     builder: (_) {
                              //         //       // return Muisda();
                              //         //     });
                              //       },
                              //     ),
                              //   ),
                              // ),
                            ],
                          )),
                      Column(
                        children: [
                          Container(
                              constraints: BoxConstraints(
                                minHeight: height * 0.15,
                              ),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userFireBase.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container();
                                    } else {
                                      diamonds = snapshot.data['diamonds'];
                                      key = snapshot.data['key'];
                                      print(diamonds);
                                      print(key);
                                      return Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.05),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minHeight: height * 0.09,
                                            ),
                                            width: width * 0.5,
                                            decoration: BoxDecoration(
                                              // Color.fromRGBO(179, 68, 108, 1)
                                              color: Color.fromRGBO(
                                                  179, 68, 108, 1),
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.01),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  // color: Colors.red,
                                                  width: width * 0.2,
                                                  constraints: BoxConstraints(
                                                    minHeight: height * 0.09,
                                                  ),
                                                  child: Column(
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment
                                                    //         .spaceEvenly,
                                                    children: [
                                                      Center(
                                                        child: Image.asset(
                                                          'assets/diamondsLitle.png',
                                                          height:
                                                              height * 0.059,
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data['diamonds']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize:
                                                                height * 0.02,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.red,
                                                  width: width * 0.2,
                                                  constraints: BoxConstraints(
                                                    minHeight: height * 0.09,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Center(
                                                        child: Image.asset(
                                                          "assets/key.png",
                                                          height: height * 0.05,
                                                        ),
                                                      ),
                                                      Text(
                                                          snapshot.data['key']
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize:
                                                                height * 0.02,
                                                            color: Colors.white,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  })),
                          Container(
                            width: width,
                            height: height * 0.25,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  for (var prod in _products) {
                                    if (prod.id == 'key_diamonds') {
                                      _buyProduct(prod);
                                    }
                                  }
                                  // if (_hasPurchased(prod.id) != null) {
                                  //   _spendCredits(_hasPurchased(prod.id));
                                  // } else {

                                  // }
                                },
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: width * 0.9,
                                            height: height * 0.15,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  179, 68, 108, 1),
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.01),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: imageAll,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: height * 0.1,
                                            child: Image.asset(
                                                'assets/label_sale yellow.png'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: height * 0.025,
                                                right: width * 0.1),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: height * 0.03,
                                                  width: width * 0.3,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        86, 0, 39, 0.5),
                                                    border: Border.all(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            height * 0.005),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Image.asset(
                                                          'assets/diamondsLitle.png'),
                                                      Text('200',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          )),
                                                      Image.asset(
                                                          'assets/key.png'),
                                                      Text(
                                                        '10',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                      // Text(
                                                      //   "30",
                                                      //   style: TextStyle(
                                                      //       color:
                                                      //           Colors.white),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: height * 0.06,
                                                  width: width * 0.4,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        86, 0, 39, 0.8),
                                                    border: Border.all(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            height * 0.01),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "USD",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                height * 0.025),
                                                      ),
                                                      Text(
                                                        "8.99",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                height * 0.025),
                                                      ),
                                                    ],
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
                            ),
                          ),
                          Container(
                            height: height * 0.06,
                            width: width,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: height * 0.06,
                                width: width * 0.6,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            imageLitle = Image.asset(
                                                'assets/diamondsLitle.png');
                                            imageMidle = Image.asset(
                                                'assets/diamondsMidle.png');
                                            imageBig = Image.asset(
                                                'assets/diamondsBig.png');
                                            colorKey = Color.fromRGBO(
                                                241, 156, 187, 1);
                                            colorM = Color.fromRGBO(0, 0, 0, 0);
                                            colorSwap =
                                                Color.fromRGBO(0, 0, 0, 0);
                                            statuss = false;
                                          });
                                        },
                                        child: Container(
                                          height: height * 0.06,
                                          width: width * 0.1973,
                                          child: Center(
                                            child: Image.asset(
                                              "assets/diamondsLitle.png",
                                              height: height * 0.05,
                                              // width: 50,
                                              // color: Colors.red,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: colorKey,
                                            borderRadius: BorderRadius.circular(
                                                height * 0.009),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            imageLitle =
                                                Image.asset('assets/key.png');
                                            imageMidle = Image.asset(
                                                'assets/Ключ•2.png');
                                            imageBig = Image.asset(
                                                'assets/Ключ•3.png');
                                            colorKey =
                                                Color.fromRGBO(0, 0, 0, 0);
                                            colorM = Color.fromRGBO(
                                                241, 156, 187, 1);
                                            colorSwap =
                                                Color.fromRGBO(0, 0, 0, 0);
                                            statuss = false;
                                          });
                                        },
                                        child: Container(
                                          height: height * 0.06,
                                          width: width * 0.1973,
                                          child: Center(
                                            child: Image.asset(
                                              "assets/key.png",
                                              height: height * 0.05,
                                              // width: 50,
                                              // color: Colors.red,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: colorM,
                                            borderRadius: BorderRadius.circular(
                                                height * 0.009),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            imageLitle = Image.asset('');
                                            imageMidle = Image.asset('');
                                            imageBig = Image.asset('');
                                            colorKey =
                                                Color.fromRGBO(0, 0, 0, 0);
                                            colorM = Color.fromRGBO(0, 0, 0, 0);
                                            colorSwap = Color.fromRGBO(
                                                241, 156, 187, 1);
                                            statuss = true;
                                          });
                                        },
                                        child: Container(
                                          height: height * 0.06,
                                          width: width * 0.1973,
                                          child: Center(
                                              child: Icon(Icons.repeat_rounded,
                                                  color: Colors.white)),
                                          decoration: BoxDecoration(
                                            color: colorSwap,
                                            borderRadius: BorderRadius.circular(
                                                height * 0.009),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(179, 68, 108, 1),
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius:
                                      BorderRadius.circular(height * 0.01),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                statuss
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          child: swapDiamonds(),
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: height * 0.54,
                          width: width,
                          child: Column(
                            children: [
                              Container(
                                width: width,
                                height: height * 0.25,
                                // color: Color.fromRGBO(166, 189, 215, 1),
                                // color: Color.fromRGBO(86, 0, 39, 1),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      for (var prod in _products) {
                                        if (prod.id == 'key_big') {
                                          _buyProduct(prod);
                                        }
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: width * 0.9,
                                            height: height * 0.15,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  179, 68, 108, 1),
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.01),
                                            ),
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: imageBig,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: height * 0.025,
                                                right: width * 0.1),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: height * 0.03,
                                                  width: width * 0.2,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        86, 0, 39, 0.5),
                                                    border: Border.all(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            height * 0.005),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "200",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: height * 0.06,
                                                  width: width * 0.4,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        86, 0, 39, 0.8),
                                                    border: Border.all(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            height * 0.01),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "USD",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                height * 0.025),
                                                      ),
                                                      Text(
                                                        "9.99",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                height * 0.025),
                                                      ),
                                                    ],
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
                              Container(
                                width: width,
                                height: height * 0.29,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          for (var prod in _products) {
                                            if (prod.id == 'key_midle') {
                                              _buyProduct(prod);
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: height * 0.2,
                                          width: width * 0.425,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: height * 0.18,
                                                width: width * 0.425,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      179, 68, 108, 1),
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          height * 0.01),
                                                ),
                                                child: imageMidle,
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        height: height * 0.03,
                                                        width: width * 0.2,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              86, 0, 39, 0.5),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      height *
                                                                          0.005),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              "50",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height * 0.05,
                                                        width: width * 0.3,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              86, 0, 39, 0.8),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      height *
                                                                          0.01),
                                                        ),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                "USD",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        height *
                                                                            0.025),
                                                              ),
                                                              Text(
                                                                "2.99",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        height *
                                                                            0.025),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          for (var prod in _products) {
                                            if (prod.id == 'key_small') {
                                              _buyProduct(prod);
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: height * 0.2,
                                          width: width * 0.425,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: height * 0.18,
                                                width: width * 0.425,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      179, 68, 108, 1),
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          height * 0.01),
                                                ),
                                                child:
                                                    Center(child: imageLitle),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: height * 0.03,
                                                      width: width * 0.2,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            86, 0, 39, 0.5),
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    height *
                                                                        0.005),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text("25",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: height * 0.05,
                                                      width: width * 0.3,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            86, 0, 39, 0.8),
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    height *
                                                                        0.01),
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              "USD",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      height *
                                                                          0.025),
                                                            ),
                                                            Text(
                                                              "1.99",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      height *
                                                                          0.025),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
        ));
  }

  TextEditingController nameHeroInput = new TextEditingController();
  FocusNode focusNode = FocusNode();

  Widget swapDiamonds() {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: Color.fromRGBO(86, 0, 39, 1),
      height: height * 0.54,
      width: width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // color: Colors.red,
              // height: height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.1,
                    child: Image.asset(
                      "assets/diamondsLitle.png",
                    ),
                  ),
                  Text(
                    "20 = 1",
                    style:
                        TextStyle(fontSize: height * 0.05, color: Colors.white),
                  ),
                  Container(
                    height: height * 0.1,
                    child: Image.asset(
                      "assets/key.png",
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (diamonds < 20) {
                } else {
                  diamonds -= 20;
                  key += 1;
                  FirebaseAnalytics()
                      .logEvent(name: 'Магаз обменять', parameters: null);
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(userFireBase.uid)
                      .update({
                    "diamonds": diamonds,
                    "key": key,
                    "onClickMesseng": widget.onClickMesseng,
                    "onClickMusic": widget.onClickMusic,
                    "language": widget.language,
                  });
                }
              },
              child: Container(
                height: height * 0.08,
                width: width * 0.6,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(179, 68, 108, 1),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(height * 0.01),
                ),
                child: Center(
                  child: Text('Поменять',
                      style: TextStyle(
                          color: Colors.white, fontSize: height * 0.035)),
                ),
                // child: AnimatedButton(
                //   color: Color.fromRGBO(179, 68, 108, 1),
                //   child: Text(
                //     'Играть',
                //     style: TextStyle(
                //       fontSize: 22,
                //       color: Colors.white,
                //       fontWeight: FontWeight.w500,
                //       // fontWeight: FontWeight.w500,
                //     ),
                //   ),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => Episodes(
                //           episode,
                //           image,
                //           keyy,
                //           diamonds,
                //           language,
                //           nameHERO,
                //           nameANIMAL,
                //           onClickMesseng,
                //           onClickMusic,
                //           documentId,
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ),
            ),
            // AnimatedButton(
            //   color: Color.fromRGBO(179, 68, 108, 1),
            //   child: Text(
            //     'Поменять',
            //     style: TextStyle(
            //       fontSize: 22,
            //       color: Colors.white,
            //       // fontWeight: FontWeight.w500,
            //       // fontWeight: FontWeight.w500,
            //     ),
            //   ),
            //   onPressed: () {
            //     if (diamonds < 20) {
            //     } else {
            //       diamonds -= 20;
            //       key += 1;
            //       Firestore.instance
            //           .collection('users')
            //           .document(userFireBase.uid)
            //           .updateData({
            //         "diamonds": diamonds,
            //         "key": key,
            //         "onClickMesseng": widget.onClickMesseng,
            //         "onClickMusic": widget.onClickMusic,
            //         "language": widget.language,
            //       });
            //     }
            //   },
            // ),
            // InkWell(
            //   onTap: () async {
            //     if (diamonds < 20) {
            //     } else {
            //       diamonds -= 20;
            //       key += 1;
            //       Firestore.instance
            //           .collection('users')
            //           .document(userFireBase.uid)
            //           .setData({
            //         "diamonds": diamonds,
            //         "key": key,
            //         "onClickMesseng": widget.onClickMesseng,
            //         "onClickMusic": widget.onClickMusic,
            //         "language": widget.language,
            //       });
            //     }
            //   },
            //   child: Container(
            //     height: height * 0.07,
            //     width: width * 0.4,
            //     child: Center(
            //       child: Text(
            //         'Поменять',
            //         style: TextStyle(fontSize: height * 0.03),
            //       ),
            //     ),
            //     decoration: BoxDecoration(
            //         border: Border.all(),
            //         color: Color.fromRGBO(253, 234, 168, 1),
            //         borderRadius: BorderRadius.circular(height * 0.1)),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.05),
              child: Container(
                height: height * 0.2,
                width: width * 0.6,
                child: Column(
                  children: [
                    Container(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: nameHeroInput,
                        focusNode: focusNode,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: height * 0.01),
                        child: InkWell(
                          onTap: () async {
                            if (focusNode.hasFocus &&
                                nameHeroInput.text == "") {
                            } else {
                              String d;
                              String babki;
                              var kod = await FirebaseFirestore.instance
                                  .collection("promo")
                                  .where("action_name", isEqualTo: "qwer")
                                  .get()
                                  .then((value) {
                                value.docs.forEach((element) {
                                  d = element.id;
                                  babki = element.data()['cost'];
                                });
                              });
                              if (d == null) {
                                nameHeroInput.clear();
                              } else {
                                FirebaseFirestore.instance
                                    .collection('promo')
                                    .doc(d)
                                    .collection('promo_code')
                                    .get()
                                    .then((value) {
                                  value.docs.forEach((element) {
                                    if (element.data()["promo_code"] ==
                                        nameHeroInput.text) {
                                      FirebaseFirestore.instance
                                          .collection('promo')
                                          .doc(d)
                                          .collection('promo_code')
                                          .doc(element.id)
                                          .delete()
                                          .then((value) {
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(userFireBase.uid)
                                            .update({
                                          "diamonds":
                                              diamonds + int.parse(babki),
                                        });
                                      });
                                    } else {
                                      setState(() {});
                                      nameHeroInput.clear();
                                      swapDiamonds();
                                    }
                                  });
                                });
                              }
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
                              child: Text('Ввести промокод',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 0.027)),
                            ),
                          ),
                        )
                        // child: AnimatedButton(
                        //   color: Color.fromRGBO(179, 68, 108, 1),
                        //   child: Text(
                        //     'Ввести промокод',
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //       color: Colors.white,
                        //       // fontWeight: FontWeight.w500,
                        //       // fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        //   onPressed: () async {
                        //     if (focusNode.hasFocus && nameHeroInput.text == "") {
                        //     } else {
                        //       String d;
                        //       String babki;
                        //       var kod = await Firestore.instance
                        //           .collection("promo")
                        //           .where("action_name", isEqualTo: "qwer")
                        //           .getDocuments()
                        //           .then((value) {
                        //         value.documents.forEach((element) {
                        //           d = element.documentID;
                        //           babki = element.data['cost'];
                        //         });
                        //       });

                        //       print(kod);
                        //       print(d);

                        //       if (d == null) {
                        //       } else {
                        //         print("айсберг");
                        //         print(d);
                        //         print(nameHeroInput.text);
                        //         Firestore.instance
                        //             .collection('promo')
                        //             .document(d)
                        //             .collection('promo_code')
                        //             .getDocuments()
                        //             .then((value) {
                        //           value.documents.forEach((element) {
                        //             if (element.data["promo_code"] ==
                        //                 nameHeroInput.text) {
                        //               print(diamonds);
                        //               print(babki);
                        //               print("aaqqwwweeerrr");
                        //               Firestore.instance
                        //                   .collection('promo')
                        //                   .document(d)
                        //                   .collection('promo_code')
                        //                   .document(element.documentID)
                        //                   .delete()
                        //                   .then((value) {
                        //                 Firestore.instance
                        //                     .collection('users')
                        //                     .document(userFireBase.uid)
                        //                     .updateData({
                        //                   "diamonds": diamonds + int.parse(babki),
                        //                 });
                        //               });
                        //             } else {
                        //               setState(() {});
                        //               nameHeroInput.clear();
                        //               swapDiamonds();
                        //             }
                        //           });
                        //         });
                        //       }
                        //     }
                        //   },
                        // ),
                        )

                    // InkWell(
                    //   onTap: () async {
                    //     if (focusNode.hasFocus && nameHeroInput.text == "") {
                    //     } else {
                    //       String d;
                    //       String babki;
                    //       var kod = await Firestore.instance
                    //           .collection("promo")
                    //           .where("action_name", isEqualTo: "qwer")
                    //           .getDocuments()
                    //           .then((value) {
                    //         value.documents.forEach((element) {
                    //           d = element.documentID;
                    //           babki = element.data['cost'];
                    //         });
                    //       });

                    //       print(kod);
                    //       print(d);

                    //       if (d == null) {
                    //       } else {
                    //         print("айсберг");
                    //         print(d);
                    //         print(nameHeroInput.text);
                    //         Firestore.instance
                    //             .collection('promo')
                    //             .document(d)
                    //             .collection('promo_code')
                    //             .getDocuments()
                    //             .then((value) {
                    //           value.documents.forEach((element) {
                    //             if (element.data["promo_code"] ==
                    //                 nameHeroInput.text) {
                    //               print(diamonds);
                    //               print(babki);
                    //               print("aaqqwwweeerrr");
                    //               Firestore.instance
                    //                   .collection('promo')
                    //                   .document(d)
                    //                   .collection('promo_code')
                    //                   .document(element.documentID)
                    //                   .delete()
                    //                   .then((value) {
                    //                 Firestore.instance
                    //                     .collection('users')
                    //                     .document(userFireBase.uid)
                    //                     .updateData({
                    //                   "diamonds": diamonds + int.parse(babki),
                    //                 });
                    //               });
                    //             } else {
                    //               setState(() {});
                    //               nameHeroInput.clear();
                    //               swapDiamonds();
                    //             }
                    //           });
                    //         });
                    //       }
                    //     }
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsets.only(top: height * 0.02),
                    //     child: Container(
                    //       padding: EdgeInsets.all(height * 0.01),
                    //       height: height * 0.05,
                    //       width: width * 0.4,
                    //       child: Center(
                    //         child: Text('Введи промокод '),
                    //       ),
                    //       decoration: BoxDecoration(
                    //           color: Color.fromRGBO(253, 234, 168, 1),
                    //           border: Border.all(),
                    //           borderRadius:
                    //               BorderRadius.circular(height * 0.02)),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
