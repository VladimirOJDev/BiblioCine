import 'package:intl/intl.dart';

class HumanFormats {
  /// Convierte un número double a un formato compacto legible (ej: 4560.8 -> 4.6K)
 static String number(double number, [int decimals = 1]) {
    
    // Si el número es menor a 1000, usamos un formato decimal simple
    if (number < 1000) {
      return NumberFormat.decimalPattern('en')
        .format(number.toInt());
    }

    // Para números >= 1000, usamos el formato compacto (K, M, etc.)
    final NumberFormat formatter = NumberFormat.compact(
      locale: 'en',
    );

    formatter.maximumFractionDigits = decimals;
    
    return formatter.format(number);
  }
}