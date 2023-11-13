import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failures.dart';
import 'package:quotes/features/tabs_screens/data/datasources/data_sources.dart';
import 'package:quotes/features/tabs_screens/data/repositories/get_quotes_data_repo.dart';
import 'package:quotes/features/tabs_screens/domain/entities/quotes_date_entity.dart';
import 'package:quotes/features/tabs_screens/domain/usecases/get_quotes_data.dart';

part 'tabs_screens_state.dart';

class TabsScreensCubit extends Cubit<TabsScreensState> {
  QuotesDataSource getQuotesDDataSource;
  TabsScreensCubit(this.getQuotesDDataSource) : super(TabsScreensInitial());
  static TabsScreensCubit get(context) => BlocProvider.of(context);

  getQuotesData() async {
    emit(TabsScreensGetDataRemoteLoadingState());
    GetQuotesDataDRepo getQuotesDataDRepo =
        GetQuotesDataDRepo(getQuotesDDataSource: getQuotesDDataSource);
    GetQuotesDataUseCase getQuotesDataUseCase =
        GetQuotesDataUseCase(getQuotesDataRepo: getQuotesDataDRepo);
    var result = await getQuotesDataUseCase.call();
    result.fold((l) {
      emit(TabsScreensGetDataRemoteFailureState(failures: l));
    }, (r) {
      emit(TabsScreensGetDataRemoteSuccessState(quotes: r));
    });
  }
}
