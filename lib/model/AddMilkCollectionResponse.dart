class AddMilkCollectionResponse {
  int status;
  Data data;
  String message;

  AddMilkCollectionResponse({this.status, this.data, this.message});

  AddMilkCollectionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String date;
  String time;
  String shift;
  String cattleType;
  String vendorNumber;
  String vendorName;
  String fat;
  String snf;
  String clr;
  String rate;
  String weight;
  String amount;
  String userId;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.date,
        this.time,
        this.shift,
        this.cattleType,
        this.vendorNumber,
        this.vendorName,
        this.fat,
        this.snf,
        this.clr,
        this.rate,
        this.weight,
        this.amount,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    shift = json['shift'];
    cattleType = json['cattle_type'];
    vendorNumber = json['vendor_number'];
    vendorName = json['vendor_name'];
    fat = json['fat'];
    snf = json['snf'];
    clr = json['clr'];
    rate = json['rate'];
    weight = json['weight'];
    amount = json['amount'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['shift'] = this.shift;
    data['cattle_type'] = this.cattleType;
    data['vendor_number'] = this.vendorNumber;
    data['vendor_name'] = this.vendorName;
    data['fat'] = this.fat;
    data['snf'] = this.snf;
    data['clr'] = this.clr;
    data['rate'] = this.rate;
    data['weight'] = this.weight;
    data['amount'] = this.amount;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}