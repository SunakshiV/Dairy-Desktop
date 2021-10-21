class AddAccountResponse {
  int status;
  Data data;
  String message;

  AddAccountResponse({this.status, this.data, this.message});

  AddAccountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String vendorCode;
  String vendorName;
  String father;
  String address;
  String phoneNumber;
  String mobileNumber;
  String gstNumber;
  String emailAddress;
  String panNumber;
  String aadhaarNumber;
  String bankName;
  String bankBranch;
  String accountNumber;
  String ifscNumber;
  String userId;
  String updatedAt;
  String createdAt;
  String city;
  int id;

  Data(
      {this.vendorCode,
      this.vendorName,
      this.father,
      this.address,
      this.phoneNumber,
      this.mobileNumber,
      this.gstNumber,
      this.emailAddress,
      this.panNumber,
      this.aadhaarNumber,
      this.bankName,
      this.bankBranch,
      this.accountNumber,
      this.ifscNumber,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.city,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    vendorCode = json['vendor_code'];
    vendorName = json['vendor_name'];
    father = json['father'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    mobileNumber = json['mobile_number'];
    gstNumber = json['gst_number'];
    emailAddress = json['email_address'];
    panNumber = json['pan_number'];
    aadhaarNumber = json['aadhaar_number'];
    bankName = json['bank_name'];
    bankBranch = json['bank_branch'];
    accountNumber = json['account_number'];
    ifscNumber = json['ifsc_number'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    city = json['city'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_code'] = this.vendorCode;
    data['vendor_name'] = this.vendorName;
    data['father'] = this.father;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number'] = this.mobileNumber;
    data['gst_number'] = this.gstNumber;
    data['email_address'] = this.emailAddress;
    data['pan_number'] = this.panNumber;
    data['aadhaar_number'] = this.aadhaarNumber;
    data['bank_name'] = this.bankName;
    data['bank_branch'] = this.bankBranch;
    data['account_number'] = this.accountNumber;
    data['ifsc_number'] = this.ifscNumber;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['city'] = this.city;
    data['id'] = this.id;
    return data;
  }
}
