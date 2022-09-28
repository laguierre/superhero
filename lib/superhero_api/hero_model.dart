class HeroInfo {
  HeroInfo({
    required this.id,
    required this.name,
    required this.slug,
    required this.powerstats,
    required this.appearance,
    required this.biography,
    required this.work,
    required this.connections,
    required this.images,
  });

  int id;
  String name;
  String slug;
  Powerstats powerstats;
  Appearance appearance;
  Biography biography;
  Work work;
  Connections connections;
  Images images;

  factory HeroInfo.fromJson(Map<String, dynamic> json) => HeroInfo(
    id: json["id"] ,
    name: json["name"],
    slug: json["slug"],
    powerstats: Powerstats.fromJson(json["powerstats"]),
    appearance: Appearance.fromJson(json["appearance"]),
    biography: Biography.fromJson(json["biography"]),
    work: Work.fromJson(json["work"]),
    connections: Connections.fromJson(json["connections"]),
    images: Images.fromJson(json["images"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "powerstats": powerstats == null ? null : powerstats.toJson(),
    "appearance": appearance == null ? null : appearance.toJson(),
    "biography": biography == null ? null : biography.toJson(),
    "work": work == null ? null : work.toJson(),
    "connections": connections == null ? null : connections.toJson(),
    "images": images == null ? null : images.toJson(),
  };
}

 class Appearance {
  Appearance({
    required this.gender,
    required this.race,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
  });

  String gender;
  String race;
  List<dynamic> height;
  List<dynamic> weight;
  String eyeColor;
  String hairColor;

  factory Appearance.fromJson(Map<String, dynamic> json) => Appearance(
    gender: json["gender"] == null ? '' : json["gender"],
    race: json["race"] == null ? '' : json["race"],
    height: json["height"] == null ? [] : List<dynamic>.from(json["height"].map((x) => x)),
    weight: json["weight"] == null ? [] : List<dynamic>.from(json["weight"].map((x) => x)),
    eyeColor: json["eyeColor"] == null ? null : json["eyeColor"],
    hairColor: json["hairColor"] == null ? null : json["hairColor"],
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "race": race,
    "height": List<dynamic>.from(height.map((x) => x)),
    "weight": List<dynamic>.from(weight.map((x) => x)),
    "eyeColor": eyeColor,
    "hairColor": hairColor,
  };
}

class Biography {
  Biography({
    required this.fullName,
    required this.alterEgos,
    required this.aliases,
    required this.placeOfBirth,
    required this.firstAppearance,
    required this.publisher,
    required this.alignment,
  });

  String fullName;
  String alterEgos;
  List<String> aliases;
  String placeOfBirth;
  String firstAppearance;
  String publisher;
  String alignment;

  factory Biography.fromJson(Map<String, dynamic> json) => Biography(
    fullName: json["fullName"],
    alterEgos: json["alterEgos"],
    aliases: List<String>.from(json["aliases"].map((x) => x)),
    placeOfBirth: json["placeOfBirth"],
    firstAppearance: json["firstAppearance"],
    publisher: json["publisher"] == null ? "" : json["publisher"],
    alignment: json["alignment"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "alterEgos": alterEgos,
    "aliases": aliases == null ? null : List<dynamic>.from(aliases.map((x) => x)),
    "placeOfBirth": placeOfBirth,
    "firstAppearance": firstAppearance,
    "publisher": publisher,
    "alignment": alignment,
  };
}

class Connections {
  Connections({
    required this.groupAffiliation,
    required this.relatives,
  });

  String groupAffiliation;
  String relatives;

  factory Connections.fromJson(Map<String, dynamic> json) => Connections(
    groupAffiliation: json["groupAffiliation"],
    relatives: json["relatives"],
  );

  Map<String, dynamic> toJson() => {
    "groupAffiliation": groupAffiliation,
    "relatives": relatives,
  };
}

class Images {
  Images({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
  });

  String xs;
  String sm;
  String md;
  String lg;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    xs: json["xs"],
    sm: json["sm"],
    md: json["md"],
    lg: json["lg"],
  );

  Map<String, dynamic> toJson() => {
    "xs": xs,
    "sm": sm,
    "md": md,
    "lg": lg,
  };
}

class Powerstats {
  Powerstats({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  int intelligence;
  int strength;
  int speed;
  int durability;
  int power;
  int combat;

  factory Powerstats.fromJson(Map<String, dynamic> json) => Powerstats(
    intelligence: json["intelligence"],
    strength: json["strength"],
    speed: json["speed"],
    durability: json["durability"],
    power: json["power"],
    combat: json["combat"],
  );

  Map<String, dynamic> toJson() => {
    "intelligence": intelligence,
    "strength": strength,
    "speed": speed,
    "durability": durability,
    "power": power,
    "combat": combat,
  };
}

class Work {
  Work({
    required this.occupation,
    required this.base,
  });

  String occupation;
  String base;

  factory Work.fromJson(Map<String, dynamic> json) => Work(
    occupation: json["occupation"],
    base: json["base"],
  );

  Map<String, dynamic> toJson() => {
    "occupation": occupation,
    "base": base,
  };
}
