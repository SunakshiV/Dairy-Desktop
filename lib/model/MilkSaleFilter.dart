class MilkSaleFilter {
  int status;
  List<Data> data;
  String message;

  MilkSaleFilter({
      this.status, 
      this.data, 
      this.message});

  MilkSaleFilter.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}

class Data {
  int id;
  String date;
  String time;
  String shift;
  String cattleType;
  String fat;
  String vendorNumber;
  String vendorName;
  String weight;
  String rate;
  String amount;
  String weighing;
  String userId;
  dynamic createdAt;
  String updatedAt;

  Data({
      this.id, 
      this.date, 
      this.time, 
      this.shift, 
      this.cattleType, 
      this.fat, 
      this.vendorNumber, 
      this.vendorName, 
      this.weight, 
      this.rate, 
      this.amount, 
      this.weighing, 
      this.userId, 
      this.createdAt, 
      this.updatedAt});

  Data.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    shift = json['shift'];
    cattleType = json['cattle_type'];
    fat = json['fat'];
    vendorNumber = json['vendor_number'];
    vendorName = json['vendor_name'];
    weight = json['weight'];
    rate = json['rate'];
    amount = json['amount'];
    weighing = json['weighing'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['time'] = time;
    map['shift'] = shift;
    map['cattle_type'] = cattleType;
    map['fat'] = fat;
    map['vendor_number'] = vendorNumber;
    map['vendor_name'] = vendorName;
    map['weight'] = weight;
    map['rate'] = rate;
    map['amount'] = amount;
    map['weighing'] = weighing;
    map['user_id'] = userId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}