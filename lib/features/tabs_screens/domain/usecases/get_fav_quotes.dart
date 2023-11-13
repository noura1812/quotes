import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/domain/repositories/get_quotes_data_domain_repo.dart';

class GetFavQuotesUseCase {
  GetQuotesDataDomainRepo getQuotesDataRepo;
  GetFavQuotesUseCase({
    required this.getQuotesDataRepo,
  });
  Future<Either<Failures, List<QuotesDataEntity>>> call() =>
      getQuotesDataRepo.getQuotesData();
}
