class MySticker {
  String? imageUrl, title;

  MySticker({this.imageUrl, this.title});

  factory MySticker.fromJson(var sticker) {
    return MySticker(
      imageUrl: sticker['imageurl'] ?? '',
      title: sticker['title'] ?? '',
    );
  }
}

class SubSticker {
  String? image;
  SubSticker({this.image});
  factory SubSticker.fromJson(var sticker) {
    return SubSticker(
      image: sticker['imageurl'] ?? '',
    );
  }
}


class BackgroundModel {
  String? image;
  BackgroundModel({this.image});
  factory BackgroundModel.fromJson(var sticker) {
    return BackgroundModel(
      image: sticker['imageUrl'] ?? '',
    );
  }
}