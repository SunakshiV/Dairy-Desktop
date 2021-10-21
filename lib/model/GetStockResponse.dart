class GetStockResponse {
  int status;
  List<Data> data;
  String message;

  GetStockResponse({
      this.status, 
      this.data, 
      this.message});

  GetStockResponse.fromJson(dynamic json) {
    status = json["status"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    return map;
  }

}

class Data {
  int id;
  String date;
  String type;
  String vendorNumber;
  String vendorName;
  String quantity;
  String amount;
  String userId;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  Data({
      this.id, 
      this.date, 
      this.type, 
      this.vendorNumber, 
      this.vendorName, 
      this.quantity, 
      this.amount, 
      this.userId, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt});

  Data.fromJson(dynamic json) {
    id = json["id"];
    date = json["date"];
    type = json["type"];
    vendorNumber = json["vendor_number"];
    vendorName = json["vendor_name"];
    quantity = json["quantity"];
    amount = json["amount"];
    userId = json["user_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["date"] = date;
    map["type"] = type;
    map["vendor_number"] = vendorNumber;
    map["vendor_name"] = vendorName;
    map["quantity"] = quantity;
    map["amount"] = amount;
    map["user_id"] = userId;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["deleted_at"] = deletedAt;
    return map;
  }

}