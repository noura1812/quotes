import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';

abstract class SetUsersDataDomainRepo {
  Future<Either<Failures, void>> setUsersData(UsersDataModel usersDataEntity);
}
