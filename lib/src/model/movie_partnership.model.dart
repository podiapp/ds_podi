import 'dart:convert';

class MoviePartnershipCodes {
  String? code, urlKey;

  MoviePartnershipCodes.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        urlKey = json['urlKey'];

  toJson() => jsonEncode(
        {
          'code': this.code,
          'urlKey': this.urlKey,
        },
      );
}
