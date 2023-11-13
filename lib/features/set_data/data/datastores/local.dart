import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/utils/constants.dart';
import 'package:quotes/features/set_data/data/datastores/data_sources.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDto implements SetUsersDDataSource {
  @override
  Future<Either<Failures, void>> setUsersData(
      UsersDataModel usersDataModel) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String jsonString = jsonEncode(usersDataModel.toJson());
      await prefs.setString(Constants.cachedUserData, jsonString);
      return right(null);
    } catch (e) {
      return left(CachedFailure(message: e.toString()));
    }
  }
}
