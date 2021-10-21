class AddItemSaleResponse {
  String message;
  int status;

  AddItemSaleResponse({
      this.message, 
      this.status});

  AddItemSaleResponse.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}