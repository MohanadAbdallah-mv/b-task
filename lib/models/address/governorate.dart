class Governorate {
  final String id;
  final String nameEn;
  final String nameAr;

  Governorate({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      id: json['id'] as String,
      nameEn: json['governorate_name_en'] as String,
      nameAr: json['governorate_name_ar'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'governorate_name_en': nameEn,
      'governorate_name_ar': nameAr,
    };
  }
}
