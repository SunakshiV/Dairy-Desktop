class DeleteMilkSaleResponse {
  int resCode;
  bool success;
  String message;

  DeleteMilkSaleResponse({this.resCode, this.success, this.message});

  DeleteMilkSaleResponse.fromJson(Map<String, dynamic> json) {
    resCode = json['resCode'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resCode'] = this.resCode;
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}