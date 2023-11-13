import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';

abstract class GetQuotesDataDomainRepo {
  Future<Either<Failures, List<QuotesDataEntity>>> getQuotesData(
      {UsersDataModel? usersDataModel});
}
