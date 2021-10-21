class ChangePass {
  int status;
  String message;

  ChangePass({
      this.status, 
      this.message});

  ChangePass.fromJson(dynamic json) {
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