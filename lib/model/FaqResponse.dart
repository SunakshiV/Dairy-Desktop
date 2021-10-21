class FaqResponse {
  int status;
  Data data;
  String message;

  FaqResponse({
      this.status, 
      this.data, 
      this.message});

  FaqResponse.fromJson(dynamic json) {
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
  String note;
  String userId;
  String updatedAt;
  String createdAt;
  int id;

  Data({
      this.note, 
      this.userId, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  Data.fromJson(dynamic json) {
    note = json['note'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['note'] = note;
    map['user_id'] = userId;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}