import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/domain/repositories/get_quotes_data_domain_repo.dart';

class GetQuotesDataUseCase {
  GetQuotesDataDomainRepo getQuotesDataRepo;
  GetQuotesDataUseCase({
    required this.getQuotesDataRepo,
  });
  Future<Either<Failures, List<QuotesDataEntity>>> call(
          {UsersDataModel? usersDataModel}) =>
      getQuotesDataRepo.getQuotesData(usersDataModel: usersDataModel);
}
