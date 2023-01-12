import 'app_version.model.dart';

class PodiContainer {
  final String? id, name, appContainerId;

  PodiContainer(this.id, this.appContainerId, this.name);
  @override
  String toString() => name!;
}

class AppContainer extends PodiContainer {
  final String? createdAt, updatedAt;
  final List<MallAppContainer>? mallAppContainers;
  final String? blockTitle, blockIcon, blockMessage;
  final List<String> blockPages;
  final bool? active, blocked;

  AppContainer.fromJson(Map<String, dynamic> json)
      : createdAt = json["createdAt"],
        updatedAt = json["updatedAt"],
        active = json["active"],
        blockIcon = json["blockIcon"],
        blockTitle = json["blockTitle"],
        blockMessage = json["blockMessage"],
        blocked = json["blocked"],
        blockPages = (json["blockPages"] as List?)?.map((p) => p.toString()).toList() ?? [],
        mallAppContainers =
            (json["mallAppContainers"] as List?)?.map((c) => MallAppContainer.fromJson(c)).toList(),
        super(json["appContainerId"], json["appContainerId"], json["name"]);

  Map<String, dynamic> toJson() => {
        "appContainerId": id,
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "active": active,
        "mallAppContainers": mallAppContainers?.map((c) => c.toJson()).toList(),
      };
}

class MallAppContainer extends PodiContainer {
  final String? mallId, appContainerId;
  final AppVersion version;
  final bool? show;
  MallAppContainer.fromJson(Map<String, dynamic> json)
      : mallId = json["mallId"],
        version = AppVersion(json['appVersion'] ?? "0"),
        appContainerId = json["appContainerId"],
        show = json["show"],
        super(json["mallAppContainerId"], json["appContainerId"], json["name"]);

  Map<String, dynamic> toJson() => {
        "mallAppContainerId": id,
        "appContainerId": appContainerId,
        "name": name,
        "mallId": mallId,
        "show": show,
      };
}
