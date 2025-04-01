double getStatProgress(String? statName, int? statValue) {
  if (statName == null || statValue == null) {
    return 0.0;
  }

  const int maxHp = 255;
  const int maxAttack = 190;
  const int maxDefense = 250;
  const int maxSpAttack = 194;
  const int maxSpDefense = 250;
  const int maxSpeed = 200;
  const int catchRate = 100;

  const Map<String, int> maxStats = {
    'hp': maxHp,
    'attack': maxAttack,
    'defense': maxDefense,
    'special-attack': maxSpAttack,
    'special-defense': maxSpDefense,
    'speed': maxSpeed,
    'base-happiness': maxHp,
    'catch-rate': catchRate,
  };

  if (maxStats.containsKey(statName)) {
    int maxStatValue = maxStats[statName]!;
    return (statValue / maxStatValue);
  } else {
    return 0.0;
  }
}
