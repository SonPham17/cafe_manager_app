abstract class SnackBarState{
  final String msg;

  SnackBarState({this.msg});
}

class SnackBarInitialState extends SnackBarState{}

class ShowSnackBarState extends SnackBarState{
  ShowSnackBarState({String msg}) : super(msg: msg);
}