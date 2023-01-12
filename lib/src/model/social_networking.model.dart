import 'enums/social_network.enum.dart';

class SocialNetworking {
  String? id, url;
  SocialNetwork? type;
  SocialNetworking.fromJson(Map<String, dynamic> json) {
    id = json['mallSocialNetworkingId'];
    url = json['url'];
    type = SocialNetwork.values[json['type']];
  }

  Map<String, dynamic> toJson() {
    return {"mallSocialNetworkingId": id, "url": url, "type": type};
  }
}
