class Brand{
  final String? brandCode;
  final String? brandName;

  Brand({this.brandCode, this.brandName});
  static fromJson(Map<dynamic, dynamic> json) {
    return Brand(brandCode: json['BRAND_CODE'],
        brandName: json['BRAND_NAME']);

  }
}