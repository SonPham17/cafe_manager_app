abstract class LoadingState {
  bool isShow;

  LoadingState({this.isShow});
}

class LoadingInitialState extends LoadingState {}

class ShowLoadingState extends LoadingState {
  ShowLoadingState({bool isShow}) : super(isShow: isShow);
}
