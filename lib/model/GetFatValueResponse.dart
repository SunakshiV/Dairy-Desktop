class GetFatValueResponse {
  int status;
  String data;
  String message;

  GetFatValueResponse({
      this.status, 
      this.data, 
      this.message});

  GetFatValueResponse.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    map['data'] = data;
    map['message'] = message;
    return map;
  }

}