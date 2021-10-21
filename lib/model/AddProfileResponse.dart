class AddProfileResponse {
  int status;
  Data data;
  String message;

  AddProfileResponse({this.status, this.data, this.message});

  AddProfileResponse.fromJson(Map<String, dynamic> json) {
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
  String image;
  String dscCode;
  String category;
  String address;
  String dscName;
  String fatherName;
  String village;
  String city;
  String contact;
  String accName;
  String accNo;
  String bankName;
  String bankBranch;
  String ifsc;
  String pan;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.image,
        this.dscCode,
        this.category,
        this.address,
        this.dscName,
        this.fatherName,
        this.village,
        this.city,
        this.contact,
        this.accName,
        this.accNo,
        this.bankName,
        this.bankBranch,
        this.ifsc,
        this.pan,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    dscCode = json['dsc_code'];
    category = json['category'];
    address = json['address'];
    dscName = json['dsc_name'];
    fatherName = json['father_name'];
    village = json['village'];
    city = json['city'];
    contact = json['contact'];
    accName = json['acc_name'];
    accNo = json['acc_no'];
    bankName = json['bank_name'];
    bankBranch = json['bank_branch'];
    ifsc = json['ifsc'];
    pan = json['pan'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['dsc_code'] = this.dscCode;
    data['category'] = this.category;
    data['address'] = this.address;
    data['dsc_name'] = this.dscName;
    data['father_name'] = this.fatherName;
    data['village'] = this.village;
    data['city'] = this.city;
    data['contact'] = this.contact;
    data['acc_name'] = this.accName;
    data['acc_no'] = this.accNo;
    data['bank_name'] = this.bankName;
    data['bank_branch'] = this.bankBranch;
    data['ifsc'] = this.ifsc;
    data['pan'] = this.pan;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}