class UpdateWeigResponse {
  int status;
  Data data;
  String message;

  UpdateWeigResponse({
      this.status, 
      this.data, 
      this.message});

  UpdateWeigResponse.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data.toJson();
    }
    map['message'] = message;
    return map;
  }

}

class Data {
  String userId;
  String weighing;

  Data({
      this.userId, 
      this.weighing});

  Data.fromJson(dynamic json) {
    userId = json['user_id'];
    weighing = json['weighing'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['user_id'] = userId;
    map['weighing'] = weighing;
    return map;
  }

}