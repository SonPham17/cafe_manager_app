extension StringExtension on String{
  bool get isEmptyOrNull {
    if (this == null) {
      return true;
    }
    return isEmpty;
  }
}