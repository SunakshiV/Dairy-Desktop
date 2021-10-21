class GetFvrtResponse {
  int status;
  List<Results> results;

  GetFvrtResponse({
      this.status, 
      this.results});

  GetFvrtResponse.fromJson(dynamic json) {
    status = json['status'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    if (results != null) {
      map['results'] = results.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Results {
  int id;
  String userId;
  String tabName;
  String isFavourite;
  String createdAt;
  String updatedAt;

  Results({
      this.id, 
      this.userId, 
      this.tabName, 
      this.isFavourite, 
      this.createdAt, 
      this.updatedAt});

  Results.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    tabName = json['tab_name'];
    isFavourite = json['isFavourite'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['tab_name'] = tabName;
    map['isFavourite'] = isFavourite;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}