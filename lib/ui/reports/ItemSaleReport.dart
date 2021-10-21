import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class ItemSaleReport extends StatefulWidget {
  @override
  ItemSaleReportState createState() => ItemSaleReportState();
}

class ItemSaleReportState extends State<ItemSaleReport> {
  int select, valueRadio;
  String radioButtonItem = 'Item Purchase';
  final dateController = TextEditingController();
  final dateController1 = TextEditingController();
  // Group Value for Radio Button.
  int id = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Card(
          color: AppColors.accountbgcolor,
          elevation: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,            children: <Widget>[

              InkWell(
                onTap: () {
                  showDialog(

                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Column(

                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                      height: SizeConfig.blockSizeVertical * 70,
                                      width: SizeConfig.blockSizeVertical * 40,

                                      child:SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(


                                          children: <Widget>[
                                            InkWell(

                                              child:  Container(

                                                alignment: Alignment.centerRight,
                                                child:Icon(Icons.clear),
                                              ),

                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                            ),



                                            Image.asset(
                                              'assests/image/logofilter.png',
                                              width: SizeConfig.blockSizeHorizontal * 10,
                                              height: SizeConfig.blockSizeVertical * 10,
                                            ),
                                            Container(
                                              //   width: MediaQuery.of(context).size.width/2,
                                              width: SizeConfig.blockSizeHorizontal * 17,
                                              color: AppColors.white,
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
                                                  height: SizeConfig.blockSizeVertical * 5,
                                                  margin: EdgeInsets.all(10),
                                                  alignment: Alignment.topLeft,
                                                  child: TextField(
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
                                              color: AppColors.white,
                                              child: Column(children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(top: 10, left: 10),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Item',
                                                    style: TextStyle(
                                                        color: AppColors.black, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  height: SizeConfig.blockSizeVertical * 5,
                                                  margin: EdgeInsets.all(10),
                                                  alignment: Alignment.topLeft,
                                                  child: TextField(
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
                                              color: AppColors.white,
                                              child: Column(children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(top: 10, left: 10),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'From Date',
                                                    style: TextStyle(
                                                        color: AppColors.black, fontSize: 15),
                                                  ),
                                                ),


                                                InkWell(
                                                  onTap: () async {
                                                    var date =  await showDatePicker(
                                                        context: context,
                                                        initialDate:DateTime.now(),
                                                        firstDate:DateTime(1900),
                                                        lastDate: DateTime(2100));
                                                    dateController.text = date.toString().substring(0,10);
                                                  },

                                                  child:   Container(  height: SizeConfig.blockSizeVertical * 5,
                                                      margin: EdgeInsets.all(10),
                                                      alignment: Alignment.topLeft,
                                                      child:GestureDetector(
                                                          child:new IgnorePointer(
                                                            child: TextField(
                                                              enableInteractiveSelection: false,
                                                              readOnly: true,
                                                              controller: dateController,
                                                              decoration: InputDecoration(
                                                                  labelText: '',
                                                                  hoverColor: AppColors.lightBlue,
                                                                  border: OutlineInputBorder()),
                                                            ),
                                                          )
                                                      )


                                                  ),
                                                )


                                              ]),
                                            ),
                                            Container(
                                              //   width: MediaQuery.of(context).size.width/2,
                                              width: SizeConfig.blockSizeHorizontal * 17,
                                              color: AppColors.white,
                                              child: Column(children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(top: 10, left: 10),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'To Date',
                                                    style: TextStyle(
                                                        color: AppColors.black, fontSize: 15),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    var date =  await showDatePicker(
                                                        context: context,
                                                        initialDate:DateTime.now(),
                                                        firstDate:DateTime(1900),
                                                        lastDate: DateTime(2100));
                                                    dateController1.text = date.toString().substring(0,10);
                                                  },

                                                  child:   Container(
                                                      height: SizeConfig.blockSizeVertical * 5,
                                                      margin: EdgeInsets.all(10),
                                                      alignment: Alignment.topLeft,
                                                      child:GestureDetector(
                                                          child:new IgnorePointer(
                                                            child: TextField(
                                                              enableInteractiveSelection: false,
                                                              readOnly: true,
                                                              controller: dateController1,
                                                              decoration: InputDecoration(
                                                                  labelText: '',
                                                                  hoverColor: AppColors.lightBlue,
                                                                  border: OutlineInputBorder()),
                                                            ),
                                                          )
                                                      )


                                                  ),
                                                )
                                              ]),
                                            ),

                                            Container(
                                              width: SizeConfig.blockSizeHorizontal * 10,
                                              height: SizeConfig.blockSizeVertical * 5,

                                              margin: EdgeInsets.only(top: 10,),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Submit',
                                                style: TextStyle(color: AppColors.white, fontSize: 18),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                gradient: LinearGradient(
                                                  colors: <Color>[
                                                    Color(0xFF0D47A1),
                                                    Color(0xFF1976D2),
                                                    Color(0xFF42A5F5),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

                                  ),


                                ],


                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                    width: SizeConfig.blockSizeHorizontal * 6,
                    height: SizeConfig.blockSizeVertical * 6,
                    child: Icon(Icons.filter_list_sharp)),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 20, left: SizeConfig.blockSizeHorizontal * 1),
                alignment: Alignment.topLeft,
                child: Text(
                  'Item Sale Report',
                  style: TextStyle(
                      color: AppColors.allaccounttextcolor,
                      fontSize: SizeConfig.blockSizeVertical * 3),
                ),
              ),
            Container(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                    margin: EdgeInsets.only(
                      right: SizeConfig.blockSizeVertical * 3,
                    ),
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

                          Container(
                            width: SizeConfig.blockSizeHorizontal*50,
                            margin: EdgeInsets.only(
                                top: 10, left: SizeConfig.blockSizeHorizontal * 2),
                            alignment: Alignment.topLeft,
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: AppColors.allaccounttextcolor,
                                  fontSize: SizeConfig.blockSizeVertical * 3),
                            ),
                          ),
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 1),
                              width: SizeConfig.blockSizeHorizontal * 7,
                              height: SizeConfig.blockSizeVertical * 4,
                              alignment: Alignment.center,
                              child: Text(
                                'DELETE',
                                style: TextStyle(
                                    color:Colors.white, fontSize: 12),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                              ),
                            ),
                            onTap: () {
                              print("Tapped on container");

                            },
                          ),

                          Align(
                            child :   Container(

                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeVertical * 1),
                              child: Text(
                                'Export To',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                ),
                              ),
                            ),
                          ),


                          InkWell(
                            onTap: () {
                              print("Tapped on container");
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                width: SizeConfig.blockSizeHorizontal * 8,
                                height: SizeConfig.blockSizeVertical * 6,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assests/image/pdf.png"),
                                        fit: BoxFit.fill))),
                          )
                        ],
                      ),
                    )),
              ),
            ),
              Container(
                  width: SizeConfig.blockSizeHorizontal * 76,
                  margin: EdgeInsets.only(

                    top: SizeConfig.blockSizeVertical * 2,
                    right: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  height: SizeConfig.blockSizeVertical * 60,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: <Widget>[
                          Container(
                              width: SizeConfig.blockSizeHorizontal * 76,
                              height: SizeConfig.blockSizeVertical * 5,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                        left:
                                        SizeConfig.blockSizeHorizontal * 1,
                                      ),
                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'SR NO.',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                          (SizeConfig.blockSizeVertical *
                                              1.3),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: SizeConfig.blockSizeHorizontal * 8,
                                      margin: EdgeInsets.only(
                                        left:
                                        SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'DATE',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                          (SizeConfig.blockSizeVertical *
                                              1.3),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: SizeConfig.blockSizeHorizontal * 8,
                                      margin: EdgeInsets.only(
                                        left:
                                        SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'SHIFT',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                          (SizeConfig.blockSizeVertical *
                                              1.3),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: SizeConfig.blockSizeHorizontal * 10,
                                      margin: EdgeInsets.only(
                                        left:
                                        SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'VENDOR NUMBER',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                          (SizeConfig.blockSizeVertical *
                                              1.3),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: SizeConfig.blockSizeHorizontal * 10,
                                      margin: EdgeInsets.only(
                                        left:
                                        SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'ITEM TYPE',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                          (SizeConfig.blockSizeVertical *
                                              1.3),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: SizeConfig.blockSizeHorizontal * 12,
                                      margin: EdgeInsets.only(
                                        left:
                                        SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'QUANTITY',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                          (SizeConfig.blockSizeVertical *
                                              1.3),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      alignment: Alignment.center,
                                      width: SizeConfig.blockSizeHorizontal * 10,
                                      margin: EdgeInsets.only(
                                        left:
                                        SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'AMOUNT',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                          (SizeConfig.blockSizeVertical *
                                              1.3),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: SizeConfig.blockSizeHorizontal * 8,
                                      margin: EdgeInsets.only(
                                        left:
                                        SizeConfig.blockSizeHorizontal * 2,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'ACTION',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                          (SizeConfig.blockSizeVertical *
                                              1.3),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.allaccountbgcolor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                      SizeConfig.blockSizeHorizontal * 0.3),
                                  bottomRight: Radius.circular(
                                      SizeConfig.blockSizeHorizontal * 0.3),
                                  topLeft: Radius.circular(
                                      SizeConfig.blockSizeHorizontal * 0.3),
                                  topRight: Radius.circular(
                                      SizeConfig.blockSizeHorizontal * 0.3),
                                ),
                              )),
                          Container(
                              width: SizeConfig.blockSizeHorizontal * 76,
                              height: SizeConfig.blockSizeVertical * 50,
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 1),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        children: [
                                          Radio(
                                            activeColor: AppColors.lightBlue,
                                            value: index,
                                            groupValue: select,
                                            onChanged: (value) {
                                              setState(() {
                                                valueRadio = index;
                                                print(valueRadio);
                                                select = value;
                                              });
                                            },
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),
                                            child: Text(
                                              '',
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: AppColors.black,
                                                  fontFamily: 'Poppins-Normal',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  letterSpacing: 1.0),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                    .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                    .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                    .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                    .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                    .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                    .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                    .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                    .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),



                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                    .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                    .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),

                                          InkWell(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                width: SizeConfig
                                                    .blockSizeHorizontal *
                                                    4,
                                                height: SizeConfig
                                                    .blockSizeVertical *
                                                    3,

                                                alignment: Alignment.center,
                                                child: Text(
                                                  'EDIT',
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 15),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: AppColors.yellow),
                                              ),
                                            ),
                                            onTap: () {
                                              print("Tapped on container");
                                            },
                                          )
                                        ],
                                      );
                                    }),
                              )),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
