import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';

class QuotesData extends QuotesDataEntity {
  QuotesData({required image, required quote, favorite})
      : super(image: image, quote: quote, favorite: favorite);
}
