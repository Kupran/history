class Story {
  List<StoriesValues> listValues;
  String name;
  String description;
  String imageUrl;
  String imageName;
  List<Episode> listEpisodes;
  String language;
  String storyDocumentId;
  bool withAnimal;
  var price;
  // List<Garderob> listGarderob;

  Story(this.listValues, this.imageUrl, this.imageName, this.listEpisodes,
      this.storyDocumentId, this.withAnimal,this.price
      // this.listGarderob,
      );
}

class ImageAll {
  bool forced_wardrobe;
  String img_name;
  String img_url;
  ImageAll(this.forced_wardrobe, this.img_name, this.img_url);
}

class StoriesValues {
  String name;
  String description;
  String language;
  List listParametr;
  StoriesValues(this.name, this.description, this.language, this.listParametr);
}

class Episode {
  String episodeDocumentID;
  List<EpisodeValues> listValues;
  String imageUrl;
  String imageName;
  // List<Scene> listScenes;
  String nameAudio;
  String urlAudio;

  Episode(
      this.listValues,
      this.imageUrl,
      this.imageName,
      // this.listScenes,
      this.nameAudio,
      this.urlAudio,
      this.episodeDocumentID);
}

class EpisodeValues {
  String name;
  String description;
  String language;
  List listTalant;
  EpisodeValues(this.name, this.description, this.language, this.listTalant);
}

class ScenesValues {
  String language;
  String heroText;
  String heroName;
  ScenesValues(this.language, this.heroText, this.heroName);
}

class Garderob {
  List<ImageAll> listImageAll;
  List<ImageInfoBij> listImageInfoBij;
  List<ImageInfoClothes> listImageInfoClothes;
  List<ImageInfoHair> listImageInfoHair;
  List<ImageInfoLook> listImageInfoLook;
  Garderob(this.listImageAll, this.listImageInfoBij, this.listImageInfoClothes,
      this.listImageInfoHair, this.listImageInfoLook);
}

class ImageInfoBij {
  String available_bij;
  var ball_bij;
  String episode_bij;
  String img_name;
  String img_url;
  String name_bij;
  String prefix_bij;
  var price_bij;
  String select_hero_bij;
  ImageInfoBij(
      this.available_bij,
      this.ball_bij,
      this.episode_bij,
      this.img_name,
      this.img_url,
      this.name_bij,
      this.prefix_bij,
      this.price_bij,
      this.select_hero_bij);
}

class ImageInfoClothes {
  String available_clothes;
  var ball_clothes;
  String episode_clothes;
  String img_name;
  String img_url;
  String name_clothes;
  String prefix_clothes;
  var price_clothes;
  String select_hero_clothes;
  ImageInfoClothes(
      this.available_clothes,
      this.ball_clothes,
      this.episode_clothes,
      this.img_name,
      this.img_url,
      this.name_clothes,
      this.prefix_clothes,
      this.price_clothes,
      this.select_hero_clothes);
}

class ImageInfoHair {
  String available_hair;
  var ball_hair;
  String episode_hair;
  String img_name;
  String img_url;
  String name_hair;
  String prefix_hair;
  var price_hair;
  String select_hero_hair;
  ImageInfoHair(
      this.available_hair,
      this.ball_hair,
      this.episode_hair,
      this.img_name,
      this.img_url,
      this.name_hair,
      this.prefix_hair,
      this.price_hair,
      this.select_hero_hair);
}

class ImageInfoLook {
  String available_look;
  var ball_look;
  String episode_look;
  String img_name;
  String img_url;
  String name_look;
  String prefix_look;
  var price_look;
  String select_hero_look;
  ImageInfoLook(
      this.available_look,
      this.ball_look,
      this.episode_look,
      this.img_name,
      this.img_url,
      this.name_look,
      this.prefix_look,
      this.price_look,
      this.select_hero_look);
}

class Scene {
  bool status;
  // String heroName;
  // String heroText;

  bool forced_wardrobe;
  String heroImageName;
  String heroImageUrl;
  String backgroundImageName;
  String backgroundImageUrl;
  String order;
  String nextOrder;
  int direction;
  bool heroSelf;
  List<Button> listButtons;
  String nameAudio;
  String urlAudio;
  List<ScenesValues> listScenesValues;
  int time;
  int emotion;
  Scene(
      this.time,
      this.status,
      // this.heroName,
      // this.heroText,
      this.heroImageName,
      this.heroImageUrl,
      this.backgroundImageName,
      this.backgroundImageUrl,
      this.order,
      this.nextOrder,
      this.direction,
      this.heroSelf,
      this.nameAudio,
      this.urlAudio,
      this.listScenesValues,
      this.forced_wardrobe,
      this.emotion

      // this.language,
      );

  Scene.button(
      this.time,
      this.status,
      // this.heroName,
      // this.heroText,
      this.heroImageName,
      this.heroImageUrl,
      this.backgroundImageName,
      this.backgroundImageUrl,
      this.order,
      this.direction,
      this.heroSelf,
      this.listButtons,
      this.nameAudio,
      this.urlAudio,
      this.listScenesValues
      // this.language,
      );
}

class Language {
  String language;
  String short;
  Language(this.language, this.short);
  @override
  String toString() {
    return "$language" + "$short";
  }
}

class Button {
  List<ButtonValue> list;
  // String text;
  var show_ball;
  String nextOrder;
  String currency;
  int cost;
  var select_hero;
  int ball;
  var show_for_hero;

  Button(this.list, this.nextOrder, this.currency, this.cost, this.select_hero,
      this.ball, this.show_ball, this.show_for_hero);
  // Button(this.list);
}

class ButtonValue {
  String text;
  String language;
  // String nextOrder;
  // String currency;
  // int cost;

  ButtonValue(this.text, this.language);
}
