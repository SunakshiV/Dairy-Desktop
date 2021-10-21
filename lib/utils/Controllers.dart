import 'package:flutter/material.dart';

class Controllers {
  // Login Controllers
  static TextEditingController firstname = TextEditingController();
  static TextEditingController lastname = TextEditingController();
  static TextEditingController email = TextEditingController();
  static TextEditingController phonenumber = TextEditingController();
  static TextEditingController referencecode = TextEditingController();
  static TextEditingController password = TextEditingController();
  static TextEditingController confirmpassword = TextEditingController();

  // Forgot Password Controllers
  static TextEditingController forgot_email = TextEditingController();

  // SIgnIn Controllers
  static TextEditingController login_email = TextEditingController();
  static TextEditingController login_password = TextEditingController();

  // Reset Password Controllers
  static TextEditingController resetEmail = TextEditingController();
  static TextEditingController resetPassword = TextEditingController();
  static TextEditingController resetConfirmPassword = TextEditingController();
  static TextEditingController resetOtp = TextEditingController();

  // Profile Controllers
  static TextEditingController code = TextEditingController();
  static TextEditingController name = TextEditingController();
  static TextEditingController account_name = TextEditingController();
  static TextEditingController bank_name = TextEditingController();
  static TextEditingController category = TextEditingController();
  static TextEditingController father_name = TextEditingController();
  static TextEditingController account_no = TextEditingController();
  static TextEditingController confirm_acc_no = TextEditingController();
  static TextEditingController address = TextEditingController();
  static TextEditingController city = TextEditingController();
  static TextEditingController bank_branch = TextEditingController();
  static TextEditingController ifsc = TextEditingController();
  static TextEditingController vehicle = TextEditingController();
  static TextEditingController mobile_no = TextEditingController();
  static TextEditingController pan = TextEditingController();

  // Home Controllers
  static TextEditingController notes = TextEditingController();

  // Add Account Controllers

  static TextEditingController acc_vendor_code = TextEditingController();
  static TextEditingController acc_vendor_name = TextEditingController();
  static TextEditingController acc_father_name = TextEditingController();
  static TextEditingController acc_addrress = TextEditingController();
  static TextEditingController acc_phone_number = TextEditingController();
  static TextEditingController acc_mobile_number = TextEditingController();
  static TextEditingController acc_gstin_number = TextEditingController();
  static TextEditingController acc_email = TextEditingController();
  static TextEditingController acc_pan = TextEditingController();
  static TextEditingController acc_aadhar = TextEditingController();
  static TextEditingController acc_bank_name = TextEditingController();
  static TextEditingController acc_bank_branch = TextEditingController();
  static TextEditingController acc_account_number = TextEditingController();
  static TextEditingController acc_ifsc = TextEditingController();
  static TextEditingController acc_city = TextEditingController();

  // Edit Account Controllers

  static TextEditingController ed_vendor_code = TextEditingController();
  static TextEditingController ed_vendor_name = TextEditingController();
  static TextEditingController ed_father_name = TextEditingController();
  static TextEditingController ed_addrress = TextEditingController();
  static TextEditingController ed_phone_number = TextEditingController();
  static TextEditingController ed_mobile_number = TextEditingController();
  static TextEditingController ed_gstin_number = TextEditingController();
  static TextEditingController ed_email = TextEditingController();
  static TextEditingController ed_pan = TextEditingController();
  static TextEditingController ed_aadhar = TextEditingController();
  static TextEditingController ed_bank_name = TextEditingController();
  static TextEditingController ed_bank_branch = TextEditingController();
  static TextEditingController ed_account_number = TextEditingController();
  static TextEditingController ed_ifsc = TextEditingController();
  static TextEditingController ed_city = TextEditingController();

  // milk collection controllers

  static TextEditingController milk_date = TextEditingController();
  static TextEditingController milk_time = TextEditingController();
  static TextEditingController milk_shift = TextEditingController();
  static TextEditingController milk_cattletype = TextEditingController();
  static TextEditingController milk_vendor_Code = TextEditingController();
  static TextEditingController milk_vendor_name = TextEditingController();
  static TextEditingController milk_fat = TextEditingController();
  static TextEditingController milk_snf = TextEditingController();
  static TextEditingController milk_clr = TextEditingController();
  static TextEditingController milk_weight = TextEditingController();
  static TextEditingController milk_rate = TextEditingController();
  static TextEditingController milk_amount = TextEditingController();

  static TextEditingController edtmilk_date = TextEditingController();
  static TextEditingController edtmilk_time = TextEditingController();
  static TextEditingController edtmilk_shift = TextEditingController();
  static TextEditingController edtmilk_cattletype = TextEditingController();
  static TextEditingController edtmilk_vendor_Code = TextEditingController();
  static TextEditingController edtmilk_vendor_name = TextEditingController();
  static TextEditingController edtmilk_fat = TextEditingController();
  static TextEditingController edtmilk_snf = TextEditingController();
  static TextEditingController edtmilk_clr = TextEditingController();
  static TextEditingController edtmilk_weight = TextEditingController();
  static TextEditingController edtmilk_rate = TextEditingController();
  static TextEditingController edtmilk_amount = TextEditingController();

  // Rate Controllers

  static TextEditingController flatrate = TextEditingController();

  // Dispatch Controllers

  static TextEditingController dairy_code = TextEditingController();
  static TextEditingController avg_fat = TextEditingController();
  static TextEditingController avg_snf = TextEditingController();
  static TextEditingController avg_clr = TextEditingController();
  static TextEditingController dispatch_rate = TextEditingController();
  static TextEditingController dispatch_weight = TextEditingController();
  static TextEditingController dispatch_no_cans = TextEditingController();
  static TextEditingController dispatch_amount = TextEditingController();
  static TextEditingController dispatch_quantity = TextEditingController();

  // Deduct Controllers

  static TextEditingController cow_min_fat = TextEditingController();
  static TextEditingController cow_per_unit = TextEditingController();
  static TextEditingController cow_cost = TextEditingController();
  static TextEditingController buf_min_fat = TextEditingController();
  static TextEditingController buf_per_unit = TextEditingController();
  static TextEditingController buf_cost = TextEditingController();
  static TextEditingController cow1_min_snf = TextEditingController();
  static TextEditingController cow1_per_unit = TextEditingController();
  static TextEditingController cow1_cost = TextEditingController();
  static TextEditingController buf1_min_snf = TextEditingController();
  static TextEditingController buf1_per_unit = TextEditingController();
  static TextEditingController buf1_cost = TextEditingController();

// Item Sale
  static TextEditingController item_srno = TextEditingController();
  static TextEditingController item_name = TextEditingController();
  static TextEditingController item_units = TextEditingController();
  static TextEditingController item_rate = TextEditingController();
  static TextEditingController item_quantity = TextEditingController();
  static TextEditingController item_amount = TextEditingController();

  // Bonus

  static TextEditingController b_cow_min_fat = TextEditingController();
  static TextEditingController b_cow_per_unit = TextEditingController();
  static TextEditingController b_cow_cost = TextEditingController();
  static TextEditingController b_buf_min_fat = TextEditingController();
  static TextEditingController b_buf_per_unit = TextEditingController();
  static TextEditingController b_buf_cost = TextEditingController();
  static TextEditingController itemadd_quantity = TextEditingController();
  static TextEditingController itemadd_amount = TextEditingController();

  static TextEditingController faqnotes = TextEditingController();
  static TextEditingController servicesnotes = TextEditingController();
  static TextEditingController helpnotes = TextEditingController();



  static TextEditingController oldpass = TextEditingController();
  static TextEditingController newpass = TextEditingController();
  static TextEditingController confirmpass = TextEditingController();

}
