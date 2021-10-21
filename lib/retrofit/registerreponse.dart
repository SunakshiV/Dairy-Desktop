import 'package:flutter/material.dart';

class registerresponse {
  int status;
  Data data;
  String message;

  registerresponse({this.status, this.data, this.message});

  registerresponse.fromJson(Map<String, dynamic> json) {
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
  String name;
  String lname;
  String email;
  String phoneNumber;
  String referenceCode;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.name,
        this.lname,
        this.email,
        this.phoneNumber,
        this.referenceCode,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lname = json['lname'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    referenceCode = json['reference_code'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['reference_code'] = this.referenceCode;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}