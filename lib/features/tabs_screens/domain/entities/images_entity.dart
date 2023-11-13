class ImagesEntity {
  String? largeImageUrl;
  String? type;
  int? id;
  ImagesEntity({
    this.largeImageUrl,
    this.type,
    this.id,
  });
  ImagesEntity.fromJson(Map<String, dynamic> json) {
    largeImageUrl = json['largeImageUrl'];
    type = json['type'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    return {
      'largeImageUrl': largeImageUrl,
      'type': type,
      'id': id,
    };
  }
}
