// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/tabs_screens/data/datasources/data_sources.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/domain/repositories/save_fav_quotes_domain_repo.dart';

class SaveFavQuotesDataRepo implements SaveFavQuotesDomainRepo {
  QuotesDataSource quotesDataSource;
  SaveFavQuotesDataRepo({
    required this.quotesDataSource,
  });
  @override
  Future<Either<Failures, bool>> saveQuotesData(
          QuotesDataEntity quotesDataEntity) =>
      quotesDataSource.saveQuotesData(quotesDataEntity);
}
