class Facility {
  String? description, subtitle, title, facilityId;
  late FacilityType type;

  Facility.fromJson(Map<String, dynamic> json) {
    description = json["description"];
    subtitle = json["subtitle"];
    title = json["title"];
    facilityId = json["facilityId"];
    type = FacilityType.fromJson(json["facilityType"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "subtitle": subtitle,
      "title": title,
      "facilityId": facilityId,
      "facilityType": type.toJson(),
    };
  }
}

class FacilityType {
  String? icon, title, facilityId;

  FacilityType.fromJson(Map<String, dynamic> json) {
    icon = json["icon"];
    facilityId = json["facilityId"];
    title = json["title"];
  }
  Map<String, dynamic> toJson() {
    return {"icon": icon, "title": title};
  }
}
