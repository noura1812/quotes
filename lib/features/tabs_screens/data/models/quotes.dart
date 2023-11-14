import 'package:quotes/features/tabs_screens/domain/entities/quotes_entity.dart';

class Quotes extends QuotesEntity {
  Quotes({super.quote, super.author, super.category});

  Quotes.fromJson(Map<String, dynamic> json) {
    if (json["quote"] is String) {
      quote = json["quote"];
    }
    if (json["author"] is String) {
      author = json["author"];
    }
    if (json["category"] is String) {
      category = json["category"];
    }
  }
}
