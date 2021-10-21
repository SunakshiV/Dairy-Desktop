class AccountFilterResponse {
  int status;
  List<Result> result;

  AccountFilterResponse({this.status, this.result});

  AccountFilterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String id;
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

  Result(
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

  Result.fromJson(Map<String, dynamic> json) {
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