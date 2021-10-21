class GetBonusSingleResponse {
  int status;
  List<Data> data;
  String message;

  GetBonusSingleResponse({this.status, this.data, this.message});

  GetBonusSingleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String cow;
  String cowPerUnit;
  String cowCost;
  String buff;
  String buffPerUnit;
  String buffCost;
  String userId;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.cow,
      this.cowPerUnit,
      this.cowCost,
      this.buff,
      this.buffPerUnit,
      this.buffCost,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cow = json['cow'];
    cowPerUnit = json['cow_per_unit'];
    cowCost = json['cow_cost'];
    buff = json['buff'];
    buffPerUnit = json['buff_per_unit'];
    buffCost = json['buff_cost'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cow'] = this.cow;
    data['cow_per_unit'] = this.cowPerUnit;
    data['cow_cost'] = this.cowCost;
    data['buff'] = this.buff;
    data['buff_per_unit'] = this.buffPerUnit;
    data['buff_cost'] = this.buffCost;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
