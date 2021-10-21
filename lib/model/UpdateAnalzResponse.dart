class UpdateAnalzResponse {
  int status;
  Data data;
  String message;

  UpdateAnalzResponse({
      this.status, 
      this.data, 
      this.message});

  UpdateAnalzResponse.fromJson(dynamic json) {
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
  String analyzer;

  Data({
      this.userId, 
      this.analyzer});

  Data.fromJson(dynamic json) {
    userId = json['user_id'];
    analyzer = json['analyzer'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['user_id'] = userId;
    map['analyzer'] = analyzer;
    return map;
  }

}