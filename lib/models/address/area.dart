class Area {
  final String id;
  final String nameEn;
  final String nameAr;
  final String governorateId;

  Area({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.governorateId,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'] as String,
      nameEn: json['city_name_en'] as String,
      nameAr: json['city_name_ar'] as String,
      governorateId: json['governorate_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city_name_en': nameEn,
      'city_name_ar': nameAr,
      'governorate_id': governorateId,
    };
  }
}
