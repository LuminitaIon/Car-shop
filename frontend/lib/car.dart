class Car {
  final int? id;
  final String? model;
  final String? brandCode;
  final int? year;
  final int? combustibil;
  final int? carType;
  final int? price;
  final String? gearboxCode;
  final int? km;
  final int? power;
  final int? color;

  Car(
  { this.id,
      this.model,
      this.brandCode,
      this.year,
      this.combustibil,
      this.carType,
      this.price,
      this.gearboxCode,
      this.km,
      this.power,
      this.color});

  static fromJson(Map<dynamic, dynamic> json) {
    return Car(id: json['ID_CAR'],
                model: json['MODEL_NAME'],
                brandCode: json['BRAND_CODE'],
                year: json['CAR_YEAR'],
                combustibil: json['COMBUSTIBIL_ID'],
                carType: json['CAR_TYPE_ID'],
                price: json['PRICE'],
                gearboxCode: json['GEARBOX_CODE'],
                km: json['NO_KM'],
                power: json['ENGINE_POWER'],
                color: json['COLOR_CODE']);

  }
}
