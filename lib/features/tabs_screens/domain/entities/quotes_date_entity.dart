import 'package:quotes/features/tabs_screens/domain/entities/images_entity.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_entity.dart';

class QuotesDataEntity {
  ImagesEntity image;
  QuotesEntity quote;
  QuotesDataEntity({
    required this.image,
    required this.quote,
  });
}
