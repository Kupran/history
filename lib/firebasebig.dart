import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:questbook/Object.dart';
import 'package:questbook/Stories.dart';
import 'package:http/http.dart' as http;

import 'UserInfoGlaf.dart';

class FirebaseBunt extends StatefulWidget {
  String language;
  @override
  FirebaseBuntState createState() => FirebaseBuntState();
}

class FirebaseBuntState extends State<FirebaseBunt> {
  double number = 0;
  double progres = 0;
  var imageE = 0;
  var audioO = 0;
  List<Story> listStories = new List();
  List<Episode> listEpisodes = new List();
  List<Button> listButtons = new List();

  List<Language> listLanguage = new List();
  int status;
  List listStoriesBuy = List();
  Future FirebaseLoading() async {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    listStories.clear();
    listButtons.clear();
    listEpisodes.clear();
    var setFirebaseStories = await FirebaseFirestore.instance
        .collection("users")
        .doc(userFireBase.uid)
        .collection("history")
        .doc("StoriesBuy")
        .get();
    if (setFirebaseStories.data() == null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(userFireBase.uid)
          .collection("history")
          .doc("StoriesBuy")
          .set({
        "storiesBuy": listStoriesBuy,
      });
    } else {
      listStoriesBuy.addAll(setFirebaseStories.data()['storiesBuy']);
    }
    final firestore = FirebaseFirestore.instance.collection('stories');

    var storiesArr = await firestore.where('release', isEqualTo: true).get();

    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    // number = number + storiesArr.documents.length;
    // FirebaseCrashlytics.instance.crash();
    storiesArr.docs.length >= 10
        ? progres = 10 / storiesArr.docs.length
        : progres = 1 / storiesArr.docs.length;
    for (var a = 0; a < storiesArr.docs.length; a++) {
      var story = storiesArr.docs[a];
      final firestoreStory = firestore.doc(story.id);
      var storiesValuesArr = await firestoreStory.collection("values").get();
      List<StoriesValues> listStoriesValues = new List();
      for (var d = 0; d < storiesValuesArr.docs.length; d++) {
        var storyValue = storiesValuesArr.docs[d];
        listStoriesValues.add(new StoriesValues(
            storyValue.data()['title'],
            storyValue.data()['description'],
            storyValue.data()['language'],
            storyValue.data()['specifications_hero']));
      }

      var episodesArr = await firestoreStory
          .collection("episodes")
          .where('release', isEqualTo: true)
          .get();

      for (var b = 0; b < episodesArr.docs.length; b++) {
        print('episode');
        var episode = episodesArr.docs[b];

        final firestoreEpisode =
            firestoreStory.collection("episodes").doc(episode.id);

        var episodesValuesArr =
            await firestoreEpisode.collection("values").get();
        List<EpisodeValues> listEpisodeValues = new List();

        for (var d = 0; d < episodesValuesArr.docs.length; d++) {
          var episodeValue = episodesValuesArr.docs[d];
          listEpisodeValues.add(new EpisodeValues(
            episodeValue.data()['title'],
            episodeValue.data()['description'],
            episodeValue.data()['language'],
            episodeValue.data()['specifications_hero'],
          ));
        }
        listEpisodes.add(new Episode(
            listEpisodeValues,
            episode.data()["url_episode_image"],
            episode.data()["name_episode_image"],
            episode.data()["name_audio"],
            episode.data()["url_audio"],
            episode.id));
      }

      listStories.add(
        new Story(
          listStoriesValues,
          story.data()["url_story_image"],
          story.data()["name_story_image"],
          listEpisodes,
          story.id,
          story.data()["withAnimal"],
          story.data()["story_cost"],
        ),
      );

      listEpisodes = [];
    }
    return listStories;
  }

  Future Loading() async {
    List<Story> listStories = await FirebaseLoading();
    listStories.length >= 10
        ? progres = 10 / listStories.length
        : progres = 1 / listStories.length;
    print("start_for");
    for (var a = 0; a < listStories.length; a++) {
      print('История');
      var storyImageName = listStories[a].imageName;
      var storyImageUrl = listStories[a].imageUrl;
      await loading(storyImageName, storyImageUrl);
      var listEpisodes = listStories[a].listEpisodes;
      for (var b = 0; b < listEpisodes.length; b++) {
        print(listEpisodes.length.toString());
        print('Эпизод');
        var musicName = listEpisodes[b].nameAudio;
        var musicUrl = listEpisodes[b].urlAudio;
        var episodeImageName = listEpisodes[b].imageName;
        var episodeImageUrl = listEpisodes[b].imageUrl;
        await loading(episodeImageName, episodeImageUrl);
        await loadingEpisodeMusic(musicName, musicUrl);
        print("Название музыки" + listEpisodes[b].nameAudio);
        print("Url музыки " + listEpisodes[b].urlAudio);
      }
      number = number + progres;
      tream(number);
    }
    await functiaTimeLocal();
    print("конец");
    return listStories;
  }

  Future loading(String imageName, String imageUrl) async {
    await downloadImage(imageName, imageUrl);
  }

  Future loadingEpisodeMusic(String imageName, String imageUrl) async {
    await downloadMusic(imageName, imageUrl);
  }

  Future loadingScenesMusic(String musicName, String musicUrl) async {
    await downloadMusic(musicName, musicUrl);
  }

  Future loadingScene(String imageName, String imageUrl,
      String backgroundImageName, String backgroundImageUrl) async {
    await downloadImage(imageName, imageUrl);
    await downloadImage(backgroundImageName, backgroundImageUrl);
  }

  Future<dynamic> downloadMusic(String fileName, String url) async {
    print("Загрузка музыки");
    if (fileName.isNotEmpty || url.isNotEmpty) {
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/$fileName');
      if (!file.existsSync()) {
        print("новая музыка");
        var retesttt = await http.get(url);
        var bytes = retesttt.bodyBytes;
        await file.writeAsBytes(bytes);
        audioO = audioO + file.lengthSync();
        print(audioO);
        return bytes;
      } else {
        print("старая музыка");
        audioO = audioO + file.lengthSync();
        print(audioO);
        return;
      }
    } else {
      return;
    }
  }

  int hour;
  int minuts;
  int seconds;
  DateTime dateTime = DateTime.now();
  functiaTimeLocal() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File fileDay = new File('$dir/day');
    File fileHour = new File('$dir/hour');
    File fileMinuts = new File('$dir/minuts');
    File fileSeconds = new File('$dir/seconds');
    if (!fileDay.existsSync()) {
      hour = 0;
      minuts = 0;
      seconds = 0;
    } else {
      var bytes = await fileDay.readAsString();
      var dayLocalInt = int.parse(bytes);
      var dayNow = dateTime.day;
      if (dayLocalInt > dayNow || dayLocalInt < dayNow) {
        hour = 0;
        minuts = 0;
        seconds = 0;
      } else {
        if (!fileHour.existsSync()) {
          hour = 0;
        } else {
          var minutsBytes = await fileMinuts.readAsString();
          var hourBytes = await fileHour.readAsString();
          var minutsLocal = int.parse(minutsBytes);
          var hourLocal = int.parse(hourBytes);
          var minutNow = dateTime.minute;
          var hourNow = dateTime.hour;
          if (hourLocal > hourNow) {
            hour = hourLocal - hourNow;
            if (hour > 1) {
              hour = 1;
              minuts = 60 - minutNow + minutsLocal;
              seconds = 0;
            } else {
              minuts = 60 - minutNow + minutsLocal;
              if (minuts > 60) {
                hour = 1;
                minuts = minuts - 60;
              } else {
                hour = 0;
                minuts = minuts;
              }
              seconds = 0;
            }
          } else {}
        }
      }
    }
  }

  Future<dynamic> downloadImage(String fileName, String url) async {
    if (fileName.isNotEmpty || url.isNotEmpty) {
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/$fileName');
      if (!file.existsSync()) {
        print("новое");
        print(fileName);
        var retesttt = await http.get(url);
        // print(retesttt.)
        var bytes = retesttt.bodyBytes;
        await file.writeAsBytes(bytes);
        imageE = imageE + file.lengthSync();
        print(imageE);

        return bytes;
      } else {
        print("старое");
        print(fileName);
        imageE = imageE + file.lengthSync();
        print(imageE);
        var image = await file.readAsBytes();
        return image;
      }
    } else {
      return;
    }
  }

  var language;
  var onClickMusic;
  var onClickMesseng;
  functiaSaaaaa() {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userFireBase.uid)
        .get()
        .then((value) {
      language = value.data()['language'];
      onClickMusic = value.data()['onClickMusic'];
      onClickMesseng = value.data()['onClickMesseng'];
    });
  }

  StreamController<double> controller = StreamController<double>();

  Stream<double> tream([double number]) {
    controller.add(number);
    Stream stream = controller.stream;
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    functiaTimeLocal();
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Container(
            child: FutureBuilder(
                future: Loading(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    FirebaseFirestore.instance
                        .collection('language')
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        listLanguage.add(new Language(
                            element.data()['language'],
                            element.data()['short']));
                      });
                    });
                    return Container(
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userFireBase.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            language = snapshot.data['language'];
                            onClickMusic = snapshot.data['onClickMusic'];
                            onClickMesseng = snapshot.data['onClickMesseng'];
                            return Builder(builder: (BuildContext context) {
                              return Stories(
                                  listStories,
                                  listLanguage,
                                  language,
                                  onClickMesseng,
                                  onClickMusic,
                                  hour,
                                  minuts,
                                  seconds,
                                  listStoriesBuy);
                            });
                          } else {
                            return Container(
                              child: Center(),
                            );
                          }
                        },
                      ),
                    );
                  } else
                    return Container(
                      child: Center(
                        child: Container(
                            height: height * 0.3,
                            // width: height * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // color: Colors.red,
                                  height: height * 0.2,
                                  width: height * 0.2,
                                  child: StreamBuilder(
                                    stream: tream(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return LiquidCircularProgressIndicator(
                                          value:
                                              snapshot.data, // Defaults to 0.5.
                                          valueColor: AlwaysStoppedAnimation(Colors
                                              .pink), // Defaults to the current Theme's accentColor.
                                          backgroundColor: Colors
                                              .white, // Defaults to the current Theme's backgroundColor.
                                          borderColor: Colors.red,
                                          borderWidth: 5.0,
                                          direction: Axis
                                              .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                          center: Material(
                                            color: Color.fromRGBO(0, 0, 0, 0),
                                          ),
                                        );
                                      } else {
                                        return LiquidCircularProgressIndicator(
                                          value:
                                              snapshot.data, // Defaults to 0.5.
                                          valueColor: AlwaysStoppedAnimation(Colors
                                              .pink), // Defaults to the current Theme's accentColor.
                                          backgroundColor: Colors
                                              .white, // Defaults to the current Theme's backgroundColor.
                                          borderColor: Colors.red,
                                          borderWidth: 5.0,
                                          direction: Axis
                                              .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                          center: Material(
                                            color: Color.fromRGBO(0, 0, 0, 0),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.05),
                                    child: Container(
                                      // color: Colors.red,
                                      child: Text(
                                        "Проверяем данные",
                                        style: TextStyle(
                                            fontSize: height * 0.03,
                                            fontFamily: 'Nunito'),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                }),
          ),
        ),
      ),
    );
  }
}
