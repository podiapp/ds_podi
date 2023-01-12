import 'app_containers.dart';
import 'enums/type.enum.dart';
import 'mall_time.model.dart';

import 'facility.model.dart';
import 'movie_partnership.model.dart';
import 'social_networking.model.dart';

class Shopping {
  String? name,
      fantasyName,
      cnpj,
      imageUrl,
      phone,
      email,
      distance,
      distanceDescription,
      jobsLink;
  String? id, parkingLotId, zipzId;
  String? address, addressNumber, neighborhood, city, state, zipCode;
  String? zipzSpecialCategory, networkSsid;
  double? lat, lon;

  List<MoviePartnershipCodes> moviePartnerships = [];
  List<MallTimeOrganized>? mallTimes = [];
  List<SocialNetworking>? socialNetworkings = [];
  List<Facility>? facilities = [];
  List<MallAppContainer>? containers = [];

  Shopping({
    this.id,
    this.name,
    this.imageUrl,
    this.address,
    this.addressNumber,
    this.neighborhood,
    this.city,
    this.state,
    this.zipCode,
    this.phone,
    this.email,
    this.distance,
    this.distanceDescription,
    this.lat,
    this.lon,
    this.mallTimes,
  });

  Shopping.fromJson(Map<String, dynamic> json) {
    id = json['mallId'];
    name = json['businessName'];
    jobsLink = json['jobsLink'];
    fantasyName = json['fantasyName'];
    cnpj = json['cnpj'];
    imageUrl = json['photo'];
    address = json['address'];
    addressNumber = json['addressNumber'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    phone = json['phone'];
    email = json['email'];
    distance = json['distance'];
    parkingLotId = json['parkingLotId'];
    zipzId = json['zipzId'];
    networkSsid = json['networkSsid'];
    zipzSpecialCategory = json['zipzEspecialCategory'] ?? "";
    if (json['moviePartnershipCodes'] != null) {
      for (var c in json['moviePartnershipCodes'] as List? ?? [])
        moviePartnerships.add(MoviePartnershipCodes.fromJson(c));
    }
    distanceDescription = _handleDistanceDescription(json['distance']);
    lat = json['lat'];
    lon = json['lon'];
    if (json['mallTimes'] != null) {
      var times = <MallTime>[];
      json['mallTimes'].forEach((v) => times.add(new MallTime.fromJson(v)));
      var types = <TimeType?>[];
      for (var t in times) if (!types.contains(t.type)) types.add(t.type);
      mallTimes = [];
      for (var type in types)
        mallTimes!.add(MallTimeOrganized(
            type, times.where((t) => t.type == type).toList()));
      mallTimes!.sort((a, b) => a.type!.index.compareTo(b.type!.index));
    }
    socialNetworkings = (json['socialNetworkings'] ?? [])
        ?.map<SocialNetworking>((sn) => SocialNetworking.fromJson(sn))
        ?.toList();
    facilities = (json['facilities'] ?? [])
        ?.map<Facility>((f) => Facility.fromJson(f))
        ?.toList();
    containers = (json['mallAppContainers'] ?? [])
        ?.map<MallAppContainer>((c) => MallAppContainer.fromJson(c))
        ?.toList();
  }

  String? _handleDistanceDescription(String? meters) {
    if (meters == null) return null;

    double parsedMeters = double.parse(meters);

    if (parsedMeters > 1000)
      return "${(parsedMeters / 1000).round()} km";
    else
      return "${parsedMeters.round()} m";
  }
}
