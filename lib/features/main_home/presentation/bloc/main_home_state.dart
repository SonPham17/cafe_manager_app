abstract class MainHomeState {
  int soMon;
  String monOrder;
  int soTien;

  MainHomeState({this.soMon, this.monOrder, this.soTien});
}

class MainHomeInitialState extends MainHomeState {}

class AddSuccessState extends MainHomeState{}

class AddFailedState extends MainHomeState{}

class IncrementOrderState extends MainHomeState {
  IncrementOrderState({String monOrder, int soMon, int soTien})
      : super(soMon: soMon, soTien: soTien, monOrder: monOrder);
}

class DecrementOrderState extends MainHomeState {
  DecrementOrderState({String monOrder, int soMon, int soTien})
      : super(soMon: soMon, soTien: soTien, monOrder: monOrder);
}
