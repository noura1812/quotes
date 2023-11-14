import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/tabs_screens/data/models/quotes_data.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';

abstract class QuotesDataSource {
  Future<Either<Failures, List<QuotesData>>> getQuotesData(
      {UsersDataModel? usersDataModel});
  Future<Either<Failures, bool>> saveQuotesData(
      QuotesDataEntity quotesDataEntity);
  Future<Either<Failures, bool>> removeQuotesData(
      QuotesDataEntity quotesDataEntity);
}
