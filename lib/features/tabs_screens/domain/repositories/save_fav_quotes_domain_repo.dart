import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';

abstract class SaveFavQuotesDomainRepo {
  Future<Either<Failures, void>> saveQuotesData(
      QuotesDataEntity quotesDataEntity);
}
