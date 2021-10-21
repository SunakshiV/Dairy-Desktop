class GetVendorNameResponse {
  int status;
  List<Data> data;
  String message;

  GetVendorNameResponse({
      this.status, 
      this.data, 
      this.message});

  GetVendorNameResponse.fromJson(dynamic json) {
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
  String vendorCode;
  String vendorName;
  String rate;

  Data({
      this.vendorCode, 
      this.vendorName, 
      this.rate});

  Data.fromJson(dynamic json) {
    vendorCode = json["vendor_code"];
    vendorName = json["vendor_name"];
    rate = json["rate"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["vendor_code"] = vendorCode;
    map["vendor_name"] = vendorName;
    map["rate"] = rate;
    return map;
  }

}