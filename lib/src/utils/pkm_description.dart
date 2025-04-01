import 'package:poke_api/src/models/pokemon_detail_model.dart';
import 'package:poke_api/src/models/pokemon_move_details.dart';

String getPokemonDescription(
  List<FlavorTextEntry>? entries, {
  List<FlavorTextEntryMove>? entriesMove,
}) {
  const String defaultMessage = "No description available.";
  const String targetLanguage = "en";

  Set<String> extractDescriptions<T>(
    List<T>? entryList,
    String? Function(T) getLanguageName,
    String? Function(T) getFlavorText,
  ) {
    if (entryList == null || entryList.isEmpty) return {};

    return entryList
        .where((entry) => getLanguageName(entry) == targetLanguage)
        .map((entry) {
          final text = getFlavorText(entry);
          return text?.replaceAll(RegExp(r'[\n\f]'), ' ') ?? '';
        })
        .where((text) => text.isNotEmpty)
        .toSet();
  }

  final pokemonDescriptions = extractDescriptions<FlavorTextEntry>(
    entries,
    (entry) => entry.language?.name,
    (entry) => entry.flavorText,
  );

  final moveDescriptions = extractDescriptions<FlavorTextEntryMove>(
    entriesMove,
    (entry) => entry.language?.name,
    (entry) => entry.flavorText,
  );

  final allDescriptions = {...pokemonDescriptions, ...moveDescriptions};

  return allDescriptions.isNotEmpty
      ? allDescriptions.join(" ")
      : defaultMessage;
}
