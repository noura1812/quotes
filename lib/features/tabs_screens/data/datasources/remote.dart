import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:quotes/core/apis/end_points.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/utils/constants.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/tabs_screens/data/datasources/data_sources.dart';
import 'package:quotes/features/tabs_screens/data/models/images.dart';
import 'package:quotes/features/tabs_screens/data/models/quotes.dart';
import 'package:quotes/features/tabs_screens/data/models/quotes_data.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';

class RemoteDto implements QuotesDataSource {
  Dio dio = Dio();
  @override
  Future<Either<Failures, List<QuotesData>>> getQuotesData(
      {UsersDataModel? usersDataModel}) async {
    try {
      UsersDataModel usersData;
      if (usersDataModel == null) {
        usersData = await UsersDataModel.getCash();
      } else {
        usersData = usersDataModel;
      }

      Random random = Random();
      List<QuotesData> quotesList = [];
      for (var i = 0; i < 3; i++) {
        int category = random.nextInt(usersData.categories.length);
        int page = random.nextInt(5) + 1;
        String quoteCategory = usersData.categories[category];
        var quotesResponse = await dio.get(
            '${Constants.quotesBaseUrl}${EndPoints.quoteEndPoint}&category=$quoteCategory&');
        Quotes quotes = Quotes.fromJson(quotesResponse.data[0]);
        Images images = Images();
        while (images.hits == null || images.hits!.isEmpty) {
          var imagesResponse = await dio.get(
              '${Constants.imageBaseUrl}${EndPoints.imagesEndPoint}&q=$quoteCategory&page=$page&per_page=3');
          images = Images.fromJson(imagesResponse.data);
        }
        quotesList.add(QuotesData(image: images.hits![0], quote: quotes));
      }

      return right(quotesList);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> saveQuotesData(
      QuotesDataEntity quotesDataEntity) {
    throw UnimplementedError();
  }
}
