import 'dart:async';
import 'dart:io';
import 'package:animated_button/animated_button.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:questbook/Object.dart';
import 'Episodes.dart';
import 'Shop.dart';
import 'UserInfoGlaf.dart';
import 'package:http/http.dart' as http;

class ScenesState extends StatefulWidget {
  List listParametrInt;
  List listParametrsName;
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
  String storyDocumentId;
  List maps;

  ScenesState(
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
      this.listParametrsName,
      this.listParametrInt,
      this.listParametrsUserAll,
      maps);

  @override
  ScenesUser createState() => ScenesUser(this.keyy, this.diamonds);
}

class ListButtonSave {
  String text;
  String nextOrder;
  String currency;
  int cost;
  var select_hero;
  var show_for_hero;
  int ball;
  var show_ball;
  ListButtonSave(this.text, this.nextOrder, this.currency, this.cost,
      this.select_hero, this.ball, this.show_ball, this.show_for_hero);
}

class ImageInfoName {
  String nameImage;
  String namePrefexImage;
  var price;
  ImageInfoName(this.namePrefexImage, this.nameImage, this.price);
}

class ScenesUser extends State<ScenesState>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool forced_wardrobe = false;
  ImageCache kd = new ImageCache();
  AnimationController controller;
  AnimationController controller2;
  AnimationController controllerWarb;
  String order;
  String text;
  int direction;
  double x;
  double y;
  bool status = true;
  List<Button> list = new List();
  List<ListButtonSave> list1 = new List();
  List<Widget> listButtons = new List();
  int munts = 1;
  String nameImage;
  String urlImage;
  int count = 1;
  bool firstscene = true;
  int n = 0;
  String backName;
  String backUrl;
  bool a = true;
  var image;
  bool statuss = true;
  String nameAudio;
  String nameUrlAudio;
  Map mapSaveBac = new Map();
  Map mapSaveHero = new Map();
  AudioPlayer audioPlayer = AudioPlayer();
  double xBack;
  var statusInputName;
  bool statusWardrobe = false;
  List<Scene> listScenes = new List();
  int timeButtons;
  List<ImageAll> listAll = new List();
  List<ImageInfoBij> listImageInfoBij = List();
  List<ImageInfoClothes> listImageInfoClothes = List();
  List<ImageInfoHair> listImageInfoHair = List();
  List<ImageInfoLook> listImageInfoLook = List();
  List<Garderob> listGarderob = new List();
  List mlistParametrAll = new List();
  String emotionScenes;
  List mapWardrobeCloc = List();

  StreamController<double> controllerStream = StreamController<double>();
  StreamController<double> controllerStream1 = StreamController<double>();
  StreamController<double> controllerStream2 = StreamController<double>();

  functiaPereborListParemetrs(List list) {
    for (var i = 0; i < list.length; i++) {
      mlistParametrAll.add(0);
      // mlistParametrAll[list[i]] = 0;
    }
  }

  double numberStream = 0.0;
  double progresStrean = 0.0;
  double col = 0.0;

  Stream<double> tream([double number]) {
    controllerStream.add(number);
    Stream stream = controllerStream.stream;
    return stream;
  }

  Stream<double> tream1([double number]) {
    controllerStream1.add(number);
    Stream stream = controllerStream1.stream;
    return stream;
  }

  Stream<double> tream2([double number]) {
    controllerStream2.add(number);
    Stream stream = controllerStream2.stream;
    return stream;
  }

  functiaServerScene() async {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    var t = await FirebaseFirestore.instance
        .collection('users')
        .doc(userFireBase.uid)
        .collection('history')
        .doc("Wardrobe")
        .get();

    if (t.data() == null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userFireBase.uid)
          .collection('history')
          .doc("Wardrobe")
          .set({
        'Wardrobe': mapWardrobeCloc,
      });
    } else {
      mapWardrobeCloc = t.data()['Wardrobe'];
    }
    var bij = await FirebaseFirestore.instance
        .collection('stories')
        .doc(widget.storyDocumentId)
        .collection("bij")
        .get();

    if (bij.docs.length != null) {
      for (var d = 0; d < bij.docs.length; d++) {
        print('bij');
        var storiesBjkInfo = bij.docs[d];
        listImageInfoBij.add(new ImageInfoBij(
            storiesBjkInfo.data()['available_bij'],
            storiesBjkInfo.data()['ball_bij'],
            storiesBjkInfo.data()['episode_bij'],
            storiesBjkInfo.data()['img_name'],
            storiesBjkInfo.data()['img_url'],
            storiesBjkInfo.data()['name_bij'],
            storiesBjkInfo.data()['prefix_bij'],
            storiesBjkInfo.data()['price_bij'],
            storiesBjkInfo.data()['select_hero_bij']));
      }
    }
    var clothes = await FirebaseFirestore.instance
        .collection('stories')
        .doc(widget.storyDocumentId)
        .collection("clothes")
        .get();
    // col = col + clothes.documents.length.toDouble();
    if (clothes.docs.length != null) {
      for (var d = 0; d < clothes.docs.length; d++) {
        print('clothes');
        var storiesClithesInfo = clothes.docs[d];
        listImageInfoClothes.add(new ImageInfoClothes(
            storiesClithesInfo.data()['available_clothes'],
            storiesClithesInfo.data()['ball_clothes'],
            storiesClithesInfo.data()['episode_clothes'],
            storiesClithesInfo.data()['img_name'],
            storiesClithesInfo.data()['img_url'],
            storiesClithesInfo.data()['name_clothes'],
            storiesClithesInfo.data()['prefix_clothes'],
            storiesClithesInfo.data()['price_clothes'],
            storiesClithesInfo.data()['select_hero_clothes']));
      }
    }
    var hair = await FirebaseFirestore.instance
        .collection('stories')
        .doc(widget.storyDocumentId)
        .collection("hair")
        .get();
    // col = col + hair.documents.length.toDouble();
    if (hair.docs.length != null) {
      for (var d = 0; d < hair.docs.length; d++) {
        print('hair');
        var storiesHairInfo = hair.docs[d];
        listImageInfoHair.add(new ImageInfoHair(
            storiesHairInfo.data()['available_hair'],
            storiesHairInfo.data()['ball_hair'],
            storiesHairInfo.data()['episode_hair'],
            storiesHairInfo.data()['img_name'],
            storiesHairInfo.data()['img_url'],
            storiesHairInfo.data()['name_hair'],
            storiesHairInfo.data()['prefix_hair'],
            storiesHairInfo.data()['price_hair'],
            storiesHairInfo.data()['select_hero_hair']));
      }
    }
    var look = await FirebaseFirestore.instance
        .collection('stories')
        .doc(widget.storyDocumentId)
        .collection("look")
        .get();
    // col = col + look.documents.length.toDouble();
    if (look.docs.length != null) {
      for (var d = 0; d < look.docs.length; d++) {
        print('look');
        var storieslookInfo = look.docs[d];
        listImageInfoLook.add(new ImageInfoLook(
            storieslookInfo.data()['available_look'],
            storieslookInfo.data()['ball_look'],
            storieslookInfo.data()['episode_look'],
            storieslookInfo.data()['img_name'],
            storieslookInfo.data()['img_url'],
            storieslookInfo.data()['name_look'],
            storieslookInfo.data()['prefix_look'],
            storieslookInfo.data()['price_look'],
            storieslookInfo.data()['select_hero_look']));
      }
    }
    var image = await FirebaseFirestore.instance
        .collection('stories')
        .doc(widget.storyDocumentId)
        .collection("image")
        .get();
    // col = col + image.documents.length.toDouble();
    if (image.docs.length != null) {
      for (var d = 0; d < image.docs.length; d++) {
        print('image');
        var storiesBjkInfo = image.docs[d];
        listAll.add(new ImageAll(
          storiesBjkInfo.data()['forced_wardrobe'],
          storiesBjkInfo.data()['img_name'],
          storiesBjkInfo.data()['img_url'],
        ));
      }
    }
    for (var i = 0; i < listImageInfoBij.length; i++) {
      for (var j = 0; j < mapWardrobeCloc.length; j++) {
        if (listImageInfoBij[i].prefix_bij == mapWardrobeCloc[j]) {
          listImageInfoBij[i].price_bij = 0;
        }
      }
    }
    for (var i = 0; i < listImageInfoClothes.length; i++) {
      for (var j = 0; j < mapWardrobeCloc.length; j++) {
        if (listImageInfoClothes[i].prefix_clothes == mapWardrobeCloc[j]) {
          listImageInfoClothes[i].price_clothes = 0;
        }
      }
    }
    for (var i = 0; i < listImageInfoHair.length; i++) {
      for (var j = 0; j < mapWardrobeCloc.length; j++) {
        if (listImageInfoHair[i].prefix_hair == mapWardrobeCloc[j]) {
          listImageInfoHair[i].price_hair = 0;
        }
      }
    }
    for (var i = 0; i < listImageInfoLook.length; i++) {
      for (var j = 0; j < mapWardrobeCloc.length; j++) {
        if (listImageInfoLook[i].prefix_look == mapWardrobeCloc[j]) {
          listImageInfoLook[i].price_look = 0;
        }
      }
    }
    listGarderob.add(new Garderob(listAll, listImageInfoBij,
        listImageInfoClothes, listImageInfoHair, listImageInfoLook));

    var scenes = await FirebaseFirestore.instance
        .collection('stories')
        .doc(widget.storyDocumentId)
        .collection('episodes')
        .doc(widget.episodedocumentID)
        .collection('scenes')
        .get();
    col = col + scenes.docs.length.toDouble();

    progresStrean = 1.0 / col.toDouble();

    for (var i = 0; i < scenes.docs.length; i++) {
      print("scenes");
      var scenesDocuments = scenes.docs[i];
      var scenesValues = await FirebaseFirestore.instance
          .collection('stories')
          .doc(widget.storyDocumentId)
          .collection('episodes')
          .doc(widget.episodedocumentID)
          .collection('scenes')
          .doc(scenes.docs[i].id)
          .collection('values')
          .get();
      List<ScenesValues> listScenesValues = new List();
      for (var i = 0; i < scenesValues.docs.length; i++) {
        print("listValues");
        var scenesValuesDocuments = scenesValues.docs[i];
        listScenesValues.add(new ScenesValues(
          scenesValuesDocuments.data()['language'],
          scenesValuesDocuments.data()['hero_text'],
          scenesValuesDocuments.data()['hero_name'],
        ));
      }
      var scenesButtons = await FirebaseFirestore.instance
          .collection('stories')
          .doc(widget.storyDocumentId)
          .collection('episodes')
          .doc(widget.episodedocumentID)
          .collection('scenes')
          .doc(scenesDocuments.id)
          .collection('buttons')
          .get();

      if (scenesButtons.docs.length > 0) {
        List<Button> listButtons = new List();

        for (var i = 0; i < scenesButtons.docs.length; i++) {
          List<ButtonValue> listButtonValues = new List();
          print("Кнопака есть");
          var documentButton = scenesButtons.docs[i];
          var document = scenesButtons.docs[i].id;
          print(document);

          var scenesValuesButtons = await FirebaseFirestore.instance
              .collection('stories')
              .doc(widget.storyDocumentId)
              .collection('episodes')
              .doc(widget.episodedocumentID)
              .collection('scenes')
              .doc(scenesDocuments.id)
              .collection('buttons')
              .doc(document)
              .collection('values')
              .get();

          print(scenesValuesButtons.docs.length);
          for (var i = 0; i < scenesValuesButtons.docs.length; i++) {
            var buttonValue = scenesValuesButtons.docs[i];
            listButtonValues.add(new ButtonValue(
                buttonValue.data()['button_text'],
                buttonValue.data()['language']));
          }
          listButtons.add(new Button(
              listButtonValues,
              documentButton.data()["next_order"],
              documentButton.data()["currency"],
              documentButton.data()["cost"],
              documentButton.data()["select_hero"],
              documentButton.data()["ball"],
              documentButton.data()["show_ball"],
              documentButton.data()["show_for_hero"]));

          print(listButtons.length);
        }
        print(scenesDocuments.data()["order"]);
        listScenes.add(new Scene.button(
          scenesDocuments.data()["time"],
          scenesDocuments.data()["first_scene"],
          scenesDocuments.data()["name_hero_img"],
          scenesDocuments.data()["url_hero_img"],
          scenesDocuments.data()["name_background_img"],
          scenesDocuments.data()["url_background_img"],
          scenesDocuments.data()["order"],
          scenesDocuments.data()["direction"],
          scenesDocuments.data()["hero_self"],
          listButtons,
          scenesDocuments.data()['name_audio'],
          scenesDocuments.data()['url_audio'],
          listScenesValues,
        ));
      } else {
        listScenes.add(new Scene(
          scenesDocuments.data()["time"],
          scenesDocuments.data()["first_scene"],
          scenesDocuments.data()["name_hero_img"],
          scenesDocuments.data()["url_hero_img"],
          scenesDocuments.data()["name_background_img"],
          scenesDocuments.data()["url_background_img"],
          scenesDocuments.data()["order"],
          scenesDocuments.data()["next_order"],
          scenesDocuments.data()["direction"],
          scenesDocuments.data()["hero_self"],
          scenesDocuments.data()['name_audio'],
          scenesDocuments.data()['url_audio'],
          listScenesValues,
          scenesDocuments.data()['forced_wardrobe'] == null
              ? false
              : scenesDocuments.data()['forced_wardrobe'],
          scenesDocuments.data()['prefix_emotion'],
        ));
      }
      numberStream = numberStream + progresStrean;
      tream(numberStream);
    }

    return listScenes;
  }

  int priceClothes = 0;

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

  var imageE = 0;
  var audioO = 0;
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

  Future Loading() async {
    List<Scene> listScenes = await functiaServerScene();
    print("start_for");
    // listScenes.length >= 10
    //     ? progresStrean = 10.0 / listScenes.length.toDouble()
    //     : progresStrean = 1.0 / listScenes.length.toDouble();
    for (var a = 0; a < listScenes.length; a++) {
      print('Scenes');
      var storyImageName = listScenes[a].heroImageName;
      var storyImageUrl = listScenes[a].heroImageUrl;
      var backgroundImageName = listScenes[a].backgroundImageName;
      var backgroundImageUrl = listScenes[a].backgroundImageUrl;
      var musicName = listScenes[a].nameAudio;
      var musicNameurl = listScenes[a].urlAudio;
      await loading(storyImageName, storyImageUrl);
      await loading(backgroundImageName, backgroundImageUrl);
      await loadingEpisodeMusic(musicName, musicNameurl);
      // numberStream = numberStream + progresStrean;
      // tream(numberStream);
    }
    print("конец");
    return listScenes;
  }

  double yBack;
  int musicStatus = 0;
  bool boole = true;
  String nameHero;
  int vin;
  // int babki;
  int keyy;
  bool statusEnd = false;
  int diamonds;
  TextEditingController nameHeroInput = new TextEditingController();
  TextEditingController nameAnimalInput = new TextEditingController();
  String nextOrder = "";
  ScenesUser(this.keyy, this.diamonds);

  functiaPereborButton() {
    list1.clear();
    print("${list.length}" + " " + " Длинна массива Тартататататататата");
    for (var t = 0; t < list.length; t++) {
      print("${list[t].list.length}" + " " + " Длинна массива фывфывсйцсйцусв");
      for (var i = 0; i < list[t].list.length; i++) {
        print("Кнопака есть12123123 ");
        if (list[t].list[i].language == widget.language) {
          print("fkrj");
          coinsButtons = coinsButtons + list[t].cost;
          list1.add(new ListButtonSave(
              list[t].list[i].text,
              list[t].nextOrder,
              list[t].currency,
              list[t].cost,
              list[t].select_hero,
              list[t].ball,
              list[t].show_ball,
              list[t].show_for_hero));
        }
      }
    }
    print("${list1.length}");
  }

  var direeec;

  musicPlay(String nameAudi, int statusMusic) async {
    print(nameAudi);
    print("АГАГАГАГАГАГААГАГ");
    if (widget.onMusic == 'off') {
    } else {
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/$nameAudi');
      direeec = dir;

      if (nameAudio != null && statusMusic != null) {
        if (statusMusic == 0) {
          if (!file.existsSync()) {
          } else {
            await audioPlayer
                .play(file.path, isLocal: true)
                .whenComplete(() => audioPlayer.resume());
          }
        } else if (statusMusic == 1) {
          if (!file.existsSync()) {
          } else {
            await audioPlayer.stop();
            await audioPlayer.play(file.path, isLocal: true);
          }
        } else if (statusMusic == 2) {
          await audioPlayer.stop();
        }
      }
    }
  }

  // var doder = false;
  int out = 0;

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    musicPlay("Конец", 2);
    ImageCache image = ImageCache();
    image.clear();
  }

  var imageStart;
  AnimationController controllerIcon;
  AnimationController _controller;
  Animation<Size> _myAnimation;
  LoopPageController controllerTextImage = new LoopPageController();
  LoopPageController controllerTextImage1 = new LoopPageController();
  LoopPageController controllerTextImage2 = new LoopPageController();
  LoopPageController controllerTextImage3 = new LoopPageController();
  String nameImageHero;
  @override
  void initState() {
    super.initState();
    // scrollController.animateTo(offset)
    for (var i = 0; i < widget.listParametrInt.length; i++) {
      print(widget.listParametrInt);
    }
    WidgetsBinding.instance.addObserver(this);
    print(widget.episodedocumentID);
    print(widget.storyDocumentId);
    // functiaPereborGarderob('bij', 1);
    imageStart = controllerIcon = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    order = widget.saveOrder;
    nameAudio = widget.nameAudio;
    controllerWarb = controller =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
    controller =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
    controller.forward();
    controller2 =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
  }

  var name = "Сохранить";
  var nameHeroSave;
  var nameAnimalSave;
  FocusNode focusNode = FocusNode();
  FocusNode focusNodeQ = FocusNode();
  functiaSize() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    var height = MediaQuery.of(context).size.height;
    _controller.forward();
    _myAnimation = Tween<Size>(
            begin: Size(height * 0.06, height * 0.06),
            end: Size(height * 0.07, height * 0.07))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInCirc));
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });
  }

  functiaPerebor() {
    print("functiaPerebor");
    print(listScenes.length);
    for (var o = 0; o < listScenes.length; o++) {
      if (n == 0) {
        for (var a = 0; a < listScenes.length; a++) {
          if (listScenes[a].order == widget.saveOrder) {
            for (var b = 0; b < listScenes[a].listScenesValues.length; b++) {
              if (listScenes[a].listScenesValues[b].language ==
                  widget.language) {
                nameHero = listScenes[a].listScenesValues[b].heroName;
                text = listScenes[a].listScenesValues[b].heroText;
              }
            }
            // nameHero = widget.listScenes[a].listScenesValues[0].heroName;
            nextOrder = listScenes[a].nextOrder;
            timeButtons = listScenes[a].time;
            backName = listScenes[a].backgroundImageName;
            backUrl = listScenes[a].backgroundImageUrl;
            // text = widget.listScenes[a].listScenesValues[0].heroText;
            direction = listScenes[a].direction;
            order = listScenes[a].order;
            nameImage = listScenes[a].heroImageName;
            urlImage = listScenes[a].heroImageUrl;
            emotion = "e" + listScenes[o].emotion.toString();
            if (listScenes[a].nameAudio == "") {
              // nameAudio = nameAudio;
            } else {
              nameAudio = listScenes[a].nameAudio;
            }
            nameUrlAudio = listScenes[a].urlAudio;
            forced_wardrobe = listScenes[a].forced_wardrobe;

            if (forced_wardrobe == true) {
              statusWardrobe = true;
              statusOM = 2;
            }
            n = 2;
            if (order == null) {
              status = false;
              statuss = false;
              list = listScenes[a].listButtons;
              functiaPereborButton();
              functiaListButtons();
            } else {
              status = true;
              statuss = true;
              listButtons.clear();
            }
            break;
          }
          out = out + 1;
          if (out >= listScenes.length) {
            for (var a = 0; a < listScenes.length; a++) {
              if (listScenes[a].status == true) {
                for (var b = 0;
                    b < listScenes[a].listScenesValues.length;
                    b++) {
                  if (listScenes[a].listScenesValues[b].language ==
                      widget.language) {
                    nameHero = listScenes[a].listScenesValues[b].heroName;
                    text = listScenes[a].listScenesValues[b].heroText;
                  }
                }
                nextOrder = listScenes[a].nextOrder;
                emotion = "e" + listScenes[o].emotion.toString();
                timeButtons = listScenes[a].time;
                // nameHero = widget.listScenes[a].listScenesValues[0].heroName;
                backName = listScenes[a].backgroundImageName;
                backUrl = listScenes[a].backgroundImageUrl;
                // text = widget.listScenes[a].listScenesValues[0].heroText;
                direction = listScenes[a].direction;
                order = listScenes[a].order;
                nameImage = listScenes[a].heroImageName;
                urlImage = listScenes[a].heroImageUrl;
                print(order);
                if (listScenes[a].nameAudio == "") {
                  // nameAudio = nameAudio;
                } else {
                  nameAudio = listScenes[a].nameAudio;
                }
                nameUrlAudio = listScenes[a].urlAudio;
                forced_wardrobe = listScenes[a].forced_wardrobe;

                if (forced_wardrobe == true) {
                  statusWardrobe = true;
                  statusOM = 2;
                }
                n = 2;
                if (order == null) {
                  status = false;
                  statuss = false;
                  list = listScenes[a].listButtons;
                  functiaPereborButton();
                  functiaListButtons();
                }
                // else if (order == '') {
                //   statusEnd = true;
                // }
                else {
                  status = true;
                  statuss = true;
                  listButtons.clear();
                }
                break;
              }
            }
          }
        }
      } else if (n == 2) {
        if (order == listScenes[o].order) {
          for (var b = 0; b < listScenes[o].listScenesValues.length; b++) {
            if (listScenes[o].listScenesValues[b].language == widget.language) {
              nameHero = listScenes[o].listScenesValues[b].heroName;
              text = listScenes[o].listScenesValues[b].heroText;
            }
          }
          // nameHero = widget.listScenes[o].listScenesValues[0].heroName;
          nextOrder = listScenes[o].nextOrder;
          emotion = "e" + listScenes[o].emotion.toString();
          timeButtons = listScenes[o].time;
          backName = listScenes[o].backgroundImageName;
          backUrl = listScenes[o].backgroundImageUrl;
          // text = widget.listScenes[o].listScenesValues[0].heroText;
          direction = listScenes[o].direction;
          order = listScenes[o].nextOrder;
          nameImage = listScenes[o].heroImageName;
          urlImage = listScenes[o].heroImageUrl;
          print(order);
          if (listScenes[o].nameAudio == "") {
            // nameAudio = nameAudio;
          } else {
            nameAudio = listScenes[o].nameAudio;
          }
          nameUrlAudio = listScenes[o].urlAudio;
          forced_wardrobe = listScenes[o].forced_wardrobe;

          if (forced_wardrobe == true) {
            statusWardrobe = true;
            statusOM = 2;
          }

          if (order == null) {
            status = false;
            statuss = false;
            list = listScenes[o].listButtons;
            functiaPereborButton();
            functiaListButtons();
          }
          //  else if (order == '') {
          //   statusEnd = true;
          // }
          else {
            status = true;
            statuss = true;
            listButtons.clear();
          }
          break;
        }
      }
    }
  }

  bool statutttttttttt = false;

  functiaInfo() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.red,
      height: height * 0.15,
      width: width * 0.4,
      child: Text(''),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      musicPlay(nameAudio, 0);
      print("снова");
    } else if (state == AppLifecycleState.inactive) {
      audioPlayer.pause();
    } else if (state == AppLifecycleState.paused) {
      audioPlayer.pause();
    }
  }

  List listYeloy = [
    Color.fromRGBO(241, 156, 187, 1),
    Color.fromRGBO(241, 156, 187, 1),
    Color.fromRGBO(241, 156, 187, 1),
    Color.fromRGBO(241, 156, 187, 1),
    Color.fromRGBO(241, 156, 187, 1),
    Color.fromRGBO(241, 156, 187, 1),
  ];
  var point;
  var pointHeight = 0.0;
  var pointWidth = 0.0;
  var poinRadius = 0.0;
  Widget Poin() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnimatedSize(
      duration: Duration(milliseconds: 600),
      vsync: this,
      child: Container(
          height: pointHeight,
          width: pointWidth,
          decoration: BoxDecoration(
            color: Color.fromRGBO(179, 68, 108, 1),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(poinRadius),
          ),
          child: Padding(
            padding: EdgeInsets.all(height * 0.01),
            child: Center(
              child: FittedBox(
                child: Text("+$ballllll" " $point",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          )),
    );
  }

  var ballllll = 0;
  var coinsButtons = 0;

  // var indexListParametrsIndex;
  // var indexListParametrsBall;
  Color colorqq = Colors.red;
  int diamondsCost = 0;
  functiaListButtons() {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    listButtons.clear();
    // coinsButtons = 0;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    for (var a = 0; a < list1.length; a++) {
      var show_for_hero = list1[a].show_for_hero;
      var show_ball = list1[a].show_ball;
      var ddsa = 0;
      if (show_for_hero == 99) {
        for (var i = 0; i < widget.listParametrsUserAll.length; i++) {
          var result = widget.listParametrsUserAll[i];
          if (result >= show_ball) {
            ddsa = widget.listParametrsUserAll[i];
          }
        }
      } else {
        ddsa = widget.listParametrsUserAll[show_for_hero];
      }

      ddsa >= show_ball
          ? listButtons.add(
              Container(
                child: Container(
                  child: InkWell(
                    onTap: () async {
                      // coinsButtons = coinsButtons + list1[a].cost;
                      // var dos = diamonds - list1[a].cost;
                      if (diamonds < 0) {
                        setState(() {
                          pointHeight = height * 0.05;
                          pointWidth = width * 0.4;
                          poinRadius = height * 0.1;
                          print("aaaaaaaaaaa");
                          listButtons[a] = Container(
                            child: Container(
                              child: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(top: height * 0.001),
                                  child: Transform(
                                    transform: Matrix4.skewX(-0.2)
                                      ..rotateY(3.14 / 12.0),
                                    origin: Offset(50.0, 50.0),
                                    child: Coloris(list1[a].text, list[a].cost,
                                        Color.fromRGBO(253, 124, 110, 1)),
                                  ),
                                ),
                                onTap: () async {
                                  if (diamonds > list1[a].cost) {
                                    var d = list1[a].select_hero;
                                    var s = d.runtimeType == String
                                        ? list1[a].select_hero == ""
                                            ? 0
                                            : int.parse(list1[a].select_hero)
                                        : list1[a].select_hero;
                                    point = s == 99
                                        ? "+1 Всем характеристикам"
                                        : widget.listParametrsName[s];

                                    ballllll = list1[a].ball;
                                    if (widget.listParametrsUserAll.length - 1 <
                                        s) {
                                      if (s == 99) {
                                        for (var i = 0;
                                            i <
                                                widget.listParametrsUserAll
                                                    .length;
                                            i++) {
                                          var d = widget.listParametrInt[i];
                                          widget.listParametrInt[i] =
                                              d + ballllll;
                                        }
                                      } else {
                                        // widget.listParametrInt.add(ballllll);
                                      }
                                    } else {
                                      var d = widget.listParametrInt[s];
                                      widget.listParametrInt[s] = d + ballllll;
                                    }
                                    if (widget.listParametrsUserAll.length - 1 <
                                        s) {
                                      if (s == 99) {
                                        for (var i = 0;
                                            i <
                                                widget.listParametrsUserAll
                                                    .length;
                                            i++) {
                                          var d =
                                              widget.listParametrsUserAll[i];
                                          widget.listParametrsUserAll[i] =
                                              d + ballllll;
                                        }
                                      } else {
                                        // widget.listParametrInt.add(ballllll);
                                      }
                                      // widget.listParametrsUserAll.add(ballllll);
                                    } else {
                                      var r = widget.listParametrsUserAll[s];
                                      widget.listParametrsUserAll[s] =
                                          r + ballllll;
                                    }

                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userFireBase.uid)
                                        .collection('history')
                                        .doc(
                                            widget.storyDocumentId + "Wardrobe")
                                        .update({
                                      "ListParametrsUserAll":
                                          widget.listParametrsUserAll
                                    });
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userFireBase.uid)
                                        .collection('history')
                                        .doc(widget.episodedocumentID)
                                        .update({
                                      'listParametrs': widget.listParametrInt
                                    });
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userFireBase.uid)
                                        .update({
                                      "diamonds": diamonds,
                                      "key": keyy,
                                      "onClickMesseng": widget.onMesseng,
                                      "onClickMusic": widget.onMusic,
                                      "language": widget.language,
                                      // 'listParametrs': widget.listParametrInt
                                    });

                                    Future.delayed(const Duration(seconds: 1),
                                        () async {
                                      statusPoint = true;

                                      if (list1[a].nextOrder == "") {
                                        statusEnd = true;
                                        print("sssss");
                                      }
                                      await controller.reverse();
                                      order = list1[a].nextOrder;
                                      controller.forward();
                                      setState(() {
                                        pointHeight = height * 0.05;
                                        pointWidth = width * 0.4;
                                        poinRadius = height * 0.1;
                                        statusGo = true;
                                        element(
                                          x,
                                          y,
                                          xBack,
                                        );
                                      });
                                    });
                                    setState(() {
                                      pointHeight = height * 0.05;
                                      pointWidth = width * 0.4;
                                      poinRadius = height * 0.1;
                                      listButtons[a] = Container(
                                        child: Container(
                                          child: InkWell(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 0.001),
                                              child: Transform(
                                                transform: Matrix4.skewX(-0.2)
                                                  ..rotateY(3.14 / 12.0),
                                                origin: Offset(50.0, 50.0),
                                                child: Coloris(
                                                    list1[a].text,
                                                    list[a].cost,
                                                    Color.fromRGBO(
                                                        208, 240, 192, 1)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  } else {
                                    print("zzzz");
                                  }
                                },
                              ),
                            ),
                          );
                        });
                      } else {
                        print('Кнопка работает снова');
                        // coinsButtons = 0;
                        var indexListParametrsBall = list1[a].ball;
                        var v = list1[a].select_hero;
                        var indexListParametrsIndex = v == ""
                            ? 0
                            : v.runtimeType == String
                                ? int.parse(list1[a].select_hero)
                                : list1[a].select_hero;
                        ballllll = list1[a].ball;
                        if (widget.listParametrInt.length - 1 <
                            indexListParametrsIndex) {
                          if (indexListParametrsIndex == 99) {
                            for (var i = 0;
                                i < widget.listParametrInt.length;
                                i++) {
                              var d = widget.listParametrInt[i];
                              widget.listParametrInt[i] =
                                  d + indexListParametrsBall;
                            }
                          } else {
                            // widget.listParametrInt.add(ballllll);
                          }
                        } else {
                          var d =
                              widget.listParametrInt[indexListParametrsIndex];
                          widget.listParametrInt[indexListParametrsIndex] =
                              d + indexListParametrsBall;
                        }

                        if (widget.listParametrsUserAll.length - 1 <
                            indexListParametrsIndex) {
                          if (indexListParametrsIndex == 99) {
                            for (var i = 0;
                                i < widget.listParametrsUserAll.length;
                                i++) {
                              var d = widget.listParametrsUserAll[i];
                              widget.listParametrsUserAll[i] =
                                  d + indexListParametrsBall;
                            }
                          } else {}
                        } else {
                          var s = widget
                              .listParametrsUserAll[indexListParametrsIndex];
                          widget.listParametrsUserAll[indexListParametrsIndex] =
                              s + indexListParametrsBall;
                        }

                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(userFireBase.uid)
                            .collection('history')
                            .doc(widget.episodedocumentID)
                            .update({'listParametrs': widget.listParametrInt});
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(userFireBase.uid)
                            .collection('history')
                            .doc(widget.storyDocumentId + "Wardrobe")
                            .update({
                          "ListParametrsUserAll": widget.listParametrsUserAll
                        });
                        setState(() {
                          pointHeight = height * 0.05;
                          pointWidth = width * 0.4;
                          poinRadius = height * 0.1;
                          print("bbbbbbb");
                          listButtons[a] = Container(
                            child: Container(
                              child: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(top: height * 0.001),
                                  child: Transform(
                                    transform: Matrix4.skewX(-0.2)
                                      ..rotateY(3.14 / 12.0),
                                    origin: Offset(50.0, 50.0),
                                    child: Coloris(list1[a].text, list[a].cost,
                                        Color.fromRGBO(208, 240, 192, 1)),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(userFireBase.uid)
                            .update({
                          "key": keyy,
                          "diamonds": diamonds,
                          "onClickMesseng": widget.onMesseng,
                          "onClickMusic": widget.onMusic,
                          "language": widget.language,
                        });
                        var dos = list1[a].select_hero.runtimeType == String
                            ? int.parse(list1[a].select_hero)
                            : list1[a].select_hero;
                        var dirq = dos;
                        if (dirq == 99) {
                          point = "Всем";
                        } else {
                          point = widget.listParametrsName[dirq] == null
                              ? "..."
                              : widget.listParametrsName[dirq];
                        }

                        Future.delayed(const Duration(seconds: 1), () async {
                          if (list[a].nextOrder == "") {
                            statusEnd = true;
                            print("sssss");
                          }
                          statusPoint = true;
                          await controller.reverse();
                          order = list[a].nextOrder;
                          controller.forward();
                          setState(() {
                            pointHeight = height * 0.05;
                            pointWidth = width * 0.4;
                            poinRadius = height * 0.1;
                            statusGo = true;
                            element(
                              x,
                              y,
                              xBack,
                            );
                          });
                        });
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.001),
                      child: Transform(
                        transform: Matrix4.skewX(-0.2)..rotateY(3.14 / 12.0),
                        origin: Offset(50.0, 50.0),
                        child: Coloris(
                            list1[a].text,
                            list[a].cost,
                            list[a].cost > 0
                                ? Color.fromRGBO(255, 204, 153, 1)
                                : listYeloy[a]),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Container();
    }
  }

  Widget end() {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userFireBase.uid)
        .collection('history')
        .doc(widget.episodedocumentID)
        .update({
      'save_order': 'orderEnd',
      'listParametrs': widget.listParametrInt
    });
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: Container(
                child: Image.asset(
              'assets/old-grunge-paper-texture-background (1).png',
              fit: BoxFit.fill,
            )),
          ),
          Container(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  // color: Colors.amber,
                  height: height * 0.5,
                  width: width,
                  child: Center(
                    child: Container(
                      // color: Colors.amber,
                      height: height * 0.4,
                      width: width,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userFireBase.uid)
                            .collection('history')
                            .doc(widget.storyDocumentId + "Wardrobe")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else {
                            List list = List();
                            list = snapshot.data['ListParametrsUserAll'];
                            return Container(
                                child: ListView.builder(
                              padding: EdgeInsets.only(top: 0),
                              itemCount: list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: EdgeInsets.all(height * 0.005),
                                    child: Container(
                                      height: height * 0.06,
                                      width: width * 0.8,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, 0.4),
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              height * 0.02)),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.0),
                                            child: Container(
                                              height: height * 0.07,
                                              child: Image.asset(
                                                          'assets/${widget.listParametrsName[index]}.png') ==
                                                      null
                                                  ? Container()
                                                  : Image.asset(
                                                      'assets/${widget.listParametrsName[index]}.png',
                                                      color: Colors.white),
                                            ),
                                          ),
                                          Text(
                                            widget.listParametrInt[index] == 0
                                                ? ""
                                                : "+" +
                                                    widget
                                                        .listParametrInt[index]
                                                        .toString(),
                                            style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: height * 0.025,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            list[index].toString(),
                                            style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: height * 0.025,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            widget.listParametrsName[index],
                                            style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: height * 0.025,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ));
                              },
                            ));
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height * 0.2,
                  width: width,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * 0.1),
                      child: InkWell(
                        child: Container(
                          height: height * 0.07,
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(179, 68, 108, 1),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(height * 0.1),
                          ),
                          child: Center(
                            child: Text(
                              "Продолжить",
                              style: TextStyle(
                                  fontSize: height * 0.03,
                                  color: Colors.white,
                                  fontFamily: "Nunito"),
                            ),
                          ),
                        ),
                        onTap: () async {
                          var d = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userFireBase.uid)
                              .collection('history')
                              .doc(widget.episodedocumentID)
                              .update({
                            'save_order': 'orderEnd',
                            'listParametrs': widget.listParametrInt
                          });
                          Navigator.pop(
                            context,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  bool statusGo = true;
  bool statusPoint = false;

  Widget tratatta() {
    functiaPereborGarderob();
    statusServer = false;
    musicPlay(nameAudio, musicStatus);
    bot = false;
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    print(widget.onMusic);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    statutttttttttt ? order = 'order' : order = order;
    statusGo
        ? FirebaseFirestore.instance
            .collection('users')
            .doc(userFireBase.uid)
            .collection('history')
            .doc(widget.episodedocumentID)
            .update({
            "save_order": order,
            "nameHero": widget.nameHero,
            "nameAnimal": widget.nameAnimal
          })
        : print('');
    statusGo ? functiaPerebor() : print('');
    if (direction == 0) {
      x = -1.0;
      y = 0.0;
      xBack = -0.1;
    }
    if (direction == 1) {
      x = 1.0;
      y = 0.0;
      xBack = 0.1;
    }
    if (direction == 2) {
      x = 0.0;
      y = 1.0;
    }

    return WillPopScope(
      child: statusWardrobe
          ? wardrobe()
          : Container(
              child: statusEnd
                  ? end()
                  : Container(
                      child: Container(
                      child: Stack(
                        children: [
                          Container(
                            child: Container(
                              child: Center(
                                child: element(
                                  x,
                                  y,
                                  xBack,
                                ),
                              ),
                            ),
                          ),
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
                                  musicPlay('nameAudi', 2);
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
                                  height: height * 0.06,
                                  width: width * 0.13,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: Image.asset(
                                                'assets/гардероб gkfnmt.png')
                                            .image,
                                        fit: BoxFit.fill),
                                    color: Color.fromRGBO(179, 68, 108, 1),
                                    border: Border.all(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.circular(height * 100),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    statusGo = false;
                                    statusWardrobe = true;
                                  });
                                },
                              ),
                            ),
                          ),
                          ballllll == null
                              ? Container()
                              : Align(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.1,
                                    ),
                                    child: Container(
                                      height: height * 0.05,
                                      width: width * 0.5,
                                      child: Center(
                                        child: Poin(),
                                      ),
                                      // constraints: BoxConstraints(
                                      //     maxHeight: height * 0.05,
                                      //     maxWidth: width * 0.5),
                                    ),
                                  ),
                                  alignment: Alignment.topCenter)
                        ],
                      ),
                    )),
            ),
      onWillPop: () async => false,
    );
  }

  Color colorBjk = Color.fromRGBO(179, 68, 108, 1);
  Color colorClothes = Color.fromRGBO(86, 0, 39, 1);
  Color colorHair = Color.fromRGBO(86, 0, 39, 1);
  Color colorlook = Color.fromRGBO(86, 0, 39, 1);

  bool statusWardrobeOn = true;
  var iconShop;

  functiaPereborGarderob([String status, int statusOrder]) {
    listPereborGarderob.clear();
    // imageStart = widget.listGarderob[0].listImageAll[0].img_name;
    switch (status) {
      case 'bij':
        {
          for (var i = 0; i < listGarderob[0].listImageInfoBij.length; i++) {
            listPereborGarderob.add(
              new ImageInfoName(
                listGarderob[0].listImageInfoBij[i].prefix_bij,
                listGarderob[0].listImageInfoBij[i].name_bij,
                listGarderob[0].listImageInfoBij[i].price_bij,
              ),
            );
          }
        }
        break;
      case "clothes":
        {
          for (var i = 0;
              i < listGarderob[0].listImageInfoClothes.length;
              i++) {
            listPereborGarderob.add(
              new ImageInfoName(
                listGarderob[0].listImageInfoClothes[i].prefix_clothes,
                listGarderob[0].listImageInfoClothes[i].name_clothes,
                listGarderob[0].listImageInfoClothes[i].price_clothes,
              ),
            );
          }
        }
        break;
      case "hair":
        {
          for (var i = 0; i < listGarderob[0].listImageInfoHair.length; i++) {
            listPereborGarderob.add(
              new ImageInfoName(
                listGarderob[0].listImageInfoHair[i].prefix_hair,
                listGarderob[0].listImageInfoHair[i].name_hair,
                listGarderob[0].listImageInfoHair[i].price_hair,
              ),
            );
          }
        }
        break;
      case "look":
        {
          for (var i = 0; i < listGarderob[0].listImageInfoLook.length; i++) {
            listPereborGarderob.add(
              new ImageInfoName(
                listGarderob[0].listImageInfoLook[i].prefix_look,
                listGarderob[0].listImageInfoLook[i].name_look,
                listGarderob[0].listImageInfoLook[i].price_look,
              ),
            );
          }
        }
        break;
    }
  }

  String nameImageGarderob;
  onPageViewChange(index) {
    name = listPereborGarderob[index].namePrefexImage;
    priceClothes = listPereborGarderob[index].price == ""
        ? 0
        : listPereborGarderob[index].price;
    print(priceClothes);

    print(name);
    switch (name.substring(0, 1)) {
      case 'c':
        {
          setState(() {
            prefix_clothes = name;
          });
        }
        break;
      case 'l':
        {
          setState(() {
            prefix_look = name;
          });
        }
        break;
      case 'b':
        {
          setState(() {
            prefix_bij = name;
          });
        }
        break;
      case 'h':
        {
          setState(() {
            prefix_hair = name;
          });
        }
    }
  }

  functiaInputName() {
    String nameW = widget.wardrobeName;
    if (ggggggg == true) {
      var imageResult = mapSaveGarderob[nameW];
      imageHero = nameW;
      return nameW == 'end'
          ? Image.asset('assets/бесплатная.png').image
          : imageResult.image;
    } else {
      String name = "$prefix_look" +
          "$prefix_clothes" +
          "$prefix_hair" +
          "$prefix_bij" +
          "$emotion";
      imageHero = name;
      var imageResult = mapSaveGarderob[name];
      return imageResult == null
          ? Image.asset('assets/бесплатная.png').image
          : imageResult.image;
    }
  }

  String emotion = "e0";
  String prefix_bij = "b0";
  String prefix_clothes = "c1";
  String prefix_hair = "h1";
  String prefix_look = "l1";
  bool statusGarderob = false;
  Map mapSaveGarderob = Map();
  int statusOM = 1;
  Map maps = Map();

  String imageHero;
  bool ggggggg = true;
  var indexCloc = 0;
  // bool statusWardrobeClothe = true;

  // functiaHei() {
  //   var height = MediaQuery.of(context).size.height;
  //   var width = MediaQuery.of(context).size.width;
  //   Container(
  //     height: height * 0.12,
  //     width: width * 0.6,
  //     child: LoopPageView.builder(
  //       scrollDirection: Axis.horizontal,
  //       controller: controllerTextImage,
  //       itemCount: listPereborGarderob.length,
  //       itemBuilder: (_, index) {
  //         indexCloc = index;
  //         return Center(
  //           child: Text(
  //             '${listPereborGarderob[index].nameImage}',
  //             style: TextStyle(fontSize: 20),
  //           ),
  //         );
  //       },
  //       onPageChanged: onPageViewChange,
  //     ),
  //   );
  // }
  ScrollController scrollController = ScrollController();

  List<ImageInfoName> listPereborGarderob = List();
  String nameImageGarderobInfo = 'bij';
  Widget wardrobe() {
    emotion = "e0";
    // statusWardrobeClothe = true;
    var nameSaveWardrobe;
    statusGo = false;
    ggggggg = false;
    functiaPereborGarderob(nameImageGarderobInfo, statusOM);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    return Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset("assets/Гардероб (2).jpg").image,
                    fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.085, left: width * 0.07),
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
                    setState(() {
                      statusGo = false;
                      statusWardrobe = false;
                    });
                    // Navigator.pop(context);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: height * 0.8,
                  width: width * 0.8,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        alignment: Alignment.center,
                        image: functiaInputName(),
                        fit: BoxFit.fill,
                      )),
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: Tween<Offset>(
                        begin: Offset(0.0, 0.0), end: Offset(0.0, 0.8))
                    .animate(controllerWarb),
                child: Container(
                    height: height * 0.45,
                    width: width * 0.8,
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.1,
                          width: width * 0.8,
                          child: Center(
                            child: InkWell(
                              child: Icon(
                                statusWardrobeOn
                                    ? iconShop = Icons.arrow_downward_outlined
                                    : iconShop = Icons.arrow_upward_outlined,
                                size: height * 0.08,
                                color: Colors.white,
                              ),
                              onTap: () {
                                statusWardrobeOn
                                    ? setState(() {
                                        controllerWarb.forward();
                                        statusWardrobeOn = false;
                                      })
                                    : setState(() {
                                        statusWardrobeOn = true;
                                        controllerWarb.reverse();
                                      });
                              },
                            ),
                          ),
                        ),
                        Container(
                            height: height * 0.35,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(239, 222, 205, 1),
                              borderRadius:
                                  BorderRadius.circular(height * 0.02),
                            ),
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              colorBjk = Color.fromRGBO(
                                                  179, 68, 108, 1);
                                              colorClothes =
                                                  Color.fromRGBO(86, 0, 39, 1);
                                              colorHair =
                                                  Color.fromRGBO(86, 0, 39, 1);
                                              colorlook =
                                                  Color.fromRGBO(86, 0, 39, 1);
                                              nameImageGarderobInfo = "bij";
                                            });
                                          },
                                          child: Container(
                                            height: height * 0.1,
                                            width: width * 0.2,
                                            decoration: BoxDecoration(
                                              color: colorBjk,
                                              // border: Border.all(),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      height * 0.02)),
                                            ),
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: Image.asset(
                                                              "assets/bij.png")
                                                          .image,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              colorBjk =
                                                  Color.fromRGBO(86, 0, 39, 1);
                                              colorClothes = Color.fromRGBO(
                                                  179, 68, 108, 1);
                                              colorHair =
                                                  Color.fromRGBO(86, 0, 39, 1);
                                              colorlook =
                                                  Color.fromRGBO(86, 0, 39, 1);
                                              nameImageGarderobInfo = "clothes";
                                            });
                                          },
                                          child: Container(
                                            height: height * 0.1,
                                            width: width * 0.2,
                                            decoration: BoxDecoration(
                                              // border: Border.all(),
                                              color: colorClothes,
                                            ),
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: Image.asset(
                                                              "assets/гардероб gkfnmt.png")
                                                          .image,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              colorBjk =
                                                  Color.fromRGBO(86, 0, 39, 1);
                                              colorClothes =
                                                  Color.fromRGBO(86, 0, 39, 1);
                                              colorHair = Color.fromRGBO(
                                                  179, 68, 108, 1);
                                              colorlook =
                                                  Color.fromRGBO(86, 0, 39, 1);
                                              nameImageGarderobInfo = "hair";
                                            });
                                          },
                                          child: Container(
                                            height: height * 0.1,
                                            width: width * 0.2,
                                            decoration: BoxDecoration(
                                              // border: Border.all(),
                                              color: colorHair,
                                            ),
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: Image.asset(
                                                              "assets/heat1.png")
                                                          .image,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              Color.fromRGBO(86, 0, 39, 1);
                                              colorClothes =
                                                  Color.fromRGBO(86, 0, 39, 1);
                                              colorHair =
                                                  Color.fromRGBO(86, 0, 39, 1);
                                              colorlook = Color.fromRGBO(
                                                  179, 68, 108, 1);
                                              nameImageGarderobInfo = "look";
                                            });
                                          },
                                          child: Container(
                                            height: height * 0.1,
                                            width: width * 0.2,
                                            decoration: BoxDecoration(
                                              color: colorlook,
                                              // border: Border.all(),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(
                                                      height * 0.02)),
                                            ),
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: Image.asset(
                                                              "assets/гардероб hear.png")
                                                          .image,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      height: height * 0.12,
                                      width: width * 0.7,
                                      child: LoopPageView.builder(
                                        scrollDirection: Axis.horizontal,
                                        controller: controllerTextImage,
                                        itemCount: listPereborGarderob.length,
                                        // itemCount: listPereborGarderob.length,
                                        itemBuilder: (_, index) {
                                          indexCloc = index;

                                          return Center(
                                            child: Text(
                                              '${listPereborGarderob[index].nameImage},',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          );
                                        },
                                        onPageChanged: onPageViewChange,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: height * 0.03),
                                      child: InkWell(
                                        onTap: () async {
                                          if (listPereborGarderob[indexCloc]
                                                      .price ==
                                                  0 ||
                                              listPereborGarderob[indexCloc]
                                                      .price ==
                                                  "") {
                                            var d = await FirebaseFirestore
                                                .instance
                                                .collection('users')
                                                .doc(userFireBase.uid)
                                                .collection('history')
                                                .doc(widget.episodedocumentID)
                                                .update({
                                              "wardrobeName": imageHero,
                                            });
                                            setState(() {
                                              statusWardrobe = false;
                                              // statusWardrobeClothe = true;
                                            });
                                          } else {
                                            setState(() {
                                              if (diamonds <
                                                  listPereborGarderob[indexCloc]
                                                      .price) {
                                              } else {
                                                diamonds =
                                                    diamonds - priceClothes;

                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(userFireBase.uid)
                                                    .update(
                                                        {'diamonds': diamonds});
                                                var aw = FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(userFireBase.uid)
                                                    .collection("history")
                                                    .doc(
                                                        widget.storyDocumentId +
                                                            "Wardrobe")
                                                    .get();
                                                var wee = aw;
                                                switch (nameImageGarderobInfo) {
                                                  case "bij":
                                                    {
                                                      var prifixIndex =
                                                          listGarderob[0]
                                                              .listImageInfoBij[
                                                                  indexCloc]
                                                              .prefix_bij;
                                                      listGarderob[0]
                                                          .listImageInfoBij[
                                                              indexCloc]
                                                          .price_bij = 0;
                                                      mapWardrobeCloc
                                                          .add(prifixIndex);

                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(userFireBase.uid)
                                                          .collection('history')
                                                          .doc('Wardrobe')
                                                          .update({
                                                        "Wardrobe":
                                                            mapWardrobeCloc,
                                                      });
                                                    }
                                                    break;
                                                  case "clothes":
                                                    {
                                                      var prifixIndex =
                                                          listGarderob[0]
                                                              .listImageInfoClothes[
                                                                  indexCloc]
                                                              .prefix_clothes;
                                                      listGarderob[0]
                                                          .listImageInfoClothes[
                                                              indexCloc]
                                                          .price_clothes = 0;
                                                      mapWardrobeCloc
                                                          .add(prifixIndex);

                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(userFireBase.uid)
                                                          .collection('history')
                                                          .doc('Wardrobe')
                                                          .update({
                                                        "Wardrobe":
                                                            mapWardrobeCloc,
                                                      });
                                                    }
                                                    break;
                                                  case "hair":
                                                    {
                                                      var prifixIndex =
                                                          listGarderob[0]
                                                              .listImageInfoHair[
                                                                  indexCloc]
                                                              .prefix_hair;
                                                      listGarderob[0]
                                                          .listImageInfoHair[
                                                              indexCloc]
                                                          .price_hair = 0;
                                                      mapWardrobeCloc
                                                          .add(prifixIndex);

                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(userFireBase.uid)
                                                          .collection('history')
                                                          .doc('Wardrobe')
                                                          .update({
                                                        "Wardrobe":
                                                            mapWardrobeCloc,
                                                      });
                                                    }
                                                    break;
                                                  case "look":
                                                    {
                                                      var prifixIndex =
                                                          listGarderob[0]
                                                              .listImageInfoLook[
                                                                  indexCloc]
                                                              .prefix_look;
                                                      listGarderob[0]
                                                          .listImageInfoLook[
                                                              indexCloc]
                                                          .price_look = 0;
                                                      mapWardrobeCloc
                                                          .add(prifixIndex);

                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(userFireBase.uid)
                                                          .collection('history')
                                                          .doc('Wardrobe')
                                                          .update({
                                                        "Wardrobe":
                                                            mapWardrobeCloc,
                                                      });
                                                    }
                                                }

                                                setState(() {
                                                  priceClothes = 0;
                                                });
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: height * 0.065,
                                          width: width * 0.4,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  listPereborGarderob[indexCloc]
                                                                  .price ==
                                                              0 ||
                                                          listPereborGarderob[
                                                                      indexCloc]
                                                                  .price ==
                                                              ""
                                                      ? "выбрать"
                                                      : listPereborGarderob[
                                                              indexCloc]
                                                          .price
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 23,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                listPereborGarderob[indexCloc]
                                                                .price ==
                                                            0 ||
                                                        listPereborGarderob[
                                                                    indexCloc]
                                                                .price ==
                                                            ""
                                                    ? Container()
                                                    : Image.asset(
                                                        'assets/diamondsLitle.png'),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.01),
                                              border: Border.all(
                                                  color: Colors.white),
                                              color: Color.fromRGBO(
                                                  179, 68, 108, 1)),
                                        ),
                                      ),
                                    )
                                  ],
                                )))
                      ],
                    )),
              ),
            ),
          ],
        ));
  }

  bool statusEndTheEnd = false;
  var statusServer = true;
  bool bot = true;
  var qoiii = false;
  bool inputNameAnimal = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print('Начало');
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userFireBase.uid)
        .snapshots()
        .listen((event) {
      diamonds = event.data()['diamonds'];
    });
    widget.saveOrder == 'orderEnd'
        ? statusEnd = true
        : statusEndTheEnd
            ? statusEnd = true
            : statusEnd = false;
    return Scaffold(
      body: statusServer
          ? Container(
              child: FutureBuilder(
                  future: Loading(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        child: Center(
                          child: Container(
                            height: height * 0.3,
                            // width: height * 0.2,
                            child: StreamBuilder(
                              stream: tream(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: height * 0.2,
                                            width: height * 0.2,
                                            child:
                                                LiquidCircularProgressIndicator(
                                              value: snapshot
                                                  .data, // Defaults to 0.5.
                                              valueColor:
                                                  AlwaysStoppedAnimation(Colors
                                                      .pink), // Defaults to the current Theme's accentColor.
                                              backgroundColor: Colors
                                                  .white, // Defaults to the current Theme's backgroundColor.
                                              borderColor: Colors.red,
                                              borderWidth: 5.0,
                                              direction: Axis
                                                  .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                              center: Material(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 0),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: height * 0.05,
                                              ),
                                              child: Text(
                                                'Загружаем данные',
                                                style: TextStyle(
                                                    fontSize: height * 0.03,
                                                    fontFamily: 'Nunito'),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: height * 0.2,
                                            width: height * 0.2,
                                            child:
                                                LiquidCircularProgressIndicator(
                                              value: snapshot
                                                  .data, // Defaults to 0.5.
                                              valueColor:
                                                  AlwaysStoppedAnimation(Colors
                                                      .pink), // Defaults to the current Theme's accentColor.
                                              backgroundColor: Colors
                                                  .white, // Defaults to the current Theme's backgroundColor.
                                              borderColor: Colors.red,
                                              borderWidth: 5.0,
                                              direction: Axis
                                                  .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                              center: Material(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 0),
                                                // child: Text("Скачиваем данные",
                                                //     style: TextStyle(
                                                //         color: Colors.black,
                                                //         fontSize: height * 0.02)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: height * 0.05,
                                              ),
                                              child: Text(
                                                'Загружаем данные',
                                                style: TextStyle(
                                                    fontSize: height * 0.03,
                                                    fontFamily: 'Nunito'),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        child: Container(
                          child: FutureBuilder(
                            future: functiaSaveGarderob(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                  child: Center(
                                    child: Container(
                                      height: height * 0.3,
                                      // width: height * 0.2,
                                      child: StreamBuilder(
                                        stream: tream1(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: height * 0.2,
                                                      width: height * 0.2,
                                                      child:
                                                          LiquidCircularProgressIndicator(
                                                        value: snapshot
                                                            .data, // Defaults to 0.5.
                                                        valueColor:
                                                            AlwaysStoppedAnimation(
                                                                Colors
                                                                    .pink), // Defaults to the current Theme's accentColor.
                                                        backgroundColor: Colors
                                                            .white, // Defaults to the current Theme's backgroundColor.
                                                        borderColor: Colors.red,
                                                        borderWidth: 5.0,
                                                        direction: Axis
                                                            .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                                        center: Material(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0),
                                                          // child: Text("Скачиваем данные",
                                                          //     style: TextStyle(
                                                          //         color: Colors.black,
                                                          //         fontSize: height * 0.02)),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: height * 0.05,
                                                        ),
                                                        child: Text(
                                                          'Загружаем гардероб',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  height * 0.03,
                                                              fontFamily:
                                                                  'Nunito'),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: height * 0.2,
                                                      width: height * 0.2,
                                                      child:
                                                          LiquidCircularProgressIndicator(
                                                        value: snapshot
                                                            .data, // Defaults to 0.5.
                                                        valueColor:
                                                            AlwaysStoppedAnimation(
                                                                Colors
                                                                    .pink), // Defaults to the current Theme's accentColor.
                                                        backgroundColor: Colors
                                                            .white, // Defaults to the current Theme's backgroundColor.
                                                        borderColor: Colors.red,
                                                        borderWidth: 5.0,
                                                        direction: Axis
                                                            .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                                        center: Material(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0),
                                                          // child: Text("Скачиваем данные",
                                                          //     style: TextStyle(
                                                          //         color: Colors.black,
                                                          //         fontSize: height * 0.02)),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: height * 0.05,
                                                        ),
                                                        child: Text(
                                                          'Загружаем гардероб',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  height * 0.03,
                                                              fontFamily:
                                                                  'Nunito'),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                mapSaveGarderob = snapshot.data;
                                return Container(
                                    child: bot
                                        ? FutureBuilder(
                                            future: functiaSaveImage(
                                                height,
                                                width,
                                                height.toInt(),
                                                width.toInt()),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container(
                                                  child: Center(
                                                    child: Container(
                                                      height: height * 0.3,
                                                      // width: height * 0.2,
                                                      child: StreamBuilder(
                                                        stream: tream2(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: Container(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          height *
                                                                              0.2,
                                                                      width:
                                                                          height *
                                                                              0.2,
                                                                      child:
                                                                          LiquidCircularProgressIndicator(
                                                                        value: snapshot
                                                                            .data, // Defaults to 0.5.
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation(Colors.pink), // Defaults to the current Theme's accentColor.
                                                                        backgroundColor:
                                                                            Colors.white, // Defaults to the current Theme's backgroundColor.
                                                                        borderColor:
                                                                            Colors.red,
                                                                        borderWidth:
                                                                            5.0,
                                                                        direction:
                                                                            Axis.horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                                                        center:
                                                                            Material(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          // child: Text("Скачиваем данные",
                                                                          //     style: TextStyle(
                                                                          //         color: Colors.black,
                                                                          //         fontSize: height * 0.02)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          top: height *
                                                                              0.05,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          'Загружаем картинки',
                                                                          style: TextStyle(
                                                                              fontSize: height * 0.03,
                                                                              fontFamily: 'Nunito'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            return Center(
                                                              child: Container(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          height *
                                                                              0.2,
                                                                      width:
                                                                          height *
                                                                              0.2,
                                                                      child:
                                                                          LiquidCircularProgressIndicator(
                                                                        value: snapshot
                                                                            .data, // Defaults to 0.5.
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation(Colors.pink), // Defaults to the current Theme's accentColor.
                                                                        backgroundColor:
                                                                            Colors.white, // Defaults to the current Theme's backgroundColor.
                                                                        borderColor:
                                                                            Colors.red,
                                                                        borderWidth:
                                                                            5.0,
                                                                        direction:
                                                                            Axis.horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                                                        center:
                                                                            Material(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          // child: Text("Скачиваем данные",
                                                                          //     style: TextStyle(
                                                                          //         color: Colors.black,
                                                                          //         fontSize: height * 0.02)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          top: height *
                                                                              0.05,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          'Загружаем картинки',
                                                                          style: TextStyle(
                                                                              fontSize: height * 0.03,
                                                                              fontFamily: 'Nunito'),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                mapSaveBac = snapshot.data;
                                                return statusEnd
                                                    ? end()
                                                    : tratatta();
                                                // return qoiii
                                                //     ? inputName()
                                                //     : tratatta();
                                              }
                                            },
                                          )
                                        : statusEnd
                                            ? end()
                                            : tratatta()
                                    // : statusWardrobe
                                    //     ? wardrobe()
                                    //     : tratatta(),
                                    );
                              }
                            },
                          ),
                        ),
                      );
                    }
                  }),
            )
          : Container(
              child: bot
                  ? FutureBuilder(
                      future: functiaSaveImage(
                          height, width, height.toInt(), width.toInt()),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            child: Center(
                              child: Container(
                                height: height * 0.3,
                                // width: height * 0.2,
                                child: StreamBuilder(
                                  stream: tream2(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: height * 0.2,
                                                width: height * 0.2,
                                                child:
                                                    LiquidCircularProgressIndicator(
                                                  value: snapshot
                                                      .data, // Defaults to 0.5.
                                                  valueColor:
                                                      AlwaysStoppedAnimation(Colors
                                                          .pink), // Defaults to the current Theme's accentColor.
                                                  backgroundColor: Colors
                                                      .white, // Defaults to the current Theme's backgroundColor.
                                                  borderColor: Colors.red,
                                                  borderWidth: 5.0,
                                                  direction: Axis
                                                      .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                                  center: Material(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0),
                                                    // child: Text("Скачиваем данные",
                                                    //     style: TextStyle(
                                                    //         color: Colors.black,
                                                    //         fontSize: height * 0.02)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: height * 0.05,
                                                ),
                                                child: Text(
                                                  'Загружаем картинки',
                                                  style: TextStyle(
                                                      fontSize: height * 0.03,
                                                      fontFamily: 'Nunito'),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: height * 0.2,
                                                width: height * 0.2,
                                                child:
                                                    LiquidCircularProgressIndicator(
                                                  value: snapshot
                                                      .data, // Defaults to 0.5.
                                                  valueColor:
                                                      AlwaysStoppedAnimation(Colors
                                                          .pink), // Defaults to the current Theme's accentColor.
                                                  backgroundColor: Colors
                                                      .white, // Defaults to the current Theme's backgroundColor.
                                                  borderColor: Colors.red,
                                                  borderWidth: 5.0,
                                                  direction: Axis
                                                      .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                                  center: Material(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0),
                                                    // child: Text("Скачиваем данные",
                                                    //     style: TextStyle(
                                                    //         color: Colors.black,
                                                    //         fontSize: height * 0.02)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: height * 0.05,
                                                ),
                                                child: Text(
                                                  'Загружаем картинки',
                                                  style: TextStyle(
                                                      fontSize: height * 0.03,
                                                      fontFamily: 'Nunito'),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                              child: FutureBuilder(
                            future: functiaSaveGarderob(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                  child: Center(
                                    child: Container(
                                      height: height * 0.3,
                                      // width: height * 0.2,
                                      child: StreamBuilder(
                                        stream: tream1(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: height * 0.2,
                                                      width: height * 0.2,
                                                      child:
                                                          LiquidCircularProgressIndicator(
                                                        value: snapshot
                                                            .data, // Defaults to 0.5.
                                                        valueColor:
                                                            AlwaysStoppedAnimation(
                                                                Colors
                                                                    .pink), // Defaults to the current Theme's accentColor.
                                                        backgroundColor: Colors
                                                            .white, // Defaults to the current Theme's backgroundColor.
                                                        borderColor: Colors.red,
                                                        borderWidth: 5.0,
                                                        direction: Axis
                                                            .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                                        center: Material(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0),
                                                          // child: Text("Скачиваем данные",
                                                          //     style: TextStyle(
                                                          //         color: Colors.black,
                                                          //         fontSize: height * 0.02)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: height * 0.05,
                                                      ),
                                                      child: Text(
                                                        'Загружаем гардероб',
                                                        style: TextStyle(
                                                            fontSize:
                                                                height * 0.03,
                                                            fontFamily:
                                                                'Nunito'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: height * 0.2,
                                                      width: width * 0.2,
                                                      child:
                                                          LiquidCircularProgressIndicator(
                                                        value: snapshot
                                                            .data, // Defaults to 0.5.
                                                        valueColor:
                                                            AlwaysStoppedAnimation(
                                                                Colors
                                                                    .pink), // Defaults to the current Theme's accentColor.
                                                        backgroundColor: Colors
                                                            .white, // Defaults to the current Theme's backgroundColor.
                                                        borderColor: Colors.red,
                                                        borderWidth: 5.0,
                                                        direction: Axis
                                                            .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                                        center: Material(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0),
                                                          // child: Text("Скачиваем данные",
                                                          //     style: TextStyle(
                                                          //         color: Colors.black,
                                                          //         fontSize: height * 0.02)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: height * 0.05,
                                                      ),
                                                      child: Text(
                                                        'Загружаем гардероб',
                                                        style: TextStyle(
                                                            fontSize:
                                                                height * 0.03,
                                                            fontFamily:
                                                                'Nunito'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                mapSaveGarderob = snapshot.data;
                                mapSaveBac = snapshot.data;
                                return statusEnd ? end() : tratatta();
                                // return qoiii ? inputName() : tratatta();
                              }
                            },
                          ));
                        }
                      },
                    )
                  : statusEnd
                      ? end()
                      : tratatta()
              // : statusWardrobe
              //     ? wardrobe()
              //     : tratatta(),
              ),
    );
  }

  functiaSaveGarderob() async {
    numberStream = 0.0;
    progresStrean = 0.0;
    col = 0.0;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String dir = (await getApplicationDocumentsDirectory()).path;
    Map imageEaa = new Map();
    print("Количество всех картинок в гардеробе " +
        "${listGarderob[0].listImageAll.length}");
    col = listGarderob[0].listImageAll.length.toDouble();
    progresStrean = 1 / col;
    for (var i = 0; i < listGarderob[0].listImageAll.length; i++) {
      var w = listGarderob[0].listImageAll[i].img_name;
      File file = File('$dir/$w');
      if (!file.existsSync()) {
        print("картинки в гардеробе нет ");
        var retesttt = await http.get(listGarderob[0].listImageAll[i].img_url);
        var bytes = retesttt.bodyBytes;
        await file.writeAsBytes(bytes);
        var imageB = Image.memory(
          bytes,
          height: height,
          width: width,
          cacheHeight: 1000,
          cacheWidth: 600,
          scale: 1,
          repeat: ImageRepeat.noRepeat,
        );
        await precacheImage(imageB.image, context);
        imageEaa[listGarderob[0].listImageAll[i].img_name] = imageB;
      } else {
        print("картинка в гардеробе есть ");
        var imagen = await file.readAsBytes();
        var imageB = Image.memory(
          imagen,
          height: height,
          width: width,
          cacheHeight: 1000,
          cacheWidth: 600,
          scale: 1,
          repeat: ImageRepeat.noRepeat,
        );
        await precacheImage(imageB.image, context);
        imageEaa[listGarderob[0].listImageAll[i].img_name] = imageB;
      }
      numberStream = numberStream + progresStrean;
      tream1(numberStream);
    }

    print('Конец гардероба ');
    return imageEaa;
  }

  Widget element(
    double x,
    double y,
    double xBack,
  ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
        height: height,
        width: width,
        child:
            //  status
            //     ?
            InkWell(
          onTap: () async {
            if (status == false) {
              controller.forward();
              controller2.forward();
            } else {
              coinsButtons = 0;
              if (order == '') {
                print('Вот и все ');
                setState(() {
                  statusEndTheEnd = true;
                  statusEnd = true;
                  statusGo = false;
                });
              } else {
                await controller2.forward();
                await controller.reverse();
                controller.forward();
                controller2.forward();
                setState(() {
                  pointHeight = 0.0;
                  pointWidth = 0.0;
                  poinRadius = height * 0.0;
                  statusGo = true;

                  element(
                    x,
                    y,
                    xBack,
                  );
                });
              }
            }
          },
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: mapSaveBac[backName].image == null
                          ? Image.asset('assets/кольцо.png').image
                          : mapSaveBac[backName].image),
                ),
              ),
              SlideTransition(
                position:
                    Tween<Offset>(begin: Offset(x, y), end: Offset(0.0, 0.0))
                        .animate(controller),
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Align(
                          alignment: direction == 1
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft,
                          child: direction != 2
                              ? Container(
                                  height: height * 0.75,
                                  width: width * 0.7,
                                  decoration: BoxDecoration(
                                    image: new DecorationImage(
                                        alignment: Alignment.centerRight,
                                        fit: BoxFit.fill,
                                        image: direction == 0
                                            ? mapSaveHero[nameImage] == null
                                                ? functiaInputName()
                                                : mapSaveHero[nameImage].image
                                            : mapSaveHero[nameImage].image),
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: height * 0.5),
                          child: Column(
                            children: [
                              functiaDirection(direction),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  child: Column(
                                    children: statuss
                                        ? listButtons = []
                                        : listButtons,
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
              )
            ],
          ),
        ));
  }

  functiaStringText(String text) {
    final output = text.replaceAll(
        RegExp(
          r"[@][@]",
        ),
        widget.nameHero);
    return output;
  }

  var good;
  var bad;
  var normal;

  var mil = 0;
  functiaDirection(
    int direction,
  ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    functiaSize();
    if (direction == 0) {
      return Container(
        width: width * 0.8,
        child: Column(
          children: [
            Container(
              width: width * 0.8,
              constraints: BoxConstraints(
                  minHeight: height * 0.1, minWidth: width * 0.8),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.0368),
                    child: Transform(
                      transform: Matrix4.skewX(-0.2)..rotateY(3.14 / 12.0),
                      origin: Offset(50.0, 50.0),
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: height * 0.1, minWidth: width * 0.8),
                        width: width * 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(height * 0.02),
                          child: Center(
                            child: Text(
                              functiaStringText(text),
                              // "$text",
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Nunito-Regular"),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(239, 222, 205, 1),
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(height * 0.01)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.15),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: height * 0.04,
                        width: width * 0.2,
                        child: CustomPaint(
                          painter: PathPainter(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.15),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: height * 0.04,
                        width: width * 0.2,
                        child: CustomPaint(
                          painter: PathPainter1(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.02, left: height * 0.03),
                    child: Transform(
                      transform: Matrix4.skewX(-0.2)..rotateY(3.14 / 12.0),
                      origin: Offset(50.0, 50.0),
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: height * 0.03, minWidth: width * 0.01),
                        child: Padding(
                          padding: EdgeInsets.all(height * 0.005),
                          child: Container(
                            height: height * 0.03,
                            width: width * 0.4,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Text(
                                  direction == 0 ? widget.nameHero : nameHero,
                                  // nameHero != null ? nameHero : "Никита",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: "Nunito"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 250, 250, 1),
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(height * 0.01)),
                      ),
                    ),
                  ),
                  listButtons.length != 0
                      ? coinsButtons == 0
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: height * 0.08,
                                width: height * 0.08,
                                child: Center(
                                  child: AnimatedBuilder(
                                    animation: _myAnimation,
                                    builder: (ctx, ch) => Container(
                                      height: _myAnimation.value.height,
                                      width: _myAnimation.value.height,
                                      child: Stack(
                                        children: [
                                          TimeCircularCountdown(
                                            unit: CountdownUnit.second,
                                            countdownTotal:
                                                timeButtons == null ||
                                                        timeButtons == 0
                                                    ? 1000
                                                    : timeButtons,
                                            onUpdated: (unit, remainingTime) {
                                              setState(() {
                                                // _controller.forward();
                                                mil = remainingTime;
                                              });
                                            },
                                            // functiaSize(remainingTime),
                                            onFinished: () async {
                                              setState(() {
                                                mil = 0;
                                                listButtons[0] = Container(
                                                  child: Container(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.001),
                                                      child: Transform(
                                                        transform:
                                                            Matrix4.skewX(-0.2)
                                                              ..rotateY(
                                                                  3.14 / 12.0),
                                                        origin:
                                                            Offset(50.0, 50.0),
                                                        child: Coloris(
                                                            list1[0].text,
                                                            list[0].cost,
                                                            Colors.red),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                              Future.delayed(
                                                  Duration(seconds: 1),
                                                  () async {
                                                order = list1[0].nextOrder;
                                                order == ""
                                                    ? statusEnd = true
                                                    : print('a');
                                                await controller2.forward();
                                                await controller.reverse();
                                                setState(() {
                                                  controller.forward();
                                                  controller2.forward();
                                                  element(
                                                    x,
                                                    y,
                                                    xBack,
                                                  );
                                                });
                                              });
                                            },
                                            // diameter: _myAnimation.value.height,
                                            countdownCurrentColor: Colors.blue,
                                            countdownTotalColor: Colors.red,
                                            countdownRemainingColor:
                                                Colors.black,

                                            // diameter: 10,
                                          ),
                                          Container(
                                            height: height * 0.8,
                                            width: height * 8,
                                            child: Center(
                                              child: Text(
                                                "$mil",
                                                style: TextStyle(
                                                    fontFamily: "Nunito"),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              height * 100),
                                          color: Colors.white),
                                    ),
                                    // curve: Curves.easeIn,
                                    // vsync: this,
                                    // duration: Duration(seconds: 0),
                                  ),
                                ),
                              ),
                            )
                          : Container()
                      : Container()
                ],
              ),
            ),
          ],
        ),
      );
    } else if (direction == 1) {
      return Container(
        width: width * 0.8,
        constraints:
            BoxConstraints(minHeight: height * 0.15, minWidth: width * 0.8),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.0368),
              child: Transform(
                transform: Matrix4.skewX(-0.2)..rotateY(3.14 / 12.0),
                origin: Offset(50.0, 50.0),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: height * 0.1, minWidth: width * 0.8),
                  width: width * 0.8,
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.02),
                    child: Center(
                      child: Text(
                        functiaStringText(text),
                        // "$text",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "Nunito-Regular"),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(239, 222, 205, 1),
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(height * 0.01)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: height * 0.04,
                  width: width * 0.2,
                  child: CustomPaint(
                    painter: PathPainter2(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: height * 0.04,
                  width: width * 0.2,
                  child: CustomPaint(
                    painter: PathPainter3(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.02, right: width * 0.1),
              child: Align(
                alignment: Alignment.centerRight,
                child: Transform(
                  transform: Matrix4.skewX(-0.2)..rotateY(3.14 / 12.0),
                  origin: Offset(50.0, 50.0),
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: height * 0.03, minWidth: width * 0.01),
                    child: Padding(
                      padding: EdgeInsets.all(height * 0.005),
                      child: Container(
                        height: height * 0.03,
                        width: width * 0.3,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Text(
                              // "asdddddddddddddddddddddddddddddddddddd",
                              nameHero != null ? nameHero : "Никита",
                              //   style: TextStyle(fontSize: 20, fontFamily: "Nunito"),
                              style:
                                  TextStyle(fontSize: 20, fontFamily: "Nunito"),
                            ),
                          ],
                        ),
                      ),
                      // child: Text(
                      //   nameHero != null ? nameHero : "Никита",
                      //   style: TextStyle(fontSize: 20, fontFamily: "Nunito"),
                      // ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(height * 0.01)),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: width * 0.8,
        constraints:
            BoxConstraints(minHeight: height * 0.15, minWidth: width * 0.8),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.0368),
              child: Transform(
                transform: Matrix4.skewX(-0.2)..rotateY(3.14 / 12.0),
                origin: Offset(50.0, 50.0),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: height * 0.1, minWidth: width * 0.8),
                  width: width * 0.8,
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.02),
                    child: Center(
                      child: Text(
                        functiaStringText(text),
                        // "$text",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "Nunito-Regular"),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(239, 222, 205, 1),
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(height * 0.01)),
                ),
              ),
            ),
            listButtons.length != 0
                ? coinsButtons == 0
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: height * 0.08,
                          width: height * 0.08,
                          child: Center(
                            child: AnimatedBuilder(
                              animation: _myAnimation,
                              builder: (ctx, ch) => Container(
                                height: _myAnimation.value.height,
                                width: _myAnimation.value.height,
                                child: Stack(
                                  children: [
                                    TimeCircularCountdown(
                                      unit: CountdownUnit.second,
                                      countdownTotal: timeButtons == null ||
                                              timeButtons == 0
                                          ? 1000
                                          : timeButtons,
                                      onUpdated: (unit, remainingTime) {
                                        setState(() {
                                          // _controller.forward();
                                          mil = remainingTime;
                                        });
                                      },
                                      // functiaSize(remainingTime),
                                      onFinished: () async {
                                        setState(() {
                                          mil = 0;
                                          listButtons[0] = Container(
                                            child: Container(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * 0.001),
                                                child: Transform(
                                                  transform: Matrix4.skewX(-0.2)
                                                    ..rotateY(3.14 / 12.0),
                                                  origin: Offset(50.0, 50.0),
                                                  child: Coloris(list1[0].text,
                                                      list[0].cost, Colors.red),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                        Future.delayed(Duration(seconds: 1),
                                            () async {
                                          order = list1[0].nextOrder;
                                          order == ""
                                              ? statusEnd = true
                                              : print('a');
                                          await controller2.forward();
                                          await controller.reverse();
                                          setState(() {
                                            controller.forward();
                                            controller2.forward();
                                            element(
                                              x,
                                              y,
                                              xBack,
                                            );
                                          });
                                        });
                                      },
                                      // diameter: _myAnimation.value.height,
                                      countdownCurrentColor: Colors.blue,
                                      countdownTotalColor: Colors.red,
                                      countdownRemainingColor: Colors.black,

                                      // diameter: 10,
                                    ),
                                    Container(
                                      height: height * 0.8,
                                      width: height * 8,
                                      child: Center(
                                        child: Text(
                                          "$mil",
                                          style:
                                              TextStyle(fontFamily: "Nunito"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(height * 100),
                                    color: Colors.white),
                              ),
                              // curve: Curves.easeIn,
                              // vsync: this,
                              // duration: Duration(seconds: 0),
                            ),
                          ),
                        ),
                      )
                    : Container()
                : Container(),
          ],
        ),
      );
    }
  }

  functiaPereborImage() async {
    Set setBack = new Set();
    for (var i = 0; i < listScenes.length; i++) {
      setBack.add(listScenes[i].backgroundImageName);
    }
    String dir = (await getApplicationDocumentsDirectory()).path;
    for (var i = 0; i < setBack.length; i++) {
      File file = File('$dir/$nameImage');
    }
  }

  functiaSaveImage(var height, var wight, var dr, var da) async {
    numberStream = 0.0;
    progresStrean = 0.0;
    col = 0.0;
    imageCache.clearLiveImages();
    imageCache.clear();
    Set setBack = new Set();
    Set setHero = new Set();
    print("${imageCache.currentSizeBytes}" + "размер кеша изображении");
    print("${imageCache.currentSize}" + "количество картинок изображении");
    Map map = new Map();
    Map mapHero = new Map();
    String dir = (await getApplicationDocumentsDirectory()).path;
    for (var i = 0; i < listScenes.length; i++) {
      String nameImage = listScenes[i].backgroundImageName;
      String nameImageHero = listScenes[i].heroImageName;
      if (nameImage.isNotEmpty) {
        setBack.add(nameImage);
      }
      if (nameImageHero.isNotEmpty) {
        setHero.add(nameImageHero);
      }
    }
    col = col + setBack.length.toDouble();
    col = col + setHero.length.toDouble();
    progresStrean = 1 / col;
    for (var i in setBack) {
      File file = File('$dir/$i');
      var imagen = await file.readAsBytes();
      var imageB = Image.memory(
        imagen,
        height: height,
        width: wight,
        cacheHeight: 1000,
        cacheWidth: 600,
        scale: 1,
        repeat: ImageRepeat.noRepeat,
      );
      await precacheImage(
        imageB.image,
        context,
      );
      map[i] = imageB;
      numberStream = numberStream + progresStrean;
      tream2(numberStream);
    }
    for (var i in setHero) {
      File file = File('$dir/$i');
      var imagen = await file.readAsBytes();
      var imageB = Image.memory(
        imagen,
        height: height,
        width: wight,
        cacheHeight: 1000,
        cacheWidth: 600,
        scale: 1,
        repeat: ImageRepeat.noRepeat,
      );
      await precacheImage(
        imageB.image,
        context,
      );
      mapHero[i] = imageB;
      mapSaveHero = mapHero;
      numberStream = numberStream + progresStrean;
      tream2(numberStream);
    }
    return map;
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    Paint getColoredPaint(Color color) {
      Paint paint = Paint();
      paint.color = color;
      return paint;
    }

    Path path = Path();
    path.addPolygon([
      Offset(size.width / 2, size.height),
      Offset(size.width / 100, size.height / 100),
      Offset(size.width, size.height),
    ], false);
    canvas.drawPath(path, getColoredPaint(Color.fromRGBO(239, 222, 205, 1)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PathPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Path path = Path();
    path.addPolygon([
      Offset(size.width / 2, size.height / 1.04),
      Offset(size.width / 100, size.height / 100),
      Offset(size.width, size.height / 1.05),
    ], false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PathPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    Paint getColoredPaint(Color color) {
      Paint paint = Paint();
      paint.color = color;
      return paint;
    }

    Path path = Path();
    path.addPolygon([
      Offset(size.width / 100, size.height),
      Offset(size.width, size.height / 100),
      Offset(size.width / 2, size.height),
    ], false);
    canvas.drawPath(path, getColoredPaint(Color.fromRGBO(239, 222, 205, 1)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PathPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Path path = Path();
    path.addPolygon([
      Offset(size.width / 100, size.height / 1.045),
      Offset(size.width, size.height / 100),
      Offset(size.width / 2, size.height / 1.04),
    ], false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Coins extends StatefulWidget {
  int diamonds;
  Coins(this.diamonds);

  @override
  CoinsSate createState() => CoinsSate(this.diamonds);
}

class CoinsSate extends State<Coins> {
  int diamonds;
  var coinss;
  CoinsSate(this.diamonds);

  @override
  Widget build(BuildContext context) {
    final UserInfotoo userFireBase = Provider.of<UserInfotoo>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.8,
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.015),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(162, 173, 208, 1),
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(height * 1)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: width * 0.13,
                                ),
                                child: Column(
                                  children: [
                                    StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(userFireBase.uid)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Container(
                                              child: Text(diamonds.toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Nunito")),
                                            );
                                          } else {
                                            diamonds =
                                                snapshot.data['diamonds'];
                                            return Container(
                                              child: Text(
                                                diamonds.toString(),
                                                style: TextStyle(
                                                    fontFamily: "Nunito",
                                                    color: Colors.white),
                                              ),
                                            );
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.01, right: width * 0.01),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Shop()));
                                  },
                                  child: Container(
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.004),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: height * 0.055,
                    width: width * 0.12,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: Color.fromRGBO(255, 204, 153, 1),
                        borderRadius: BorderRadius.circular(height * 100)),
                    child: Center(
                      child: Image.asset(
                        "assets/diamondsLitle.png",
                        height: height * 0.06,
                        // width: 50,
                        // color: Colors.red,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Coloris extends StatefulWidget {
  Color color;
  String text;
  int cost;
  Coloris(this.text, this.cost, this.color);
  @override
  _ColorisState createState() => _ColorisState();
}

class _ColorisState extends State<Coloris> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(
          maxWidth: width * 0.8,
          minHeight: height * 0.05,
          minWidth: width * 0.6),
      width: width * 0.7,
      child: Padding(
        padding: EdgeInsets.all(height * 0.01),
        child: Row(
          children: [
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: width * 0.5,
                    minHeight: height * 0.05,
                    minWidth: width * 0.5),
                decoration: BoxDecoration(
                    color: widget.cost > 0
                        ? Color.fromRGBO(179, 68, 108, 1)
                        : Color.fromRGBO(
                            179, 68, 108, 1), //  Цвет текста кнопок
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(height * 0.02)),
                child: Padding(
                  padding: EdgeInsets.all(height * 0.01),
                  child: Text(
                    widget.text == null ? "" : widget.text,
                    style: TextStyle(fontFamily: "Nunito", color: Colors.white),
                  ),
                ),
              ),
            ),
            widget.cost != 0
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Transform(
                        transform: Matrix4.skewX(-0.2)..rotateY(3.14 / 12.0),
                        origin: Offset(50.0, 50.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.002),
                              child: Container(
                                child: Transform(
                                  transform: Matrix4.skewX(0.1)
                                    ..rotateY(3.14 / 12.0),
                                  child: Image.asset(
                                    "assets/diamondsLitle.png",
                                    height: height * 0.05,
                                    // width: 50,
                                    // color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.cost != 0 ? widget.cost.toString() : "",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: "Nunito"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(height * 0.02),
      ),
    );
  }
}
