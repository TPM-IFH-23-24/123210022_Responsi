class DetailCharModel {
  String? name;
  String? title;
  String? vision;
  String? weapon;
  String? nation;
  String? affiliation;
  int? rarity;
  String? constellation;
  String? birthday;
  String? description;
  List<SkillTalents>? skillTalents;
  List<PassiveTalents>? passiveTalents;
  //List<Constellations>? constellations;
  String? visionKey;
  String? weaponType;

  DetailCharModel(
      {this.name,
        this.title,
        this.vision,
        this.weapon,
        this.nation,
        this.affiliation,
        this.rarity,
        this.constellation,
        this.birthday,
        this.description,
        this.skillTalents,
        this.passiveTalents,
        //this.constellations,
        this.visionKey,
        this.weaponType});

  DetailCharModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    vision = json['vision'];
    weapon = json['weapon'];
    nation = json['nation'];
    affiliation = json['affiliation'];
    rarity = json['rarity'];
    constellation = json['constellation'];
    birthday = json['birthday'];
    description = json['description'];
    if (json['skillTalents'] != null) {
      skillTalents = <SkillTalents>[];
      json['skillTalents'].forEach((v) {
        skillTalents!.add(new SkillTalents.fromJson(v));
      });
    }
    if (json['passiveTalents'] != null) {
      passiveTalents = <PassiveTalents>[];
      json['passiveTalents'].forEach((v) {
        passiveTalents!.add(new PassiveTalents.fromJson(v));
      });
    }
    if (json['constellations'] != null) {
      //constellations = <Constellations>[];
      json['constellations'].forEach((v) {
       // constellations!.add(new Constellations.fromJson(v));
      });
    }
    visionKey = json['vision_key'];
    weaponType = json['weapon_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['vision'] = this.vision;
    data['weapon'] = this.weapon;
    data['nation'] = this.nation;
    data['affiliation'] = this.affiliation;
    data['rarity'] = this.rarity;
    data['constellation'] = this.constellation;
    data['birthday'] = this.birthday;
    data['description'] = this.description;
    if (this.skillTalents != null) {
      data['skillTalents'] = this.skillTalents!.map((v) => v.toJson()).toList();
    }
    if (this.passiveTalents != null) {
      data['passiveTalents'] =
          this.passiveTalents!.map((v) => v.toJson()).toList();
    }
    // if (this.constellations != null) {
    //   data['constellations'] =
    //       this.constellations!.map((v) => v.toJson()).toList();
    // }
    data['vision_key'] = this.visionKey;
    data['weapon_type'] = this.weaponType;
    return data;
  }
}

class SkillTalents {
  String? name;
  String? unlock;
  String? description;
  String? type;

  SkillTalents({this.name, this.unlock, this.description, this.type});

  SkillTalents.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    unlock = json['unlock'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['unlock'] = this.unlock;
    data['description'] = this.description;
    data['type'] = this.type;
    return data;
  }
}

class PassiveTalents {
  String? name;
  String? unlock;
  String? description;
  int? level;

  PassiveTalents({this.name, this.unlock, this.description, this.level});

  PassiveTalents.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    unlock = json['unlock'];
    description = json['description'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['unlock'] = this.unlock;
    data['description'] = this.description;
    data['level'] = this.level;
    return data;
  }
}
