import 'package:quotes/features/tabs_screens/domain/entities/images_entity.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_entity.dart';

class QuotesDataEntity {
  ImagesEntity? image;
  QuotesEntity? quote;
  bool? favorite;
  QuotesDataEntity(
      {required this.image, required this.quote, this.favorite = false});
  QuotesDataEntity.fromJson(Map<String, dynamic> json) {
    image = ImagesEntity.fromJson(json['image']);
    quote = QuotesEntity.fromJson(json['quote']);
    favorite = json['favorite'];
  }
  Map<String, dynamic> toJson() {
    return {
      'image': image!.toJson(),
      'quote': quote!.toJson(),
      'favorite': favorite
    };
  }
}
