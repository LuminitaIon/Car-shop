class CarType{
  final int? carTypeId;
  final String? carTypeName;

  CarType({this.carTypeId, this.carTypeName});
  static fromJson(Map<dynamic, dynamic> json) {
    return CarType(carTypeId: json['CAR_TYPE_ID'],
        carTypeName: json['CAR_TYPE_NAME']);

  }
}