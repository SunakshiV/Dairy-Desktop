class ItemSaleFilter {
  int status;
  List<Data> data;
  String message;

  ItemSaleFilter({
      this.status, 
      this.data, 
      this.message});

  ItemSaleFilter.fromJson(dynamic json) {
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
  String sNo;
  String date;
  String time;
  String code;
  String name;
  String item;
  String units;
  String rate;
  String quantity;
  String amount;
  String userId;
  dynamic createdAt;
  dynamic updatedAt;

  Data({
      this.id, 
      this.sNo, 
      this.date, 
      this.time, 
      this.code, 
      this.name, 
      this.item, 
      this.units, 
      this.rate, 
      this.quantity, 
      this.amount, 
      this.userId, 
      this.createdAt, 
      this.updatedAt});

  Data.fromJson(dynamic json) {
    id = json['id'];
    sNo = json['s_no'];
    date = json['date'];
    time = json['time'];
    code = json['code'];
    name = json['name'];
    item = json['item'];
    units = json['units'];
    rate = json['rate'];
    quantity = json['quantity'];
    amount = json['amount'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['s_no'] = sNo;
    map['date'] = date;
    map['time'] = time;
    map['code'] = code;
    map['name'] = name;
    map['item'] = item;
    map['units'] = units;
    map['rate'] = rate;
    map['quantity'] = quantity;
    map['amount'] = amount;
    map['user_id'] = userId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}