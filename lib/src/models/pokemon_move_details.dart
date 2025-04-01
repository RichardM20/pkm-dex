// To parse this JSON data, do
//
//     final moveDetails = moveDetailsFromJson(jsonString);

import 'dart:convert';

PkmMoveDetails moveDetailsFromJson(String str) =>
    PkmMoveDetails.fromJson(json.decode(str));

String moveDetailsToJson(PkmMoveDetails data) => json.encode(data.toJson());

class PkmMoveDetails {
  final int? accuracy;
  final ContestCombos? contestCombos;
  final ContestEffect? contestEffect;
  final ContestType? contestType;
  final ContestType? damageClass;
  final dynamic effectChance;
  final List<dynamic>? effectChanges;
  final List<EffectEntry>? effectEntries;
  final List<FlavorTextEntryMove>? flavorTextEntries;
  final ContestType? generation;
  final int? id;
  final List<ContestType>? learnedByPokemon;
  final List<dynamic>? machines;
  final Meta? meta;
  final String? name;
  final List<Name>? names;
  final List<dynamic>? pastValues;
  final int? power;
  final int? pp;
  final int? priority;
  final List<dynamic>? statChanges;
  final ContestEffect? superContestEffect;
  final ContestType? target;
  final ContestType? type;

  PkmMoveDetails({
    this.accuracy,
    this.contestCombos,
    this.contestEffect,
    this.contestType,
    this.damageClass,
    this.effectChance,
    this.effectChanges,
    this.effectEntries,
    this.flavorTextEntries,
    this.generation,
    this.id,
    this.learnedByPokemon,
    this.machines,
    this.meta,
    this.name,
    this.names,
    this.pastValues,
    this.power,
    this.pp,
    this.priority,
    this.statChanges,
    this.superContestEffect,
    this.target,
    this.type,
  });

  factory PkmMoveDetails.fromJson(Map<String, dynamic> json) => PkmMoveDetails(
    accuracy: json["accuracy"],
    contestCombos:
        json["contest_combos"] == null
            ? null
            : ContestCombos.fromJson(json["contest_combos"]),
    contestEffect:
        json["contest_effect"] == null
            ? null
            : ContestEffect.fromJson(json["contest_effect"]),
    contestType:
        json["contest_type"] == null
            ? null
            : ContestType.fromJson(json["contest_type"]),
    damageClass:
        json["damage_class"] == null
            ? null
            : ContestType.fromJson(json["damage_class"]),
    effectChance: json["effect_chance"],
    effectChanges:
        json["effect_changes"] == null
            ? []
            : List<dynamic>.from(json["effect_changes"]!.map((x) => x)),
    effectEntries:
        json["effect_entries"] == null
            ? []
            : List<EffectEntry>.from(
              json["effect_entries"]!.map((x) => EffectEntry.fromJson(x)),
            ),
    flavorTextEntries:
        json["flavor_text_entries"] == null
            ? []
            : List<FlavorTextEntryMove>.from(
              json["flavor_text_entries"]!.map(
                (x) => FlavorTextEntryMove.fromJson(x),
              ),
            ),
    generation:
        json["generation"] == null
            ? null
            : ContestType.fromJson(json["generation"]),
    id: json["id"],
    learnedByPokemon:
        json["learned_by_pokemon"] == null
            ? []
            : List<ContestType>.from(
              json["learned_by_pokemon"]!.map((x) => ContestType.fromJson(x)),
            ),
    machines:
        json["machines"] == null
            ? []
            : List<dynamic>.from(json["machines"]!.map((x) => x)),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    name: json["name"],
    names:
        json["names"] == null
            ? []
            : List<Name>.from(json["names"]!.map((x) => Name.fromJson(x))),
    pastValues:
        json["past_values"] == null
            ? []
            : List<dynamic>.from(json["past_values"]!.map((x) => x)),
    power: json["power"],
    pp: json["pp"],
    priority: json["priority"],
    statChanges:
        json["stat_changes"] == null
            ? []
            : List<dynamic>.from(json["stat_changes"]!.map((x) => x)),
    superContestEffect:
        json["super_contest_effect"] == null
            ? null
            : ContestEffect.fromJson(json["super_contest_effect"]),
    target:
        json["target"] == null ? null : ContestType.fromJson(json["target"]),
    type: json["type"] == null ? null : ContestType.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "accuracy": accuracy,
    "contest_combos": contestCombos?.toJson(),
    "contest_effect": contestEffect?.toJson(),
    "contest_type": contestType?.toJson(),
    "damage_class": damageClass?.toJson(),
    "effect_chance": effectChance,
    "effect_changes":
        effectChanges == null
            ? []
            : List<dynamic>.from(effectChanges!.map((x) => x)),
    "effect_entries":
        effectEntries == null
            ? []
            : List<dynamic>.from(effectEntries!.map((x) => x.toJson())),
    "flavor_text_entries":
        flavorTextEntries == null
            ? []
            : List<dynamic>.from(flavorTextEntries!.map((x) => x.toJson())),
    "generation": generation?.toJson(),
    "id": id,
    "learned_by_pokemon":
        learnedByPokemon == null
            ? []
            : List<dynamic>.from(learnedByPokemon!.map((x) => x.toJson())),
    "machines":
        machines == null ? [] : List<dynamic>.from(machines!.map((x) => x)),
    "meta": meta?.toJson(),
    "name": name,
    "names":
        names == null ? [] : List<dynamic>.from(names!.map((x) => x.toJson())),
    "past_values":
        pastValues == null ? [] : List<dynamic>.from(pastValues!.map((x) => x)),
    "power": power,
    "pp": pp,
    "priority": priority,
    "stat_changes":
        statChanges == null
            ? []
            : List<dynamic>.from(statChanges!.map((x) => x)),
    "super_contest_effect": superContestEffect?.toJson(),
    "target": target?.toJson(),
    "type": type?.toJson(),
  };
}

class ContestCombos {
  final Normal? normal;
  final Normal? contestCombosSuper;

  ContestCombos({this.normal, this.contestCombosSuper});

  factory ContestCombos.fromJson(Map<String, dynamic> json) => ContestCombos(
    normal: json["normal"] == null ? null : Normal.fromJson(json["normal"]),
    contestCombosSuper:
        json["super"] == null ? null : Normal.fromJson(json["super"]),
  );

  Map<String, dynamic> toJson() => {
    "normal": normal?.toJson(),
    "super": contestCombosSuper?.toJson(),
  };
}

class Normal {
  final dynamic useAfter;
  final List<ContestType>? useBefore;

  Normal({this.useAfter, this.useBefore});

  factory Normal.fromJson(Map<String, dynamic> json) => Normal(
    useAfter: json["use_after"],
    useBefore:
        json["use_before"] == null
            ? []
            : List<ContestType>.from(
              json["use_before"]!.map((x) => ContestType.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "use_after": useAfter,
    "use_before":
        useBefore == null
            ? []
            : List<dynamic>.from(useBefore!.map((x) => x.toJson())),
  };
}

class ContestType {
  final String? name;
  final String? url;

  ContestType({this.name, this.url});

  factory ContestType.fromJson(Map<String, dynamic> json) =>
      ContestType(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}

class ContestEffect {
  final String? url;

  ContestEffect({this.url});

  factory ContestEffect.fromJson(Map<String, dynamic> json) =>
      ContestEffect(url: json["url"]);

  Map<String, dynamic> toJson() => {"url": url};
}

class EffectEntry {
  final String? effect;
  final ContestType? language;
  final String? shortEffect;

  EffectEntry({this.effect, this.language, this.shortEffect});

  factory EffectEntry.fromJson(Map<String, dynamic> json) => EffectEntry(
    effect: json["effect"],
    language:
        json["language"] == null
            ? null
            : ContestType.fromJson(json["language"]),
    shortEffect: json["short_effect"],
  );

  Map<String, dynamic> toJson() => {
    "effect": effect,
    "language": language?.toJson(),
    "short_effect": shortEffect,
  };
}

class FlavorTextEntryMove {
  final String? flavorText;
  final ContestType? language;
  final ContestType? versionGroup;

  FlavorTextEntryMove({this.flavorText, this.language, this.versionGroup});

  factory FlavorTextEntryMove.fromJson(Map<String, dynamic> json) =>
      FlavorTextEntryMove(
        flavorText: json["flavor_text"],
        language:
            json["language"] == null
                ? null
                : ContestType.fromJson(json["language"]),
        versionGroup:
            json["version_group"] == null
                ? null
                : ContestType.fromJson(json["version_group"]),
      );

  Map<String, dynamic> toJson() => {
    "flavor_text": flavorText,
    "language": language?.toJson(),
    "version_group": versionGroup?.toJson(),
  };
}

class Meta {
  final ContestType? ailment;
  final int? ailmentChance;
  final ContestType? category;
  final int? critRate;
  final int? drain;
  final int? flinchChance;
  final int? healing;
  final dynamic maxHits;
  final dynamic maxTurns;
  final dynamic minHits;
  final dynamic minTurns;
  final int? statChance;

  Meta({
    this.ailment,
    this.ailmentChance,
    this.category,
    this.critRate,
    this.drain,
    this.flinchChance,
    this.healing,
    this.maxHits,
    this.maxTurns,
    this.minHits,
    this.minTurns,
    this.statChance,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    ailment:
        json["ailment"] == null ? null : ContestType.fromJson(json["ailment"]),
    ailmentChance: json["ailment_chance"],
    category:
        json["category"] == null
            ? null
            : ContestType.fromJson(json["category"]),
    critRate: json["crit_rate"],
    drain: json["drain"],
    flinchChance: json["flinch_chance"],
    healing: json["healing"],
    maxHits: json["max_hits"],
    maxTurns: json["max_turns"],
    minHits: json["min_hits"],
    minTurns: json["min_turns"],
    statChance: json["stat_chance"],
  );

  Map<String, dynamic> toJson() => {
    "ailment": ailment?.toJson(),
    "ailment_chance": ailmentChance,
    "category": category?.toJson(),
    "crit_rate": critRate,
    "drain": drain,
    "flinch_chance": flinchChance,
    "healing": healing,
    "max_hits": maxHits,
    "max_turns": maxTurns,
    "min_hits": minHits,
    "min_turns": minTurns,
    "stat_chance": statChance,
  };
}

class Name {
  final ContestType? language;
  final String? name;

  Name({this.language, this.name});

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    language:
        json["language"] == null
            ? null
            : ContestType.fromJson(json["language"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "language": language?.toJson(),
    "name": name,
  };
}
