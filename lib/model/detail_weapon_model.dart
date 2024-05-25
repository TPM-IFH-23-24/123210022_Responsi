class DetailWeaponModel {
  String? name;
  String? type;
  int? rarity;
  int? baseAttack;
  String? subStat;
  String? passiveName;
  String? passiveDesc;
  String? location;
  String? ascensionMaterial;

  DetailWeaponModel(
      {this.name,
        this.type,
        this.rarity,
        this.baseAttack,
        this.subStat,
        this.passiveName,
        this.passiveDesc,
        this.location,
        this.ascensionMaterial});

  DetailWeaponModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    rarity = json['rarity'];
    baseAttack = json['baseAttack'];
    subStat = json['subStat'];
    passiveName = json['passiveName'];
    passiveDesc = json['passiveDesc'];
    location = json['location'];
    ascensionMaterial = json['ascensionMaterial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['rarity'] = this.rarity;
    data['baseAttack'] = this.baseAttack;
    data['subStat'] = this.subStat;
    data['passiveName'] = this.passiveName;
    data['passiveDesc'] = this.passiveDesc;
    data['location'] = this.location;
    data['ascensionMaterial'] = this.ascensionMaterial;
    return data;
  }
}
