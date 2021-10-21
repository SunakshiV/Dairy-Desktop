class UpdateWeightResponse {
  int status;
  Data data;
  String message;

  UpdateWeightResponse({
      this.status, 
      this.data, 
      this.message});

  UpdateWeightResponse.fromJson(dynamic json) {
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
  String id;
  String weight;

  Data({
      this.id, 
      this.weight});

  Data.fromJson(dynamic json) {
    id = json['id'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['weight'] = weight;
    return map;
  }

}