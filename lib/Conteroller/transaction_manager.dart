import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:walletman/models/wallets_model.dart';
import 'package:walletman/models/database_helper.dart';
import 'package:flutter/services.dart';

final walletNameController = TextEditingController();
final walletValueController = TextEditingController();
final walletCardNumberController = TextEditingController();
final walletAccountNumberController = TextEditingController();
final TextEditingController dateconterol = TextEditingController();
Wallet userWallet;
enum ConfirmAction { CANCEL, ACCEPT }

class AddIncomePage extends StatefulWidget {
  final int transactionid;
  final String transactionName;
  final Icon transactionIcon;

  AddIncomePage(
      {Key key, this.transactionid, this.transactionName, this.transactionIcon})
      : super(key: key);
  @override
  _AddIncomePageState createState() => _AddIncomePageState(
      this.transactionid, this.transactionName, this.transactionIcon);
}

class _AddIncomePageState extends State<AddIncomePage> {
  final dbHelper = DatabaseHelper.instance;
  int transactionid;
  String transactionName;
  Icon transactionIcon;
  String userdate;

  _AddIncomePageState(
      this.transactionid, this.transactionName, this.transactionIcon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 50.0, bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "ثبت دارایی جدید",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Bkoodak",
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: transactionIcon),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "افزودن ${transactionName}",
                style: TextStyle(
                    color: Colors.white, fontSize: 30, fontFamily: 'BKoodak'),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 12, right: 12),
                child: _buildChild(context)),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  if (walletCardNumberController.text.isNotEmpty &&
                      walletValueController.text.isNotEmpty) {
                    _insert();
                  } else {
                    _asyncConfirmDialog(context);
                  }
                },
                child: Center(
                  child: new Text(
                    "ثبت اطلاعات",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "IranSans",
                        fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('متاسفیم 😢'),
          content: const Text('لطفا تمامی فیلد ها را پر کنید'),
          actions: <Widget>[
            FlatButton(
              child: const Text('لغو'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('قبول'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.walletName: walletValueController.toString(),
      DatabaseHelper.walletBalance:
          num.tryParse(walletValueController.toString()),
      DatabaseHelper.walletCardNumber: walletCardNumberController.toString(),
    };
    final id = await dbHelper.InsertIntoWallet(row);
    print('inserted row id: $id');
  }

  Widget _buildChild(BuildContext context) {
    if (transactionid == 1) {
      return _AddBankAcount();
    } else if (transactionid == 2) {
      return _AddBackPacket();
    } else if (transactionid == 3) {
      return _AddCurrency();
    } else if (transactionid == 4) {
      return _AddOther(context);
    } else {
      AlertDialog(
        title: Text('خطایی پیش امده'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('trmain :'),
              Text('Error 136'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  /// add bank account
  Widget _AddBankAcount() {
    return Column(
      children: <Widget>[
        TextField(
          style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
          textDirection: TextDirection.rtl,
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: "نام حساب",
            labelStyle: TextStyle(color: Colors.white, fontFamily: "IranYekan"),
            hintText: " نام حساب را وارد کنید",
            hintStyle: TextStyle(color: Colors.white, fontFamily: "IranSans"),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          controller: walletNameController,
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
          keyboardType: TextInputType.number,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          textDirection: TextDirection.rtl,
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: "شماره حساب",
            labelStyle: TextStyle(color: Colors.white, fontFamily: "IranYekan"),
            hintText: "شماره حساب را وارد کنید",
            hintStyle: TextStyle(color: Colors.white, fontFamily: "IranSans"),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          controller: walletAccountNumberController,
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
          keyboardType: TextInputType.number,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          textDirection: TextDirection.rtl,
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: "شماره کارت",
            labelStyle: TextStyle(color: Colors.white, fontFamily: "IranYekan"),
            hintText: "شماره کارت را وارد کنید",
            hintStyle: TextStyle(color: Colors.white, fontFamily: "IranSans"),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          controller: walletCardNumberController,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "ریال",
              style: TextStyle(
                  color: Colors.white, fontFamily: "IranSans", fontSize: 20),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: TextField(
                style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: "موجودی",
                  labelStyle:
                      TextStyle(color: Colors.white, fontFamily: "IranYekan"),
                  hintText: "موجودیتان را وارد کنید",
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: "IranSans"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
                controller: walletValueController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// add back packet
  Widget _AddBackPacket() {
    return Column(
      children: <Widget>[
        TextField(
          style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
          textDirection: TextDirection.rtl,
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: "نام کیف پول",
            hintStyle: TextStyle(color: Colors.white, fontFamily: "IranSans"),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          controller: walletCardNumberController,
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
          textDirection: TextDirection.rtl,
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: "شماره کارت",
            hintStyle: TextStyle(color: Colors.white, fontFamily: "IranSans"),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          controller: walletCardNumberController,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "ریال",
              style: TextStyle(
                  color: Colors.white, fontFamily: "IranSans", fontSize: 20),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: TextField(
                style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
                textDirection: TextDirection.rtl,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "موجودی ",
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: "IranSans"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
                controller: walletCardNumberController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// add currency
  Widget _AddCurrency() {
    return Column(
      children: <Widget>[
        TextField(
          style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
          textDirection: TextDirection.rtl,
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: "تعداد",
            hintStyle: TextStyle(color: Colors.white, fontFamily: "IranSans"),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          controller: walletCardNumberController,
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
          textDirection: TextDirection.rtl,
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: "قیمت خریداری شده",
            hintStyle: TextStyle(color: Colors.white, fontFamily: "IranSans"),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          controller: walletCardNumberController,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "\$|\€",
              style: TextStyle(
                  color: Colors.white, fontFamily: "IranSans", fontSize: 20),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: TextField(
                style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
                textDirection: TextDirection.rtl,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "ارزش روز ",
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: "IranSans"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
                controller: walletCardNumberController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// add  other
  Widget _AddOther(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
          textDirection: TextDirection.rtl,
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: "نام دارایی",
            hintStyle: TextStyle(color: Colors.white, fontFamily: "IranSans"),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          controller: walletCardNumberController,
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
          onTap: () async {
            FocusScope.of(context).requestFocus(new FocusNode());
            await showDialog(
              context: context,
              builder: (BuildContext _) {
                return PersianDateTimePicker(
                  type: 'date',
                  onSelect: (date) {
                    setState(() {
                      dateconterol.text = date;
                    });
                  },
                );
              },
            );
          },
          textDirection: TextDirection.rtl,
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: "انتخاب تاریخ ",
            hintStyle: TextStyle(color: Colors.white, fontFamily: "IranSans"),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
          controller: dateconterol,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "ریال",
              style: TextStyle(
                  color: Colors.white, fontFamily: "IranSans", fontSize: 20),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: TextField(
                style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
                textDirection: TextDirection.rtl,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "موجودی ",
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: "IranSans"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
                controller: walletCardNumberController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    dateconterol.clear();
  }
}

class reduce_income extends StatefulWidget {
  @override
  _reduce_incomeState createState() => _reduce_incomeState();
}

class _reduce_incomeState extends State<reduce_income> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 50.0, bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "ثبت تراکنش جدید",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Bkoodak",
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    style:
                        TextStyle(color: Colors.white, fontFamily: "IranSans"),
                    textDirection: TextDirection.rtl,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: "نام تراکنش",
                      hintStyle: TextStyle(
                          color: Colors.white, fontFamily: "IranSans"),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                    ),
                    controller: walletCardNumberController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style:
                        TextStyle(color: Colors.white, fontFamily: "IranSans"),
                    textDirection: TextDirection.rtl,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: "انتخاب کیف پول",
                      hintStyle: TextStyle(
                          color: Colors.white, fontFamily: "IranSans"),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                    ),
                    controller: walletCardNumberController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style:
                        TextStyle(color: Colors.white, fontFamily: "IranSans"),
                    textDirection: TextDirection.rtl,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: "انتخاب کالا",
                      hintStyle: TextStyle(
                          color: Colors.white, fontFamily: "IranSans"),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                    ),
                    controller: walletCardNumberController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style:
                        TextStyle(color: Colors.white, fontFamily: "IranSans"),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      await showDialog(
                        context: context,
                        builder: (BuildContext _) {
                          return PersianDateTimePicker(
                            type: 'date',
                            onSelect: (date) {
                              setState(() {
                                dateconterol.text = date;
                              });
                            },
                          );
                        },
                      );
                    },
                    textDirection: TextDirection.rtl,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: "ثبت تاریخ ",
                      hintStyle: TextStyle(
                          color: Colors.white, fontFamily: "IranSans"),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                    ),
                    controller: dateconterol,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "ریال",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "IranSans",
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: TextField(
                          style: TextStyle(
                              color: Colors.white, fontFamily: "IranSans"),
                          textDirection: TextDirection.rtl,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            hintText: "هزینه ",
                            hintStyle: TextStyle(
                                color: Colors.white, fontFamily: "IranSans"),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                          ),
                          controller: walletCardNumberController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  new RaisedButton(
                    padding: const EdgeInsets.all(12.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {},
                    child: Center(
                      child: new Text(
                        "ثبت اطلاعات",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "IranSans",
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
