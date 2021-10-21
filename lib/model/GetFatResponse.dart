class GetFatResponse {
  int status;
  List<Data> data;
  String message;

  GetFatResponse({this.status, this.data, this.message});

  GetFatResponse.fromJson(Map<String, dynamic> json) {
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
  String fat;
  String cattle;

  Data({this.fat, this.cattle});

  Data.fromJson(Map<String, dynamic> json) {
    fat = json['fat'];
    cattle = json['cattle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fat'] = this.fat;
    data['cattle'] = this.cattle;
    return data;
  }
}