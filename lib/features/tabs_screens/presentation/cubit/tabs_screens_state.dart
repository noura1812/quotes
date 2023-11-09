// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tabs_screens_cubit.dart';

abstract class TabsScreensState {}

class TabsScreensInitial extends TabsScreensState {}

class TabsScreensGetDataRemoteSuccessState extends TabsScreensState {
  QuotesDataEntity quotes;
  TabsScreensGetDataRemoteSuccessState({
    required this.quotes,
  });
}

class TabsScreensGetDataRemoteFailureState extends TabsScreensState {
  Failures failures;
  TabsScreensGetDataRemoteFailureState({
    required this.failures,
  });
}

class TabsScreensGetDataRemoteLoadingState extends TabsScreensState {}
