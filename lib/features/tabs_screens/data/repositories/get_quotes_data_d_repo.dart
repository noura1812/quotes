// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/tabs_screens/data/datasources/data_sources.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/domain/repositories/get_quotes_data.dart';

class GetQuotesDataDRepo implements GetQuotesDataDomainRepo {
  GetQuotesDDataSource getQuotesDDataSource;
  GetQuotesDataDRepo({
    required this.getQuotesDDataSource,
  });

  @override
  Future<Either<Failures, QuotesDataEntity>> getQuotesDataApi() =>
      getQuotesDDataSource.getQuotesData();
}
