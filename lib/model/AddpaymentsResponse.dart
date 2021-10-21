class AddpaymentsResponse {
  int status;
  Data data;
  String message;

  AddpaymentsResponse({
      this.status, 
      this.data, 
      this.message});

  AddpaymentsResponse.fromJson(dynamic json) {
    status = json["status"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    if (data != null) {
      map["data"] = data.toJson();
    }
    map["message"] = message;
    return map;
  }

}

class Data {
  String vendorCode;
  String vendorName;
  String date;
  String billNumber;
  String notes;
  String amount;
  String userId;
  String updatedAt;
  String createdAt;
  int id;

  Data({
      this.vendorCode, 
      this.vendorName, 
      this.date, 
      this.billNumber, 
      this.notes, 
      this.amount, 
      this.userId, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  Data.fromJson(dynamic json) {
    vendorCode = json["vendor_code"];
    vendorName = json["vendor_name"];
    date = json["date"];
    billNumber = json["bill_number"];
    notes = json["notes"];
    amount = json["amount"];
    userId = json["user_id"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["vendor_code"] = vendorCode;
    map["vendor_name"] = vendorName;
    map["date"] = date;
    map["bill_number"] = billNumber;
    map["notes"] = notes;
    map["amount"] = amount;
    map["user_id"] = userId;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    map["id"] = id;
    return map;
  }

}