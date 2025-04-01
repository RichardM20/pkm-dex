String formatPokedexNumber(int? id) {
  if (id == null) {
    return '000';
  }
  return id.toString().padLeft(3, '0');
}
