class GetAnalyzeResponse {
  int status;
  List<Data> data;
  String message;

  GetAnalyzeResponse({
      this.status, 
      this.data, 
      this.message});

  GetAnalyzeResponse.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}

class Data {
  int id;
  String name;
  String fat;
  String clr;
  String snf;
  String cattle;
  String userId;
  String createdAt;
  String updatedAt;

  Data({
      this.id, 
      this.name, 
      this.fat, 
      this.clr, 
      this.snf, 
      this.cattle, 
      this.userId, 
      this.createdAt, 
      this.updatedAt});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    fat = json['fat'];
    clr = json['clr'];
    snf = json['snf'];
    cattle = json['cattle'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['fat'] = fat;
    map['clr'] = clr;
    map['snf'] = snf;
    map['cattle'] = cattle;
    map['user_id'] = userId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}