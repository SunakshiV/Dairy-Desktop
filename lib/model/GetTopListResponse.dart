class GetTopListResponse {
  int status;
  List<Data> data;
  String message;

  GetTopListResponse({
      this.status, 
      this.data, 
      this.message});

  GetTopListResponse.fromJson(dynamic json) {
    status = json["status"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    return map;
  }

}

class Data {
  int id;
  String points;
  String createdAt;
  String updatedAt;

  Data({
      this.id, 
      this.points, 
      this.createdAt, 
      this.updatedAt});

  Data.fromJson(dynamic json) {
    id = json["id"];
    points = json["points"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["points"] = points;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}