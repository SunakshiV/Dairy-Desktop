class GetDeductSingleResponse {
  int status;
  List<Data> data;
  String message;

  GetDeductSingleResponse({
      this.status, 
      this.data, 
      this.message});

  GetDeductSingleResponse.fromJson(dynamic json) {
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
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  Data({
      this.id, 
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
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt});

  Data.fromJson(dynamic json) {
    id = json["id"];
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
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
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
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["deleted_at"] = deletedAt;
    return map;
  }

}