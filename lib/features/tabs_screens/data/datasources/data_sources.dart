import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/tabs_screens/data/models/quotes_data.dart';

abstract class GetQuotesDDataSource {
  Future<Either<Failures, QuotesData>> getQuotesData();
}
