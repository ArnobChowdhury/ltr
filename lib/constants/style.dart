const double baseSpacing = 8.0;

// Define spacing multiples
const double spacing1x = baseSpacing;
const double spacing2x = baseSpacing * 2;
const double spacing3x = baseSpacing * 3;
const double spacing4x = baseSpacing * 4;
const double spacing5x = baseSpacing * 5;
const double spacing6x = baseSpacing * 6;
const double spacing7x = baseSpacing * 7;

String bgToTextColor(String bgColor) {
  Map<String, String> colorMap = {
    '2767A1': 'E1EDF9',
    '037B79': 'D9F1F1',
    '5D9476': 'E7EFEA',
    'AE4A5C': 'FCE7EB',
    'F77C43': 'FEEBE3',
    'F2C749': 'FDF7E4',
    'ADAE80': 'E7E8AB'
  };

  return colorMap[bgColor] ?? 'FFFFFF';
}
