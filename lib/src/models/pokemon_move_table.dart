class PokemonMove {
  final String? name;
  final String? url;
  final String method;
  final int level;
  final String displayLevel;

  PokemonMove({
    required this.name,
    this.url,
    required this.method,
    required this.level,
    required this.displayLevel,
  });

  factory PokemonMove.fromMoveData(dynamic move) {
    final data = move.versionGroupDetails!.first;

    final level =
        (data.moveLearnMethod?.name?.toLowerCase() != 'level-up' &&
                (data.levelLearnedAt == null || data.levelLearnedAt == 0))
            ? 'any'
            : data.levelLearnedAt?.toString();

    return PokemonMove(
      name: move.move?.name,
      url: move.move?.url,
      method: data.moveLearnMethod?.name ?? '',
      level: data.levelLearnedAt ?? 0,
      displayLevel: level ?? 'any',
    );
  }
}
