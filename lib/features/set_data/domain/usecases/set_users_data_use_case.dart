// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/set_data/domain/repositories/set_users_domain_repo.dart';

class SetUsersDataUseCase {
  SetUsersDataDomainRepo setUsersDataDomainRepo;
  UsersDataModel usersDataModel;
  SetUsersDataUseCase({
    required this.setUsersDataDomainRepo,
    required this.usersDataModel,
  });
  Future<Either<Failures, void>> call() =>
      setUsersDataDomainRepo.setUsersData(usersDataModel);
}
