class ColorCar{
  final int? colorCode;
  final String? colorName;

  ColorCar({this.colorCode, this.colorName});
  static fromJson(Map<dynamic, dynamic> json) {
    return ColorCar(colorCode: json['COLOR_CODE'],
        colorName: json['COLOR_NAME']);
  }
}