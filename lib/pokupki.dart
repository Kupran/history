// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';

// final String testID = 'gems_test';

// class MarketScreen extends StatefulWidget {
//   createState() => MarketScreenState();
// }

// class MarketScreenState extends State<MarketScreen> {
//   static const _productIds = {'product_1', 'product_2', 'product_3'};
//   InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
//   StreamSubscription<List<PurchaseDetails>> _subscription;
//   List<ProductDetails> _products = [];
//   @override
//   void initState() {
//     super.initState();
//     Stream purchaseUpdated =
//         InAppPurchaseConnection.instance.purchaseUpdatedStream;
//     _subscription = purchaseUpdated.listen((purchaseDetailsList) {
//       _listenToPurchaseUpdated(purchaseDetailsList);
//     }, onDone: () {
//       _subscription.cancel();
//     }, onError: (error) {
//       // handle error here.
//     });
//     initStoreInfo();
//   }

//   initStoreInfo() async {
//     ProductDetailsResponse productDetailResponse =
//         await _connection.queryProductDetails(_productIds);
//     if (productDetailResponse.error == null) {
//       setState(() {
//         _products = productDetailResponse.productDetails;
//       });
//     }
//   }

//   _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
//     purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
//       if (purchaseDetails.status == PurchaseStatus.pending) {
//         // show progress bar or something
//       } else {
//         if (purchaseDetails.status == PurchaseStatus.error) {
//           // show error message or failure icon
//         } else if (purchaseDetails.status == PurchaseStatus.purchased) {
//           // show success message and deliver the product.
//         }
//       }
//     });
//   }

//   _buyProduct() {
//     final PurchaseParam purchaseParam =
//         PurchaseParam(productDetails: _products[0]);
//     _connection.buyConsumable(purchaseParam: purchaseParam);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//     );
//   }
// }
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

final String testID = 'price';

class MarketScreen extends StatefulWidget {
  MarketScreenState createState() => MarketScreenState();
}

class MarketScreenState extends State<MarketScreen> {
  /// The In App Purchase plugin
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  /// Is the API available on the device
  bool available = true;

  /// Products for sale
  List<ProductDetails> _products = [];

  /// Past purchases
  List<PurchaseDetails> _purchases = [];

  /// Updates to purchases
  StreamSubscription _subscription;

  /// Consumable credits the user can buy
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

  /// Initialize data
  void _initialize() async {
    // Check availability of In App Purchases
    var _available = await _iap.isAvailable();

    if (_available) {
      await _getProducts();
      await _getPastPurchases();

      // Verify and deliver a purchase with your own business logic
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
    // _iap.buyNonConsumable(purchaseParam: purchaseParam);
    _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  }

  Future<void> _getProducts() async {
    Set<String> ids = Set.from([testID, 'test_a']);
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

    // TODO serverside verification & record consumable in the database

    if (purchase != null && purchase.status == PurchaseStatus.purchased) {
      credits = 10;
    }
  }

  void _spendCredits(PurchaseDetails purchase) async {
    /// Decrement credits
    setState(() {
      credits--;
    });

    /// TODO update the state of the consumable to a backend database

    // Mark consumed when credits run out
    if (credits == 0) {
      var res = await _iap.consumePurchase(purchase);
      await _getPastPurchases();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(available ? 'Open for Business' : 'Not Available'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var prod in _products)
                if (_hasPurchased(prod.id) != null) ...[
                  Text('💎 $credits', style: TextStyle(fontSize: 60)),
                  FlatButton(
                    child: Text('Consume'),
                    color: Colors.green,
                    onPressed: () => _spendCredits(_hasPurchased(prod.id)),
                  )
                ]

                // UI if NOT purchased
                else ...[
                  Text(prod.title, style: Theme.of(context).textTheme.headline),
                  Text(prod.description),
                  Text(prod.price,
                      style:
                          TextStyle(color: Colors.greenAccent, fontSize: 60)),
                  FlatButton(
                    child: Text('Buy It'),
                    color: Colors.green,
                    onPressed: () => _buyProduct(prod),
                  ),
                ]
            ],
          ),
        ),
      ),
    );
  }

  // Private methods go here

}
