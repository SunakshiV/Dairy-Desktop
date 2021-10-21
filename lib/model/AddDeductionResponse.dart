class AddDeductionResponse {
  int status;
  Data data;
  String message;

  AddDeductionResponse({
      this.status, 
      this.data, 
      this.message});

  AddDeductionResponse.fromJson(dynamic json) {
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
  String cowMinFat;
  String cowPerUnit;
  String fatCost;
  String cowMinSnf;
  String snfPerUnit;
  String snfCost;
  String bufMinFat;
  String bufPerUnit;
  String buffCost;
  String bufMinSnf;
  String bufSnfPerUnit;
  String bufNsfCost;
  String userId;
  String updatedAt;
  String createdAt;
  int id;

  Data({
      this.cowMinFat, 
      this.cowPerUnit, 
      this.fatCost, 
      this.cowMinSnf, 
      this.snfPerUnit, 
      this.snfCost, 
      this.bufMinFat, 
      this.bufPerUnit, 
      this.buffCost, 
      this.bufMinSnf, 
      this.bufSnfPerUnit, 
      this.bufNsfCost, 
      this.userId, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  Data.fromJson(dynamic json) {
    cowMinFat = json["cow_min_fat"];
    cowPerUnit = json["cow_per_unit"];
    fatCost = json["fat_cost"];
    cowMinSnf = json["cow_min_snf"];
    snfPerUnit = json["snf_per_unit"];
    snfCost = json["snf_cost"];
    bufMinFat = json["buf_min_fat"];
    bufPerUnit = json["buf_per_unit"];
    buffCost = json["buff_cost"];
    bufMinSnf = json["buf_min_snf"];
    bufSnfPerUnit = json["buf_snf_per_unit"];
    bufNsfCost = json["buf_nsf_cost"];
    userId = json["user_id"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["cow_min_fat"] = cowMinFat;
    map["cow_per_unit"] = cowPerUnit;
    map["fat_cost"] = fatCost;
    map["cow_min_snf"] = cowMinSnf;
    map["snf_per_unit"] = snfPerUnit;
    map["snf_cost"] = snfCost;
    map["buf_min_fat"] = bufMinFat;
    map["buf_per_unit"] = bufPerUnit;
    map["buff_cost"] = buffCost;
    map["buf_min_snf"] = bufMinSnf;
    map["buf_snf_per_unit"] = bufSnfPerUnit;
    map["buf_nsf_cost"] = bufNsfCost;
    map["user_id"] = userId;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    map["id"] = id;
    return map;
  }

}