import 'package:quotes/features/tabs_screens/domain/entities/images_entity.dart';

class Images {
  int? total;
  int? totalHits;
  List<Hits>? hits;

  Images({this.total, this.totalHits, this.hits});

  Images.fromJson(Map<String, dynamic> json) {
    if (json["total"] is int) {
      total = json["total"];
    }
    if (json["totalHits"] is int) {
      totalHits = json["totalHits"];
    }
    if (json["hits"] is List) {
      hits = json["hits"] == null
          ? null
          : (json["hits"] as List).map((e) => Hits.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["total"] = total;
    _data["totalHits"] = totalHits;
    if (hits != null) {
      _data["hits"] = hits?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Hits extends ImagesEntity {
  String? pageUrl;
  String? tags;
  String? previewUrl;
  int? previewWidth;
  int? previewHeight;
  String? webformatUrl;
  int? webformatWidth;
  int? webformatHeight;
  int? imageWidth;
  int? imageHeight;
  int? imageSize;
  int? views;
  int? downloads;
  int? collections;
  int? likes;
  int? comments;
  int? userId;
  String? user;
  String? userImageUrl;

  Hits(
      {super.id,
      this.pageUrl,
      super.type,
      this.tags,
      this.previewUrl,
      this.previewWidth,
      this.previewHeight,
      this.webformatUrl,
      this.webformatWidth,
      this.webformatHeight,
      super.largeImageUrl,
      this.imageWidth,
      this.imageHeight,
      this.imageSize,
      this.views,
      this.downloads,
      this.collections,
      this.likes,
      this.comments,
      this.userId,
      this.user,
      this.userImageUrl});

  Hits.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["pageURL"] is String) {
      pageUrl = json["pageURL"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["tags"] is String) {
      tags = json["tags"];
    }
    if (json["previewURL"] is String) {
      previewUrl = json["previewURL"];
    }
    if (json["previewWidth"] is int) {
      previewWidth = json["previewWidth"];
    }
    if (json["previewHeight"] is int) {
      previewHeight = json["previewHeight"];
    }
    if (json["webformatURL"] is String) {
      webformatUrl = json["webformatURL"];
    }
    if (json["webformatWidth"] is int) {
      webformatWidth = json["webformatWidth"];
    }
    if (json["webformatHeight"] is int) {
      webformatHeight = json["webformatHeight"];
    }
    if (json["largeImageURL"] is String) {
      largeImageUrl = json["largeImageURL"];
    }
    if (json["imageWidth"] is int) {
      imageWidth = json["imageWidth"];
    }
    if (json["imageHeight"] is int) {
      imageHeight = json["imageHeight"];
    }
    if (json["imageSize"] is int) {
      imageSize = json["imageSize"];
    }
    if (json["views"] is int) {
      views = json["views"];
    }
    if (json["downloads"] is int) {
      downloads = json["downloads"];
    }
    if (json["collections"] is int) {
      collections = json["collections"];
    }
    if (json["likes"] is int) {
      likes = json["likes"];
    }
    if (json["comments"] is int) {
      comments = json["comments"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["user"] is String) {
      user = json["user"];
    }
    if (json["userImageURL"] is String) {
      userImageUrl = json["userImageURL"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["pageURL"] = pageUrl;
    _data["type"] = type;
    _data["tags"] = tags;
    _data["previewURL"] = previewUrl;
    _data["previewWidth"] = previewWidth;
    _data["previewHeight"] = previewHeight;
    _data["webformatURL"] = webformatUrl;
    _data["webformatWidth"] = webformatWidth;
    _data["webformatHeight"] = webformatHeight;
    _data["largeImageURL"] = largeImageUrl;
    _data["imageWidth"] = imageWidth;
    _data["imageHeight"] = imageHeight;
    _data["imageSize"] = imageSize;
    _data["views"] = views;
    _data["downloads"] = downloads;
    _data["collections"] = collections;
    _data["likes"] = likes;
    _data["comments"] = comments;
    _data["user_id"] = userId;
    _data["user"] = user;
    _data["userImageURL"] = userImageUrl;
    return _data;
  }
}
