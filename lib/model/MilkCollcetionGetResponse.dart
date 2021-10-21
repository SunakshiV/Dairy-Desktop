class MilkCollcetionGetResponse {
  int status;
  PaginateData paginateData;
  String message;

  MilkCollcetionGetResponse({this.status, this.paginateData, this.message});

  MilkCollcetionGetResponse.fromJson(Map<String, dynamic> json) {
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
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
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
  String date;
  String time;
  String shift;
  String cattleType;
  String vendorNumber;
  String vendorName;
  String fat;
  String snf;
  String clr;
  String weight;
  String rate;
  String amount;
  String weighing;
  String userId;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.date,
        this.time,
        this.shift,
        this.cattleType,
        this.vendorNumber,
        this.vendorName,
        this.fat,
        this.snf,
        this.clr,
        this.weight,
        this.rate,
        this.amount,
        this.weighing,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    shift = json['shift'];
    cattleType = json['cattle_type'];
    vendorNumber = json['vendor_number'];
    vendorName = json['vendor_name'];
    fat = json['fat'];
    snf = json['snf'];
    clr = json['clr'];
    weight = json['weight'];
    rate = json['rate'];
    amount = json['amount'];
    weighing = json['weighing'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['shift'] = this.shift;
    data['cattle_type'] = this.cattleType;
    data['vendor_number'] = this.vendorNumber;
    data['vendor_name'] = this.vendorName;
    data['fat'] = this.fat;
    data['snf'] = this.snf;
    data['clr'] = this.clr;
    data['weight'] = this.weight;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['weighing'] = this.weighing;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}