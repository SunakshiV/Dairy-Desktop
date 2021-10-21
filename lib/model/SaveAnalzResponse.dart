class SaveAnalzResponse {
  int status;
  Data data;
  String message;

  SaveAnalzResponse({
      this.status, 
      this.data, 
      this.message});

  SaveAnalzResponse.fromJson(dynamic json) {
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
  String analyzer;
  String userId;
  String updatedAt;
  String createdAt;
  int id;

  Data({
      this.analyzer, 
      this.userId, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  Data.fromJson(dynamic json) {
    analyzer = json['analyzer'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['analyzer'] = analyzer;
    map['user_id'] = userId;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}