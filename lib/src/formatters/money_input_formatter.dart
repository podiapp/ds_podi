import 'package:flutter/services.dart';

///Formata o resultado do [TextField] em dinheiro "R$ 00,00"
class MoneyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp('([^0-9])'), '');

    while (text.startsWith('0')) {
      text = text.substring(1);
    }
    while (text.length < 3) {
      text = "0$text";
    }

    final newText =
        "R\$ ${text.substring(0, text.length - 2)},${text.substring(text.length - 2)}";

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
