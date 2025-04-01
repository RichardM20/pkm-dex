String capitalize(String? text) {
  if (text == null || text.isEmpty) return '';
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

String formatSpecial(String? text) {
  if (text == null || text.isEmpty) return '';
  if (text.toLowerCase().contains('special')) {
    return text.replaceAllMapped(
      RegExp(r'special-(\w+)', caseSensitive: false),
      (match) => 'Sp. ${capitalize(match.group(1) ?? '').replaceAll('-', ' ')}',
    );
  }
  return capitalize(text).replaceAll('-', ' ');
}
