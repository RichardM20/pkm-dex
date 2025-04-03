import 'package:poke_api/src/models/pokemon_model.dart';

String getSprite({Sprites? sprites, bool? animated}) {
  if (sprites == null) return '';

  if (animated == true) {
    return sprites.versions?.generationV?.blackWhite?.animated?.frontDefault ??
        sprites.other?.dreamWorld?.frontDefault ??
        sprites.frontDefault ??
        '';
  }

  return sprites.other?.dreamWorld?.frontDefault ?? sprites.frontDefault ?? '';
}
