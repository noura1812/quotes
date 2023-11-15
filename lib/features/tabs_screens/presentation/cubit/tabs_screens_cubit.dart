import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/tabs_screens/data/datasources/local.dart';
import 'package:quotes/features/tabs_screens/data/datasources/remote.dart';
import 'package:quotes/features/tabs_screens/data/repositories/get_quotes_data_repo.dart';
import 'package:quotes/features/tabs_screens/data/repositories/remove_fav_quote_data_repo.dart';
import 'package:quotes/features/tabs_screens/data/repositories/save_fav_quotes_data_repo.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/domain/usecases/get_quotes_data.dart';
import 'package:quotes/features/tabs_screens/domain/usecases/remove_fav_quote.dart';
import 'package:quotes/features/tabs_screens/domain/usecases/save_fav_quotes.dart';
import 'package:quotes/features/tabs_screens/presentation/pages/tabs/fav_tab.dart';
import 'package:quotes/features/tabs_screens/presentation/pages/tabs/home_tab.dart';

part 'tabs_screens_state.dart';

class TabsScreensCubit extends Cubit<TabsScreensState> {
  List<QuotesDataEntity> remoteQuotesList = [];
  List<QuotesDataEntity> localQuotesList = [];
  int tab = 0;
  UsersDataModel? usersDataModel;
  final ScrollController scrollController = ScrollController();
  double listOffset = 0;

  TabsScreensCubit() : super(TabsScreensInitial());
  static TabsScreensCubit get(context) => BlocProvider.of(context);
  changeTabs(int index) {
    tab = index;
    emit(SwitchTabsState());
    if (tab == 0) {
      if (remoteQuotesList.isNotEmpty) {
        emit(TabsScreensGetDataRemoteSuccessState());
      } else {
        getQuotesData(true);
      }
    } else {
      if (localQuotesList.isEmpty) {
        getQuotesData(false);
      }
    }
  }

  currentTab() {
    List tabs = [HomeTab(), const FavTab()];
    return tabs[tab];
  }

  currentOffset(double val) {
    listOffset = val;
  }

  changeSettings(UsersDataModel user) {
    usersDataModel = user;
    AppColors.primaryColor = Color(usersDataModel?.color ?? 0000);

    emit(ChangeSettings());
  }

  getUsersData() async {
    usersDataModel ??= await UsersDataModel.getCash();
    AppColors.primaryColor = Color(usersDataModel?.color ?? 0000);
    getQuotesData(true);
  }

  Future addToFav(int index) async {
    remoteQuotesList[index].favorite = true;
    SaveFavQuotesDataRepo saveFavDataRepo = SaveFavQuotesDataRepo();
    SaveFavQuotesUseCase getQuotesDataUseCase =
        SaveFavQuotesUseCase(saveFavQuotesDomainRepo: saveFavDataRepo);
    var result = await getQuotesDataUseCase.call(remoteQuotesList[index]);
    result.fold((l) {
      emit(RemoveFromFavFailure(failures: l));
    }, (r) {
      localQuotesList.add(remoteQuotesList[index]);
      emit(AddFavSuccessfully(added: r));
    });
  }

  Future removeFromFav(int index) async {
    for (var element in remoteQuotesList) {
      if (element.quote!.quote == localQuotesList[index].quote!.quote) {
        element.favorite = false;
        break;
      }
    }

    RemoveFavQuotesDataRepo removeFavDataRepo = RemoveFavQuotesDataRepo();
    RemoveFavQuotesUseCase getQuotesDataUseCase =
        RemoveFavQuotesUseCase(removeFavQuotesDomainRepo: removeFavDataRepo);
    var result = await getQuotesDataUseCase.call(localQuotesList[index]);
    result.fold((l) {
      emit(RemoveFromFavFailure(failures: l));
    }, (r) {
      localQuotesList.removeAt(index);
      emit(RemoveFromFavSuccessfully(removed: r));
    });
  }

  getQuotesData(bool remote) async {
    emit(TabsScreensGetDataLoadingState());
    GetQuotesDataDRepo getQuotesDataDRepo = GetQuotesDataDRepo(
        getQuotesDDataSource: !remote ? LocalDto() : RemoteDto());
    GetQuotesDataUseCase getQuotesDataUseCase =
        GetQuotesDataUseCase(getQuotesDataRepo: getQuotesDataDRepo);
    var result =
        await getQuotesDataUseCase.call(usersDataModel: usersDataModel);
    result.fold((l) async {
      if (remote) {
        if (localQuotesList.isNotEmpty) {
          remoteQuotesList.addAll(localQuotesList);
        } else {
          await remoteFailure();
        }
      } else {
        emit(TabsScreensGetDataLocalFailureState(failures: l));
      }
    }, (r) {
      if (tab == 1) {
        localQuotesList.clear();
        localQuotesList = r;
        emit(TabsScreensGetDataLocalSuccessState());
      } else {
        remoteQuotesList.addAll(r);
        emit(TabsScreensGetDataRemoteSuccessState());
      }
    });
  }

  Future remoteFailure() async {
    GetQuotesDataDRepo getQuotesDataDRepo =
        GetQuotesDataDRepo(getQuotesDDataSource: LocalDto());
    GetQuotesDataUseCase getQuotesDataUseCase =
        GetQuotesDataUseCase(getQuotesDataRepo: getQuotesDataDRepo);
    var result =
        await getQuotesDataUseCase.call(usersDataModel: usersDataModel);
    result.fold((l) {}, (r) {
      if (r.isEmpty) {
        emit(TabsScreensGetDataRemoteFailureState(
            failures: const ServerFailure(message: '')));
      } else {
        localQuotesList.clear();
        localQuotesList = r;
        remoteQuotesList.addAll(r);
        emit(TabsScreensGetDataRemoteSuccessState());
      }
    });
  }
}
