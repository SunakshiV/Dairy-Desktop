class EditDispatchResponse {
  int status;
  Data data;
  String message;

  EditDispatchResponse({
      this.status, 
      this.data, 
      this.message});

  EditDispatchResponse.fromJson(dynamic json) {
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
  String time;
  String dairyCode;
  String avgFat;
  String avgSnf;
  String avgClr;
  String rate;
  String weight;
  String noOfCans;
  String amount;
  String quantity;
  String id;

  Data({
      this.date, 
      this.time, 
      this.dairyCode, 
      this.avgFat, 
      this.avgSnf, 
      this.avgClr, 
      this.rate, 
      this.weight, 
      this.noOfCans, 
      this.amount, 
      this.quantity, 
      this.id});

  Data.fromJson(dynamic json) {
    date = json["date"];
    time = json["time"];
    dairyCode = json["dairy_code"];
    avgFat = json["avg_fat"];
    avgSnf = json["avg_snf"];
    avgClr = json["avg_clr"];
    rate = json["rate"];
    weight = json["weight"];
    noOfCans = json["no_of_cans"];
    amount = json["amount"];
    quantity = json["quantity"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = date;
    map["time"] = time;
    map["dairy_code"] = dairyCode;
    map["avg_fat"] = avgFat;
    map["avg_snf"] = avgSnf;
    map["avg_clr"] = avgClr;
    map["rate"] = rate;
    map["weight"] = weight;
    map["no_of_cans"] = noOfCans;
    map["amount"] = amount;
    map["quantity"] = quantity;
    map["id"] = id;
    return map;
  }

}