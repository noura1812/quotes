import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/domain/repositories/save_fav_quotes_domain_repo.dart';

class SaveFavQuotesUseCase {
  SaveFavQuotesDomainRepo saveFavQuotesDomainRepo;
  SaveFavQuotesUseCase({
    required this.saveFavQuotesDomainRepo,
  });
  Future<Either<Failures, void>> call(QuotesDataEntity quotesDataEntity) =>
      saveFavQuotesDomainRepo.saveQuotesData(quotesDataEntity);
}
