class DeleteMilkResponse {
  int status;
  String message;

  DeleteMilkResponse({
      this.status, 
      this.message});

  DeleteMilkResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}