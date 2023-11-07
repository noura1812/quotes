// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/set_data/data/datastores/data_sources.dart';
import 'package:quotes/features/set_data/domain/repositories/set_users_data_repo.dart';

class SetUsersDDataRepo implements SetUsersDataDomainRepo {
  SetUsersDDataSource setUsersDDataSource;
  SetUsersDDataRepo({
    required this.setUsersDDataSource,
  });
  @override
  Future<Either<Failures, void>> setUsersData(usersDataEntity) =>
      setUsersDDataSource.setUsersData(usersDataEntity);
}
