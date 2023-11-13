class QuotesEntity {
  String? quote;
  String? author;
  String? category;

  QuotesEntity({this.quote, this.author, this.category});
  QuotesEntity.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
    author = json['author'];
    category = json['category'];
  }
  Map<String, dynamic> toJson() {
    return {
      'quote': quote,
      'author': author,
      'category': category,
    };
  }
}
