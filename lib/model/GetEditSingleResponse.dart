class GetEditSingleResponse {
  int status;
  List<Data> data;
  String message;

  GetEditSingleResponse({
      this.status, 
      this.data, 
      this.message});

  GetEditSingleResponse.fromJson(dynamic json) {
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
  String userId;
  String createdAt;
  String updatedAt;

  Data({
      this.id, 
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
      this.userId, 
      this.createdAt, 
      this.updatedAt});

  Data.fromJson(dynamic json) {
    id = json["id"];
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
    userId = json["user_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
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
    map["user_id"] = userId;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}