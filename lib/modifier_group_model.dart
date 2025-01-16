class ModifierGroup {
  final int id;
  final String name;
  final String nameLocale;
  final String description;
  final String descriptionLocale;
  final String plu;
  final int min;
  final int max;
  final bool active;
  final int vendorId;

  ModifierGroup({
    required this.id,
    required this.name,
    required this.nameLocale,
    required this.description,
    required this.descriptionLocale,
    required this.plu,
    required this.min,
    required this.max,
    required this.active,
    required this.vendorId,
  });

  factory ModifierGroup.fromJson(Map<String, dynamic> json, int vendorId) {
    return ModifierGroup(
      id: json['id'],
      name: json['name'],
      nameLocale: json['name_locale'] ?? '',
      description: json['modifier_group_description'] ?? '',
      descriptionLocale: json['modifier_group_description_locale'] ?? '',
      plu: json['PLU'],
      min: json['min'],
      max: json['max'],
      active: json['active'],
      vendorId: json['vendorId'] ?? vendorId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "name_locale": nameLocale,
      "modifier_group_description": description,
      "modifier_group_description_locale": descriptionLocale,
      "PLU": plu,
      "min": min,
      "max": max,
      "active": active,
      "vendorId": vendorId,
    };
  }
}
