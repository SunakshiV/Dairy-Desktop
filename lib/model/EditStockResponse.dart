class EditStockResponse {
  int status;
  Data data;
  String message;

  EditStockResponse({
      this.status, 
      this.data, 
      this.message});

  EditStockResponse.fromJson(dynamic json) {
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
  String date;
  String type;
  String vendorNumber;
  String vendorName;
  String quantity;
  String amount;
  String id;

  Data({
      this.date, 
      this.type, 
      this.vendorNumber, 
      this.vendorName, 
      this.quantity, 
      this.amount, 
      this.id});

  Data.fromJson(dynamic json) {
    date = json["date"];
    type = json["type"];
    vendorNumber = json["vendor_number"];
    vendorName = json["vendor_name"];
    quantity = json["quantity"];
    amount = json["amount"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = date;
    map["type"] = type;
    map["vendor_number"] = vendorNumber;
    map["vendor_name"] = vendorName;
    map["quantity"] = quantity;
    map["amount"] = amount;
    map["id"] = id;
    return map;
  }

}