import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:quotes/core/apis/end_points.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/utils/constants.dart';
import 'package:quotes/features/tabs_screens/data/datasources/data_sources.dart';
import 'package:quotes/features/tabs_screens/data/models/images.dart';
import 'package:quotes/features/tabs_screens/data/models/quotes.dart';
import 'package:quotes/features/tabs_screens/data/models/quotes_data.dart';

class RemoteDto implements GetQuotesDDataSource {
  Dio dio = Dio();
  @override
  Future<Either<Failures, QuotesData>> getQuotesData() async {
    try {
      String quoteCategory = '';
      var quotesResponse = await dio.get(
          '${Constants.quotesBaseUrl}${EndPoints.quoteEndPoint}&category=$quoteCategory');
      Quotes quotes = Quotes.fromJson(quotesResponse.data[0]);

      String imageType = quotes.category ?? '';
      var imagesResponse = await dio.get(
          '${Constants.imageBaseUrl}${EndPoints.imagesEndPoint}&image_type=$imageType');
      Images images = Images.fromJson(imagesResponse.data);

      return right(QuotesData(image: images.hits![0], quote: quotes));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
