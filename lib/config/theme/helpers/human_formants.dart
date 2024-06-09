import 'package:intl/intl.dart';

class HumanFormants {
  static humanReadbleNumber(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format(number);

    return formatterNumber;
  }
}
