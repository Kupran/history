import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NetworkToLocalMusic extends StatefulWidget {
  String fileName;
  String url;

  NetworkToLocalMusic(
    this.fileName,
    this.url,
  );

  @override
  LoadImages createState() => new LoadImages(
        this.fileName,
        this.url,
      );
}

class LoadImages extends State<NetworkToLocalMusic> {
  String fileName;
  String url;
  String localFilePath;

  var dataBytes;

  LoadImages(
    this.fileName,
    this.url,
  ) {
    downloadImage();
  }

  // Future _loadFile() async {
  //   final bytes = await http.readBytes(url);
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/$fileName');
  //   await file.writeAsBytes(bytes);
  //   if (await file.exists()) {
  //     setState(() {
  //       localFilePath = file.path;
  //     });
  //   }
  // }
  Future downloadImage() async {
    final bytes = await http.readBytes(url);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$fileName');
    if (!file.existsSync()) {
      var retesttt = await http.get(url);
      var bytes = retesttt.bodyBytes;
      await file.writeAsBytes(bytes);
    } else {
      print("file есть" + fileName);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dataBytes != null) {
    } else {
      return new CircularProgressIndicator();
    }
  }
}
