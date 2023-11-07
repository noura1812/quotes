// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'set_data_cubit.dart';

abstract class SetDataState {}

class SetDataInitial extends SetDataState {}

class AddColorState extends SetDataState {}

class AddCategoryState extends SetDataState {}

class DeleteCategoryState extends SetDataState {}

class SelectColorState extends SetDataState {}

class SearchCategoriesState extends SetDataState {}

class SelectCategoryState extends SetDataState {}

class PickColorState extends SetDataState {}

class SetUsersDataLoadingState extends SetDataState {}

class SetUsersDataSuccessState extends SetDataState {
  UsersDataModel usersDataModel;
  SetUsersDataSuccessState({
    required this.usersDataModel,
  });
}

class SetUsersDataFailureState extends SetDataState {
  Failures failures;
  SetUsersDataFailureState({
    required this.failures,
  });
}
