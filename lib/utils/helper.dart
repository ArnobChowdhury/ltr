int hexToInt(String hexString) {
  return int.parse('FF$hexString', radix: 16);
}
