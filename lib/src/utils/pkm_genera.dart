import 'package:poke_api/src/models/pokemon_detail_model.dart';

String getGenera(List<Genus>? genera) {
  if (genera == null || genera.isEmpty) {
    return '';
  }

  return genera.firstWhere((genus) => genus.language?.name == 'en').genus ?? '';
}
