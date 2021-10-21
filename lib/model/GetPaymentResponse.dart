class GetPaymentResponse {
  int status;
  List<Data> data;
  String message;

  GetPaymentResponse({
      this.status, 
      this.data, 
      this.message});

  GetPaymentResponse.fromJson(dynamic json) {
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
  String vendorCode;
  String vendorName;
  String date;
  String time;
  String billNumber;
  String creditDebit;
  String notes;
  String amount;
  String userId;
  String createdAt;
  String updatedAt;

  Data({
      this.id, 
      this.vendorCode, 
      this.vendorName, 
      this.date, 
      this.time, 
      this.billNumber, 
      this.creditDebit, 
      this.notes, 
      this.amount, 
      this.userId, 
      this.createdAt, 
      this.updatedAt});

  Data.fromJson(dynamic json) {
    id = json['id'];
    vendorCode = json['vendor_code'];
    vendorName = json['vendor_name'];
    date = json['date'];
    time = json['time'];
    billNumber = json['bill_number'];
    creditDebit = json['credit_debit'];
    notes = json['notes'];
    amount = json['amount'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['vendor_code'] = vendorCode;
    map['vendor_name'] = vendorName;
    map['date'] = date;
    map['time'] = time;
    map['bill_number'] = billNumber;
    map['credit_debit'] = creditDebit;
    map['notes'] = notes;
    map['amount'] = amount;
    map['user_id'] = userId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}