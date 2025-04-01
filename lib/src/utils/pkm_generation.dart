enum PokemonGeneration {
  first(151),
  second(251),
  third(386),
  fourth(493),
  fifth(649),
  sixth(721),
  seventh(809),
  eighth(898),
  ninth(1008);

  final int limit;
  const PokemonGeneration(this.limit);
}

abstract class PokemonGenerationUtils {
  static String getGenerationName(PokemonGeneration generation) {
    switch (generation) {
      case PokemonGeneration.first:
        return 'Kanto';
      case PokemonGeneration.second:
        return 'Johto';
      case PokemonGeneration.third:
        return 'Hoenn';
      case PokemonGeneration.fourth:
        return 'Sinnoh';
      case PokemonGeneration.fifth:
        return 'Unova';
      case PokemonGeneration.sixth:
        return 'Kalos';
      case PokemonGeneration.seventh:
        return 'Alola';
      case PokemonGeneration.eighth:
        return 'Galar';
      case PokemonGeneration.ninth:
        return 'Paldea';
    }
  }

  static int getGenerationLimit(PokemonGeneration generation) {
    switch (generation) {
      case PokemonGeneration.first:
        return 1;

      case PokemonGeneration.second:
        return PokemonGeneration.first.limit + 1;

      case PokemonGeneration.third:
        return PokemonGeneration.second.limit + 1;

      case PokemonGeneration.fourth:
        return PokemonGeneration.third.limit + 1;

      case PokemonGeneration.fifth:
        return PokemonGeneration.fourth.limit + 1;

      case PokemonGeneration.sixth:
        return PokemonGeneration.fifth.limit + 1;

      case PokemonGeneration.seventh:
        return PokemonGeneration.sixth.limit + 1;

      case PokemonGeneration.eighth:
        return PokemonGeneration.seventh.limit + 1;

      case PokemonGeneration.ninth:
        return PokemonGeneration.eighth.limit + 1;
    }
  }

  static int getGenerations() {
    return PokemonGeneration.values.length;
  }

  static List<String> getGenerationsNames() {
    return PokemonGeneration.values.map((e) => getGenerationName(e)).toList();
  }
}
