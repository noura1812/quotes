// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/tabs_screens/data/datasources/data_sources.dart';
import 'package:quotes/features/tabs_screens/data/datasources/local.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/domain/repositories/remove_fav_quote_domain_repo.dart';

class RemoveFavQuotesDataRepo implements RemoveFavQuotesDomainRepo {
  QuotesDataSource quotesDataSource = LocalDto();
  RemoveFavQuotesDataRepo();
  @override
  Future<Either<Failures, bool>> removeQuotesData(
          QuotesDataEntity quotesDataEntity) =>
      quotesDataSource.removeQuotesData(quotesDataEntity);
}
