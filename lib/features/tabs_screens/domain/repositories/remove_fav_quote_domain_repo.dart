import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';

abstract class RemoveFavQuotesDomainRepo {
  Future<Either<Failures, bool>> removeQuotesData(
      QuotesDataEntity quotesDataEntity);
}
