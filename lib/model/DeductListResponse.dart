class DeductListResponse {
  int status;
  PaginateData paginateData;
  String message;

  DeductListResponse({this.status, this.paginateData, this.message});

  DeductListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    paginateData = json['paginate_data'] != null
        ? new PaginateData.fromJson(json['paginate_data'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.paginateData != null) {
      data['paginate_data'] = this.paginateData.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class PaginateData {
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  Null nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;

  PaginateData(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  PaginateData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
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
  Null deletedAt;

  Data(
      {this.id,
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

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cowMinFat = json['cow_min_fat'];
    cowPerUnit = json['cow_per_unit'];
    fatCost = json['fat_cost'];
    cowMinSnf = json['cow_min_snf'];
    snfPerUnit = json['snf_per_unit'];
    snfCost = json['snf_cost'];
    bufMinFat = json['buf_min_fat'];
    bufPerUnit = json['buf_per_unit'];
    buffCost = json['buff_cost'];
    bufMinSnf = json['buf_min_snf'];
    bufSnfPerUnit = json['buf_snf_per_unit'];
    bufNsfCost = json['buf_nsf_cost'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cow_min_fat'] = this.cowMinFat;
    data['cow_per_unit'] = this.cowPerUnit;
    data['fat_cost'] = this.fatCost;
    data['cow_min_snf'] = this.cowMinSnf;
    data['snf_per_unit'] = this.snfPerUnit;
    data['snf_cost'] = this.snfCost;
    data['buf_min_fat'] = this.bufMinFat;
    data['buf_per_unit'] = this.bufPerUnit;
    data['buff_cost'] = this.buffCost;
    data['buf_min_snf'] = this.bufMinSnf;
    data['buf_snf_per_unit'] = this.bufSnfPerUnit;
    data['buf_nsf_cost'] = this.bufNsfCost;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}