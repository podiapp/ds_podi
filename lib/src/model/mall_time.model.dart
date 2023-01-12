import 'enums/day.enum.dart';
import 'enums/type.enum.dart';

class MallTimeOrganized {
  TimeType? type;
  List<MallTime> times;

  MallTimeOrganized(this.type, this.times) {
    times.sort((a, b) => a.day!.index.compareTo(b.day!.index));
  }
}

class MallTime {
  Day? day;
  TimeType? type;
  String? description;
  String? mallTimeId;

  MallTime({this.day, this.type, this.description, this.mallTimeId});

  MallTime.fromJson(Map<String, dynamic> json) {
    day = Day.values[json['day']];
    type = TimeType.values[json['type']];
    description = json['description'];
    mallTimeId = json['mallTimeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day!.index;
    data['type'] = this.type!.index;
    data['description'] = this.description;
    data['mallTimeId'] = this.mallTimeId;
    return data;
  }
}
