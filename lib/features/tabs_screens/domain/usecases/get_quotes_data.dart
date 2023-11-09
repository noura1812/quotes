import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/domain/repositories/get_quotes_data.dart';

class GetQuotesDataUseCase {
  GetQuotesDataDomainRepo getQuotesDataApiRepo;
  GetQuotesDataUseCase({
    required this.getQuotesDataApiRepo,
  });
  Future<Either<Failures, QuotesDataEntity>> call() =>
      getQuotesDataApiRepo.getQuotesDataApi();
}
