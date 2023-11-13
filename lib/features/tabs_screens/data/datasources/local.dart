import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/utils/constants.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/tabs_screens/data/datasources/data_sources.dart';
import 'package:quotes/features/tabs_screens/data/models/quotes_data.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDto implements QuotesDataSource {
  @override
  Future<Either<Failures, List<QuotesData>>> getQuotesData(
      {UsersDataModel? usersDataModel}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? jsonList = prefs.getStringList(Constants.cachedFaveQuotes);
      List<QuotesData> quotesList = [];
      for (var quote in jsonList ?? []) {
        QuotesData data =
            QuotesDataEntity.fromJson(jsonDecode(quote)) as QuotesData;
        quotesList.add(data);
      }
      return right(quotesList);
    } catch (e) {
      return left(CachedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> saveQuotesData(
      QuotesDataEntity quotesDataEntity) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? allFaveQuotes =
          prefs.getStringList(Constants.cachedFaveQuotes);
      final String jsonString = jsonEncode(quotesDataEntity.toJson());
      allFaveQuotes == null
          ? allFaveQuotes = [jsonString]
          : allFaveQuotes.add(jsonString);

      await prefs.setStringList(Constants.cachedFaveQuotes, allFaveQuotes);
      return right(null);
    } catch (e) {
      return left(CachedFailure(message: e.toString()));
    }
  }
}
