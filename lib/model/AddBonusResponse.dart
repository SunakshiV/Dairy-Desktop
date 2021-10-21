class AddBonusResponse {
  int status;
  Data data;
  String message;

  AddBonusResponse({
      this.status, 
      this.data, 
      this.message});

  AddBonusResponse.fromJson(dynamic json) {
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
  String cow;
  String cowPerUnit;
  String cowCost;
  String buff;
  String buffPerUnit;
  String buffCost;
  String userId;
  String updatedAt;
  String createdAt;
  int id;

  Data({
      this.cow, 
      this.cowPerUnit, 
      this.cowCost, 
      this.buff, 
      this.buffPerUnit, 
      this.buffCost, 
      this.userId, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  Data.fromJson(dynamic json) {
    cow = json["cow"];
    cowPerUnit = json["cow_per_unit"];
    cowCost = json["cow_cost"];
    buff = json["buff"];
    buffPerUnit = json["buff_per_unit"];
    buffCost = json["buff_cost"];
    userId = json["user_id"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["cow"] = cow;
    map["cow_per_unit"] = cowPerUnit;
    map["cow_cost"] = cowCost;
    map["buff"] = buff;
    map["buff_per_unit"] = buffPerUnit;
    map["buff_cost"] = buffCost;
    map["user_id"] = userId;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    map["id"] = id;
    return map;
  }

}