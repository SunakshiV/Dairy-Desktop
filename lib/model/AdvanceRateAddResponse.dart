class AdvanceRateAddResponse {
  int status;
  Data data;
  String message;

  AdvanceRateAddResponse({
      this.status, 
      this.data, 
      this.message});

  AdvanceRateAddResponse.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data.toJson();
    }
    map['message'] = message;
    return map;
  }

}

class Data {
  String date;
  String cattle;
  String minFat;
  String maxFat;
  String minSnf;
  String maxSnf;
  String kgFat;
  String kgSnf;
  String rateFat;
  String userId;
  String fatType;
  String updatedAt;
  String createdAt;
  int id;

  Data({
      this.date, 
      this.cattle, 
      this.minFat, 
      this.maxFat, 
      this.minSnf, 
      this.maxSnf, 
      this.kgFat, 
      this.kgSnf, 
      this.rateFat, 
      this.userId, 
      this.fatType, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  Data.fromJson(dynamic json) {
    date = json['date'];
    cattle = json['cattle'];
    minFat = json['min_fat'];
    maxFat = json['max_fat'];
    minSnf = json['min_snf'];
    maxSnf = json['max_snf'];
    kgFat = json['kg_fat'];
    kgSnf = json['kg_snf'];
    rateFat = json['rate_fat'];
    userId = json['user_id'];
    fatType = json['fat_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['date'] = date;
    map['cattle'] = cattle;
    map['min_fat'] = minFat;
    map['max_fat'] = maxFat;
    map['min_snf'] = minSnf;
    map['max_snf'] = maxSnf;
    map['kg_fat'] = kgFat;
    map['kg_snf'] = kgSnf;
    map['rate_fat'] = rateFat;
    map['user_id'] = userId;
    map['fat_type'] = fatType;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}