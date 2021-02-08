import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

// class NetworkToLocalImage extends StatefulWidget {
//   String fileName;
//   String url;

//   NetworkToLocalImage(
//     this.fileName,
//     this.url,
//   );

//   @override
//   LoadImages createState() => new LoadImages(
//         this.fileName,
//         this.url,
//       );
// }

class NetworkToLocalImage {
  String fileName;
  String url;

  var dataBytes;

  NetworkToLocalImage(
    this.fileName,
    this.url,
  ) {
    print(this.fileName.toString());
    print('name');
    print(this.url.toString());
    print("url");
    downloadImage();
    // .then((bytes) {
    //   setState(() {
    //     dataBytes = bytes;
    //   });
    // });
  }
  Future<dynamic> downloadImage() async {
    String dir = (await getTemporaryDirectory()).path;
    print("Папка");
    print(dir.toString());
    File file = new File('$dir/$fileName');
    print('$dir/$fileName');
    if (!file.existsSync()) {
      print("новое");
      var retesttt = await http.get(url);
      var bytes = retesttt.bodyBytes;
      await file.writeAsBytes(bytes);
      return bytes;
    } else {
      print("старое");
      var image = await file.readAsBytes();
      return image;
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   if (dataBytes != null) {
  //     return new Image.memory(
  //       dataBytes,
  //     );
  //   } else {
  //     return new CircularProgressIndicator();
  //   }
  // }
}
