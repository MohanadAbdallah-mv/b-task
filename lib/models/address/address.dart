class Address {
  Address({
    required this.apartment,
    required this.floor,
    required this.building,
    required this.streetName,
    required this.areaName,
    required this.cityName,
    required this.landMark,
  });

  late String apartment;
  late String floor;
  late String building;
  late String streetName;
  late String areaName;
  late String cityName;
  late String landMark;

  String get fullAddressString {
    return '$building $streetName Street $landMark. $areaName, $cityName  Floor $floor Apartment $apartment';
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      apartment: json["apartment"] as String,
      floor: json["floor"] as String,
      building: json["building"] as String,
      streetName: json["streetName"] as String,
      areaName: json["areaName"] as String,
      cityName: json["cityName"] as String,
      landMark: json["landMark"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "apartment": apartment,
      "floor": floor,
      "building": building,
      "streetName": streetName,
      "areaName": areaName,
      "cityName": cityName,
      "landMark": landMark,
    };
  }
}
