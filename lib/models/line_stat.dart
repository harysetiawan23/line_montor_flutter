import 'package:firebase_database/firebase_database.dart';

class LineStat {
  String key;
  String createdAt;
  int diameter;
  int distance;
  String end;
  int endNodeId;
  int endNodeLiters;
  String endNodeSN;
  double flowRatio;
  int id;
  double lastEndNodeFlow;
  double lastEndNodePressure;
  double lastStartNodeFlow;
  double lastStartNodePressure;
  String manufacture;
  String name;
  double pressureRatio;
  String start;
  int startNodeId;
  String startNodeSN;
  int thicknes;
  String timestamp;
  String updatedAt;
  int userId;

  LineStat(
      {this.createdAt,
        this.diameter,
        this.distance,
        this.end,
        this.endNodeId,
        this.endNodeLiters,
        this.endNodeSN,
        this.flowRatio,
        this.id,
        this.lastEndNodeFlow,
        this.lastEndNodePressure,
        this.lastStartNodeFlow,
        this.lastStartNodePressure,
        this.manufacture,
        this.name,
        this.pressureRatio,
        this.start,
        this.startNodeId,
        this.startNodeSN,
        this.thicknes,
        this.timestamp,
        this.updatedAt,
        this.userId});

  LineStat.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    diameter = json['diameter'];
    distance = json['distance'];
    end = json['end'];
    endNodeId = json['endNodeId'];
    endNodeLiters = json['endNodeLiters'];
    endNodeSN = json['endNodeSN'];
    endNodeId = json['end_node_id'];
    flowRatio = json['flowRatio'];
    id = json['id'];
    lastEndNodeFlow = json['lastEndNodeFlow'];
    lastEndNodePressure = json['lastEndNodePressure'];
    lastStartNodeFlow = json['lastStartNodeFlow'];
    lastStartNodePressure = json['lastStartNodePressure'];
    manufacture = json['manufacture'];
    name = json['name'];
    pressureRatio = json['pressureRatio'];
    start = json['start'];
    startNodeId = json['startNodeId'];
    startNodeSN = json['startNodeSN'];
    startNodeId = json['start_node_id'];
    thicknes = json['thicknes'];
    timestamp = json['timestamp'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['diameter'] = this.diameter;
    data['distance'] = this.distance;
    data['end'] = this.end;
    data['endNodeId'] = this.endNodeId;
    data['endNodeLiters'] = this.endNodeLiters;
    data['endNodeSN'] = this.endNodeSN;
    data['end_node_id'] = this.endNodeId;
    data['flowRatio'] = this.flowRatio;
    data['id'] = this.id;
    data['lastEndNodeFlow'] = this.lastEndNodeFlow;
    data['lastEndNodePressure'] = this.lastEndNodePressure;
    data['lastStartNodeFlow'] = this.lastStartNodeFlow;
    data['lastStartNodePressure'] = this.lastStartNodePressure;
    data['manufacture'] = this.manufacture;
    data['name'] = this.name;
    data['pressureRatio'] = this.pressureRatio;
    data['start'] = this.start;
    data['startNodeId'] = this.startNodeId;
    data['startNodeSN'] = this.startNodeSN;
    data['start_node_id'] = this.startNodeId;
    data['thicknes'] = this.thicknes;
    data['timestamp'] = this.timestamp;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    return data;
  }

  LineStat.fromSnapshot(DataSnapshot snapshot) {
    key = snapshot.key;
    createdAt = snapshot.value['created_at'];
    diameter = snapshot.value['diameter'];
    distance = snapshot.value['distance'];
    end = snapshot.value['end'];
    endNodeId = snapshot.value['endNodeId'];
    endNodeLiters = snapshot.value['endNodeLiters'];
    endNodeSN = snapshot.value['endNodeSN'];
    flowRatio = snapshot.value['flowRatio'];
    id = snapshot.value['id'];
    lastEndNodeFlow = snapshot.value['lastEndNodeFlow'];
    lastEndNodePressure = snapshot.value['lastEndNodePressure'];
    lastStartNodeFlow = snapshot.value['lastStartNodeFlow'];
    lastStartNodePressure = snapshot.value['lastStartNodePressure'];
    manufacture = snapshot.value['manufacture'];
    name = snapshot.value['name'];
    pressureRatio = snapshot.value['pressureRatio'];
    start = snapshot.value['start'];
    startNodeId = snapshot.value['startNodeId'];
    startNodeSN = snapshot.value['startNodeSN'];
    thicknes = snapshot.value['thicknes'];
    timestamp = snapshot.value['timestamp'];
    updatedAt = snapshot.value['updated_at'];
    userId = snapshot.value['user_id'];
  }

}

abstract class LineStatRepository {
  Future<List<LineStat>> fetchLineStatFromFirebase();
}



