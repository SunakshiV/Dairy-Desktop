class DeleteAdvanceRateResponse {
  int status;
  String message;

  DeleteAdvanceRateResponse({
      this.status, 
      this.message});

  DeleteAdvanceRateResponse.fromJson(dynamic json) {
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