class AddAnalyzeResponse {
  int status;
  Data data;
  String message;

  AddAnalyzeResponse({
      this.status, 
      this.data, 
      this.message});

  AddAnalyzeResponse.fromJson(dynamic json) {
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
  String name;
  String fat;
  String clr;
  String snf;
  String userId;
  String updatedAt;
  String createdAt;
  int id;

  Data({
      this.name, 
      this.fat, 
      this.clr, 
      this.snf, 
      this.userId, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  Data.fromJson(dynamic json) {
    name = json['name'];
    fat = json['fat'];
    clr = json['clr'];
    snf = json['snf'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['fat'] = fat;
    map['clr'] = clr;
    map['snf'] = snf;
    map['user_id'] = userId;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}