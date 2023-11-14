import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/domain/repositories/remove_fav_quote_domain_repo.dart';

class RemoveFavQuotesUseCase {
  RemoveFavQuotesDomainRepo removeFavQuotesDomainRepo;
  RemoveFavQuotesUseCase({
    required this.removeFavQuotesDomainRepo,
  });
  Future<Either<Failures, bool>> call(QuotesDataEntity quotesDataEntity) =>
      removeFavQuotesDomainRepo.removeQuotesData(quotesDataEntity);
}
