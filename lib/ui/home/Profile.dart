import 'dart:typed_data';

import 'package:dairy_newdeskapp/model/AddProfileResponse.dart';
import 'package:dairy_newdeskapp/model/GetProfileResponse.dart';
import 'package:dairy_newdeskapp/ui/HomeScreen.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
// TODO: implement createState

/* @override
 */
}

class ProfileState extends State<Profile> {
  var value = false;
  int select, valueRadio;
  String dropdownValue = 'Select';
  Uint8List uploadedImage;
  List<String> spinnerItems = ['Select', 'Two', 'Three', 'Four', 'Five'];
  var name;
  var _fileBytes;
  Image _imageWidget = null;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  int _userId;
  int isProfileData;

  @override
  Future<void> initState() {
    super.initState();
    _loadID();
  }

  _loadID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
      print(_userId);
      Dialogs.showLoadingDialog(context, _keyLoader);
      getProfile(_keyLoader, _userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 20),
          color: AppColors.homeblluebg,
          height: SizeConfig.blockSizeVertical * 100,
          child: SingleChildScrollView(
              child: Form(
            child: Container(
                child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 0.5),
                  margin: EdgeInsets.only(
                      right: SizeConfig.blockSizeHorizontal * 1),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'My Profile',
                    style: TextStyle(
                        color: AppColors.allaccounttextcolor, fontSize: 20),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      _imageWidget != null
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  // _startFilePicker();
                                  //getMultipleImageInfos();
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 70),
                                  height: 140,
                                  width: 120,
                                  child: _imageWidget,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assests/image/milk1.png'),
                                          fit: BoxFit.fill))),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  // _startFilePicker();
                                  //   getMultipleImageInfos();
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 70),
                                  height: 140,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assests/image/profile.png'),
                                          fit: BoxFit.fill))),
                            ),
                      Container(
                        margin: EdgeInsets.only(left: 50),
                        width: SizeConfig.blockSizeHorizontal * 17,
                        child: Column(
                          children: <Widget>[
                            Container(
                              //   width: MediaQuery.of(context).size.width/2,
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10, left: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Code',
                                    style: TextStyle(
                                        color: AppColors.black, fontSize: 15),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  alignment: Alignment.topLeft,
                                  child: TextFormField(
                                    controller: Controllers.code,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        labelText: '',
                                        hoverColor: AppColors.lightBlue,
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              //   width: MediaQuery.of(context).size.width/2,
                              width: SizeConfig.blockSizeHorizontal * 17,

                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10, left: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    ' Name*',
                                    style: TextStyle(
                                        color: AppColors.black, fontSize: 15),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  alignment: Alignment.topLeft,
                                  child: TextFormField(
                                    controller: Controllers.name,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        labelText: '',
                                        hoverColor: AppColors.lightBlue,
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
                                'Bank Account Details',
                                style: TextStyle(
                                    color: AppColors.allaccounttextcolor,
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 60),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    //   width: MediaQuery.of(context).size.width/2,
                                    width: SizeConfig.blockSizeHorizontal * 17,
                                    child: Column(children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Account Name',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        alignment: Alignment.topLeft,
                                        child: TextField(
                                          controller: Controllers.account_name,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              labelText: '',
                                              hoverColor: AppColors.lightBlue,
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Container(
                                    //   width: MediaQuery.of(context).size.width/2,
                                    width: SizeConfig.blockSizeHorizontal * 17,

                                    child: Column(children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Bank Name',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        alignment: Alignment.topLeft,
                                        child: TextField(
                                          controller: Controllers.bank_name,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              labelText: '',
                                              hoverColor: AppColors.lightBlue,
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 17,
                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Category',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 12),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: Controllers.category,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 17,

                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Father Name*',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: Controllers.father_name,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 17,

                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Account No.',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextFormField(
                              controller: Controllers.account_no,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 17,

                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Confirm Account No.',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: Controllers.confirm_acc_no,
                              textInputAction: TextInputAction.next,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 17,

                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Address',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: Controllers.address,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 17,

                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'City*',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: Controllers.city,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 17,

                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Bank Branch',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: Controllers.bank_branch,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 17,

                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'IFSC',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: Controllers.ifsc,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 17,

                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Village',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: Controllers.vehicle,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 17,

                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Mobile No*',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: Controllers.mobile_no,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 17,

                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'PAN',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: Controllers.pan,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                isProfileData == 1
                    ? Container(
                        child: InkWell(
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 8,
                            height: SizeConfig.blockSizeVertical * 5,
                            margin: EdgeInsets.only(top: 30),
                            alignment: Alignment.center,
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 18),
                            ),
                            color: AppColors.blueDark,
                          ),
                          onTap: () {
                            setState(() {
                              editProfile(
                                _keyLoader,
                                Controllers.code.text,
                                Controllers.name.text,
                                Controllers.account_name.text,
                                Controllers.bank_name.text,
                                Controllers.category.text,
                                Controllers.father_name.text,
                                Controllers.account_no.text,
                                Controllers.confirm_acc_no.text,
                                Controllers.address.text,
                                Controllers.city.text,
                                Controllers.bank_branch.text,
                                Controllers.ifsc.text,
                                Controllers.vehicle.text,
                                Controllers.mobile_no.text,
                                Controllers.pan.text,
                              );
                            });
                          },
                        ),
                      )
                    : Container(
                        child: InkWell(
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 8,
                            height: SizeConfig.blockSizeVertical * 5,
                            margin: EdgeInsets.only(top: 30),
                            alignment: Alignment.center,
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 18),
                            ),
                            color: AppColors.blueDark,
                          ),
                          onTap: () {
                            setState(() {
                              print(Controllers.category.text);
                              Dialogs.showLoadingDialog(context, _keyLoader);
                              addProfile(
                                _keyLoader,
                                Controllers.code.text,
                                Controllers.name.text,
                                Controllers.account_name.text,
                                Controllers.bank_name.text,
                                Controllers.category.text,
                                Controllers.father_name.text,
                                Controllers.account_no.text,
                                Controllers.confirm_acc_no.text,
                                Controllers.address.text,
                                Controllers.city.text,
                                Controllers.bank_branch.text,
                                Controllers.ifsc.text,
                                Controllers.vehicle.text,
                                Controllers.mobile_no.text,
                                Controllers.pan.text,
                              );
                            });
                          },
                        ),
                      )
              ],
            )),
          ))),
    );
  }



  Future<void> editProfile(
      GlobalKey<State<StatefulWidget>> keyLoader,
      String code,
      String name,
      String accname,
      String bankname,
      String category,
      String fathername,
      String accountno,
      String caccno,
      String address,
      String city,
      String bankbranch,
      String ifsc,
      String village,
      String mobileno,
      String pan)
       async {
    // String fileName = _cloudFile.name.split('/').last;
    _fileBytes = "";
    FormData formData = FormData.fromMap({
      // "image":await MultipartFile.fromBytes(_fileBytes, filename:""),
      "image": 'fgf',
      'user_id': _userId,
      'dsc_code': code,
      'category': category,
      'address': address,
      'dsc_name': bankname,
      'father_name': fathername,
      'village': village,
      'city': city,
      'contact': mobileno,
      'acc_name': accname,
      'acc_no': accountno,
      'bank_name': bankname,
      'bank_branch': bankbranch,
      'ifsc': ifsc,
      'pan': pan,
    });
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = 'multipart/form-data';
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/updateProfile',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      AddProfileResponse user = AddProfileResponse.fromJson(responseData.data);
      print(user.status);
      if (user.status == 200) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
        print(user.message);
        getProfile(keyLoader, _userId);
      }
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e, context);
      print("-----" + errorMessage.toString());
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }

  Future<void> addProfile(
      GlobalKey<State<StatefulWidget>> keyLoader,
      String code,
      String name,
      String accname,
      String bankname,
      String category,
      String fathername,
      String accountno,
      String caccno,
      String address,
      String city,
      String bankbranch,
      String ifsc,
      String village,
      String mobileno,
      String pan) async {
    // String fileName = _cloudFile.name.split('/').last;
    _fileBytes = "";
    FormData formData = FormData.fromMap({
      // "image":await MultipartFile.fromBytes(_fileBytes, filename:""),
      "image": 'fgf',
      'user_id': _userId,
      'dsc_code': code,
      'category': category,
      'address': address,
      'dsc_name': bankname,
      'father_name': fathername,
      'village': village,
      'city': city,
      'contact': mobileno,
      'acc_name': accname,
      'acc_no': accountno,
      'bank_name': bankname,
      'bank_branch': bankbranch,
      'ifsc': ifsc,
      'pan': pan,
    });

    try {
      Dio _dio = new Dio();
      _dio.options.contentType = 'multipart/form-data';
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/addprofile',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      AddProfileResponse user = AddProfileResponse.fromJson(responseData.data);
      print(user.status);
      if (user.status == 200) {
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
        print(user.message);
        getProfile(keyLoader, _userId);
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      final errorMessage = DioExceptions.fromDioError(e, context);
      print("-----" + errorMessage.toString());
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }

  void nextscreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen(),
          settings: RouteSettings(name: 'changepass')),
    );
  }

  Future<void> getProfile(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {
      'user_id': user_id,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/profile_list',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      GetProfileResponse user = GetProfileResponse.fromJson(responseData.data);
      print(user.status);
      if (user.status == 200) {
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        print("-----1" + user.message);
        setState(() {
          isProfileData = 1;
          Controllers.code.text = user.data.dscCode;
          Controllers.name.text = user.data.dscName;
          Controllers.account_name.text = user.data.accName;
          Controllers.bank_name.text = user.data.bankName;
          Controllers.category.text = user.data.category;
          Controllers.father_name.text = user.data.fatherName;
          Controllers.account_no.text = user.data.accNo;
          Controllers.confirm_acc_no.text = user.data.accNo;
          Controllers.address.text = user.data.address;
          Controllers.city.text = user.data.city;
          Controllers.bank_branch.text = user.data.bankBranch;
          Controllers.ifsc.text = user.data.ifsc;
          Controllers.vehicle.text = user.data.village;
          Controllers.mobile_no.text = user.data.contact;
          Controllers.pan.text = user.data.pan;
          print("True: " + isProfileData.toString());
        });
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      final errorMessage = DioExceptions.fromDioError(e, context);
      print("-----2" + errorMessage.toString());
      setState(() {
        isProfileData = 2;
        Controllers.code.text = '';
        Controllers.name.text = '';
        Controllers.account_name.text = '';
        Controllers.bank_name.text = '';
        Controllers.category.text = '';
        Controllers.father_name.text = '';
        Controllers.account_no.text = '';
        Controllers.confirm_acc_no.text = '';
        Controllers.address.text = '';
        Controllers.city.text = '';
        Controllers.bank_branch.text = '';
        Controllers.ifsc.text = '';
        Controllers.vehicle.text = '';
        Controllers.mobile_no.text = '';
        Controllers.pan.text = '';
        print("false: " + isProfileData.toString());
      });
    }
  }

  rightView() {
    //print("333333"+isProfileData.toString());
  }
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError, BuildContext context1) {
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        message = _handleError(
            context1, dioError.response.statusCode, dioError.response.data);
        break;
      case DioErrorType.SEND_TIMEOUT:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message;

  String _handleError(BuildContext context2, int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return '';
      case 404:
        /* Fluttertoast.showToast(
          msg: error["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
        );*/
        return error["message"];
      case 500:
        /*  Fluttertoast.showToast(
          msg: 'Internal server error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
        );*/
        return 'Internal server error';
      default:
        /*   Fluttertoast.showToast(
          msg: 'Oops something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
        );*/
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
