// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tabs_screens_cubit.dart';

abstract class TabsScreensState {}

class TabsScreensInitial extends TabsScreensState {}

class TabsScreensGetDataRemoteSuccessState extends TabsScreensState {}

class TabsScreensGetDataRemoteFailureState extends TabsScreensState {
  Failures failures;
  TabsScreensGetDataRemoteFailureState({
    required this.failures,
  });
}

class TabsScreensGetDataLoadingState extends TabsScreensState {}

class TabsScreensGetDataLocalSuccessState extends TabsScreensState {}

class TabsScreensGetDataLocalFailureState extends TabsScreensState {
  Failures failures;
  TabsScreensGetDataLocalFailureState({
    required this.failures,
  });
}

class SwitchTabsState extends TabsScreensState {}

class ChangeSettings extends TabsScreensState {}

class AddFavSuccessfully extends TabsScreensState {
  bool added;
  AddFavSuccessfully({
    required this.added,
  });
}

class RemoveFromFavSuccessfully extends TabsScreensState {
  bool removed;
  RemoveFromFavSuccessfully({
    required this.removed,
  });
}

class AddFavFailure extends TabsScreensState {
  Failures failures;
  AddFavFailure({
    required this.failures,
  });
}

class RemoveFromFavFailure extends TabsScreensState {
  Failures failures;
  RemoveFromFavFailure({
    required this.failures,
  });
}
