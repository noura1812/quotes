import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/utils/constants.dart';
import 'package:quotes/features/set_data/data/datastores/data_sources.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/set_data/data/repositories/set_users_data_repo.dart';
import 'package:quotes/features/set_data/domain/repositories/set_users_domain_repo.dart';
import 'package:quotes/features/set_data/domain/usecases/set_users_data_use_case.dart';
part 'set_data_state.dart';

class SetDataCubit extends Cubit<SetDataState> {
  List<String> categoriesList = [...Constants.categories];
  List<String> defaultCategories = [...Constants.categories];
  List<String> usersCategory = [];
  List<String> temp = [];
  UsersDataModel? usersDataModel;
  final TextEditingController name = TextEditingController();

  bool select = false;
  List<Color> colorsList = [
    const Color(0xff3D30A2),
    const Color(0xffD6D46D),
    const Color(0xffE966A0),
    const Color(0xff9A3B3B),
  ];
  int selected = 0;
  SetUsersDDataSource setUsersDDataSource;
  SetDataCubit(this.setUsersDDataSource, {this.usersDataModel})
      : super(SetDataInitial()) {
    if (usersDataModel != null) {
      Color newColor = Color(usersDataModel?.color ?? 000);
      colorsList.contains(newColor) ? null : colorsList.add(newColor);
      usersCategory = [...usersDataModel!.categories];
      select = true;
      defaultCategories.clear();
      categoriesList.removeWhere((element) => usersCategory.contains(element));
      temp = [...categoriesList];
      selected = colorsList.indexOf(newColor);
      name.text = usersDataModel!.name;
    } else {
      temp = [...categoriesList];
    }
  }

  static SetDataCubit get(context) => BlocProvider.of(context);
  Future setUsersData() async {
    usersDataModel = UsersDataModel(
        color: selectedColor().value,
        name: name.text,
        categories: usersCategory.isEmpty ? defaultCategories : usersCategory);
    emit(SetUsersDataLoadingState());
    SetUsersDataDomainRepo setUsersDataDomainRepo =
        SetUsersDDataRepo(setUsersDDataSource: setUsersDDataSource);
    SetUsersDataUseCase productsListUseCase = SetUsersDataUseCase(
        setUsersDataDomainRepo: setUsersDataDomainRepo,
        usersDataModel: usersDataModel!);
    var result = await productsListUseCase.call();
    result.fold((l) {
      emit(SetUsersDataFailureState(failures: l));
    }, (r) {
      emit(SetUsersDataSuccessState(usersDataModel: usersDataModel!));
    });
  }

  pickColor() {
    emit(PickColorState());
  }

  refresh() {
    categoriesList = [...Constants.categories];
    defaultCategories = [...Constants.categories];
    usersCategory = [];
    temp = [...categoriesList];
    select = false;
    emit(RefreshState());
  }

  changeSelected(int index) {
    emit(SelectColorState());
    selected = index;
  }

  searchCategories(String category) {
    print('lllllll');
    categoriesList = [...temp];

    if (category.trim().isNotEmpty) {
      categoriesList = categoriesList
          .where((element) => element.contains(category))
          .toList();
      print(temp);
    } else {
      categoriesList = [...temp];
      print(temp);
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
    if (temp.isEmpty) {
      temp = [...categoriesList];
    }
    usersCategory.add(categoriesList[index]);
    usersCategory.sort();
    categoriesList.removeAt(index);
    temp.removeAt(index);

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
    temp = [...categoriesList];

    if (usersCategory.isEmpty) {
      select = false;
    }
    emit(DeleteCategoryState());
  }
}
