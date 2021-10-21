class GetAccountsResponse {
  int status;
  PaginateData paginateData;
  String message;

  GetAccountsResponse({this.status, this.paginateData, this.message});

  GetAccountsResponse.fromJson(Map<String, dynamic> json) {
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
  String image;
  String vendorCode;
  String vendorName;
  String father;
  String address;
  String phoneNumber;
  String mobileNumber;
  String city;
  String gstNumber;
  String emailAddress;
  String panNumber;
  String aadhaarNumber;
  String bankName;
  String bankBranch;
  String accountNumber;
  String ifscNumber;
  String rate;
  String userId;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.image,
        this.vendorCode,
        this.vendorName,
        this.father,
        this.address,
        this.phoneNumber,
        this.mobileNumber,
        this.city,
        this.gstNumber,
        this.emailAddress,
        this.panNumber,
        this.aadhaarNumber,
        this.bankName,
        this.bankBranch,
        this.accountNumber,
        this.ifscNumber,
        this.rate,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    vendorCode = json['vendor_code'];
    vendorName = json['vendor_name'];
    father = json['father'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    mobileNumber = json['mobile_number'];
    city = json['city'];
    gstNumber = json['gst_number'];
    emailAddress = json['email_address'];
    panNumber = json['pan_number'];
    aadhaarNumber = json['aadhaar_number'];
    bankName = json['bank_name'];
    bankBranch = json['bank_branch'];
    accountNumber = json['account_number'];
    ifscNumber = json['ifsc_number'];
    rate = json['rate'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['vendor_code'] = this.vendorCode;
    data['vendor_name'] = this.vendorName;
    data['father'] = this.father;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number'] = this.mobileNumber;
    data['city'] = this.city;
    data['gst_number'] = this.gstNumber;
    data['email_address'] = this.emailAddress;
    data['pan_number'] = this.panNumber;
    data['aadhaar_number'] = this.aadhaarNumber;
    data['bank_name'] = this.bankName;
    data['bank_branch'] = this.bankBranch;
    data['account_number'] = this.accountNumber;
    data['ifsc_number'] = this.ifscNumber;
    data['rate'] = this.rate;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}