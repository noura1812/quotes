import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/set_data/data/models/users_data_model.dart';
import 'package:quotes/features/tabs_screens/data/datasources/local.dart';
import 'package:quotes/features/tabs_screens/data/datasources/remote.dart';
import 'package:quotes/features/tabs_screens/data/repositories/get_quotes_data_repo.dart';
import 'package:quotes/features/tabs_screens/data/repositories/save_fav_quotes_data_repo.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/domain/usecases/get_quotes_data.dart';
import 'package:quotes/features/tabs_screens/domain/usecases/save_fav_quotes.dart';
import 'package:quotes/features/tabs_screens/presentation/pages/tabs/fav_tab.dart';
import 'package:quotes/features/tabs_screens/presentation/pages/tabs/home_tab.dart';

part 'tabs_screens_state.dart';

class TabsScreensCubit extends Cubit<TabsScreensState> {
  List<QuotesDataEntity> remoteQuotesList = [];
  List<QuotesDataEntity> localQuotesList = [];
  int tab = 0;
  UsersDataModel? usersDataModel;
  TabsScreensCubit() : super(TabsScreensInitial());
  static TabsScreensCubit get(context) => BlocProvider.of(context);
  changeTabs(int index) {
    tab = index;
    emit(SwitchTabsState());
    localQuotesList.isEmpty && tab == 1 ? getQuotesData() : null;
    tab == 0 && remoteQuotesList.isNotEmpty
        ? emit(TabsScreensGetDataRemoteSuccessState())
        : getQuotesData();
  }

  currentTab() {
    List tabs = [const HomeTab(), const FavTab()];
    return tabs[tab];
  }

  getUsersData() async {
    usersDataModel ??= await UsersDataModel.getCash();
    getQuotesData();
  }

  Future addToFav(int index) async {
    remoteQuotesList[index].favorite = true;
    SaveFavQuotesDataRepo saveFavDataRepo =
        SaveFavQuotesDataRepo(quotesDataSource: LocalDto());
    SaveFavQuotesUseCase getQuotesDataUseCase =
        SaveFavQuotesUseCase(saveFavQuotesDomainRepo: saveFavDataRepo);
    var result = await getQuotesDataUseCase.call(remoteQuotesList[index]);
    result.fold((l) {
      emit(AddFavFailure(failures: l));
    }, (r) {
      localQuotesList.add(remoteQuotesList[index]);
      emit(AddFavSuccessfully(added: r));
    });
  }

  getQuotesData() async {
    emit(TabsScreensGetDataLoadingState());
    GetQuotesDataDRepo getQuotesDataDRepo = GetQuotesDataDRepo(
        getQuotesDDataSource: tab == 1 ? LocalDto() : RemoteDto());
    GetQuotesDataUseCase getQuotesDataUseCase =
        GetQuotesDataUseCase(getQuotesDataRepo: getQuotesDataDRepo);
    var result =
        await getQuotesDataUseCase.call(usersDataModel: usersDataModel);
    result.fold((l) {
      emit(TabsScreensGetDataRemoteFailureState(failures: l));
    }, (r) {
      if (tab == 1) {
        localQuotesList.clear();
        localQuotesList = r;
      } else {
        remoteQuotesList.addAll(r);
      }

      emit(TabsScreensGetDataRemoteSuccessState());
    });
  }
}
