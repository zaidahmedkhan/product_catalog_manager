String formatPrice(double price) {
  final fixed = price.toStringAsFixed(2);
  final parts = fixed.split('.');
  final digits = parts[0];
  final buffer = StringBuffer('\$');
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(digits[i]);
  }
  buffer.write('.${parts[1]}');
  return buffer.toString();
}
