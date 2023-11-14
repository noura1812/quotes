import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/utils/constants.dart';
import 'package:quotes/features/set_data/data/datastores/data_sources.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/set_data/data/repositories/set_users_d_data_repo.dart';
import 'package:quotes/features/set_data/domain/repositories/set_users_data_repo.dart';
import 'package:quotes/features/set_data/domain/usecases/set_users_data_use_case.dart';
part 'set_data_state.dart';

class SetDataCubit extends Cubit<SetDataState> {
  List<String> categoriesList = [...Constants.categories];
  List<String> defaultCategories = [...Constants.categories];
  List<String> usersCategory = [];
  List<String> temp = [];
  bool select = false;
  List<Color> colorsList = [
    const Color(0xff3D30A2),
    const Color(0xffD6D46D),
    const Color(0xffE966A0),
    const Color(0xff9A3B3B),
  ];
  int selected = 0;
  SetUsersDDataSource setUsersDDataSource;
  SetDataCubit(this.setUsersDDataSource) : super(SetDataInitial());

  static SetDataCubit get(context) => BlocProvider.of(context);
  Future setUsersData(String name) async {
    UsersDataModel usersDataModel = UsersDataModel(
        color: selectedColor().value,
        name: name,
        categories: usersCategory.isEmpty ? defaultCategories : usersCategory);
    emit(SetUsersDataLoadingState());
    SetUsersDataDomainRepo setUsersDataDomainRepo =
        SetUsersDDataRepo(setUsersDDataSource: setUsersDDataSource);
    SetUsersDataUseCase productsListUseCase = SetUsersDataUseCase(
        setUsersDataDomainRepo: setUsersDataDomainRepo,
        usersDataModel: usersDataModel);
    var result = await productsListUseCase.call();
    result.fold((l) {
      emit(SetUsersDataFailureState(failures: l));
    }, (r) {
      emit(SetUsersDataSuccessState(usersDataModel: usersDataModel));
    });
  }

  pickColor() {
    emit(PickColorState());
  }

  changeSelected(int index) {
    emit(SelectColorState());
    selected = index;
  }

  searchCategories(String category) {
    if (category.trim().isNotEmpty) {
      temp = [...categoriesList];

      categoriesList = categoriesList
          .where((element) => element.contains(category))
          .toList();
    } else {
      categoriesList.clear();
      categoriesList = [...temp];
    }
    emit(SearchCategoriesState());
  }

  addColor(Color newColor) {
    colorsList.add(newColor);
    selected = colorsList.indexOf(newColor);
    emit(AddColorState());
  }

  addCategory(int index) {
    if (select == false && usersCategory.isEmpty) {
      select = true;
    }
    usersCategory.add(categoriesList[index]);
    usersCategory.sort();
    categoriesList.removeAt(index);
    emit(AddCategoryState());
  }

  Color selectedColor() {
    return colorsList[selected];
  }

  colorsHeight() {
    if ((colorsList.length + 1) % 5 == 0) {
      int height = (colorsList.length + 1) ~/ 5;
      return height;
    } else {
      int height = ((((colorsList.length + 1) / 5)) + 1).toInt();
      return height;
    }
  }

  deleteCategory(int index) {
    if (select == false) {
      usersCategory = [...categoriesList];
      categoriesList.clear();
      select = true;
    }
    categoriesList.add(usersCategory[index]);
    categoriesList.sort();
    usersCategory.removeAt(index);

    if (usersCategory.isEmpty) {
      select = false;
    }
    emit(DeleteCategoryState());
  }
}
