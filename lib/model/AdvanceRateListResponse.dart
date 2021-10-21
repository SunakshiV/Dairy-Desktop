class AdvanceRateListResponse {
  int status;
  List<Data> data;
  String message;

  AdvanceRateListResponse({
      this.status, 
      this.data, 
      this.message});

  AdvanceRateListResponse.fromJson(dynamic json) {
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
  String cattle;
  String minFat;
  String maxFat;
  String minSnf;
  String maxSnf;
  String kgFat;
  String kgSnf;
  String rateFat;
  String fatType;
  String userId;
  String createdAt;
  String updatedAt;

  Data({
      this.id, 
      this.date, 
      this.cattle, 
      this.minFat, 
      this.maxFat, 
      this.minSnf, 
      this.maxSnf, 
      this.kgFat, 
      this.kgSnf, 
      this.rateFat, 
      this.fatType, 
      this.userId, 
      this.createdAt, 
      this.updatedAt});

  Data.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    cattle = json['cattle'];
    minFat = json['min_fat'];
    maxFat = json['max_fat'];
    minSnf = json['min_snf'];
    maxSnf = json['max_snf'];
    kgFat = json['kg_fat'];
    kgSnf = json['kg_snf'];
    rateFat = json['rate_fat'];
    fatType = json['fat_type'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['cattle'] = cattle;
    map['min_fat'] = minFat;
    map['max_fat'] = maxFat;
    map['min_snf'] = minSnf;
    map['max_snf'] = maxSnf;
    map['kg_fat'] = kgFat;
    map['kg_snf'] = kgSnf;
    map['rate_fat'] = rateFat;
    map['fat_type'] = fatType;
    map['user_id'] = userId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}