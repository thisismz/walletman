import 'package:walletman/models/wallets_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:walletman/models/database_helper.dart';

class WallatPage extends StatefulWidget {
  @override
  _WallatPageState createState() => _WallatPageState();
}

class _WallatPageState extends State<WallatPage> {
  @override
  void initState() {
    _queryWallet();
    super.initState();
  }

  final dbHelper = DatabaseHelper.instance;
  bool creditCartVal = false;
  bool strongBoxVal = false;
  bool pocketVal = false;
  final walletNameController = TextEditingController();
  final walletValueController = TextEditingController();
  final walletDiscreptionController = TextEditingController();
  List<Wallet> wallets_list = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    walletNameController.dispose();
    walletDiscreptionController.dispose();
    walletValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 60, left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: InkWell(
                        child: Icon(
                          FontAwesomeIcons.plus,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          /// add wallet
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildAboutDialog(context),
                          );
                        },
                      ),
                    ),
                    Text(
                      "اضافه کردن کیف پول",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IranYekan',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),

              /// wallet list
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children:
                      List<Widget>.generate(wallets_list.length, (int index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(FontAwesomeIcons.wallet),
                            title: Text("نام کیف : ${wallets_list[index].name}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'IranYekan',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                            subtitle: Text("${wallets_list[index].cardnumber}"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(wallets_list[index].balance,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'IranYekan',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black)),
                                Text(": موجودی کیف پول  ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'IranYekan',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),

              /// wallet list end
            ],
          ),
        ),
      ),
    );
  }

  void _queryWallet() async {
    final allRows = await dbHelper.QueryAllWalletRows();
    print('query all rows:');
    allRows.forEach((row) => wallets_list.add(Wallet(
        name: row["name"],
        balance: row["wallet_balance"],
        accuntnumber: row["wallet_card_number"])));
  }

  void _insertWallet(Wallet _wallet) async {
    debugPrint(_wallet.name);
    debugPrint(_wallet.balance.toString());
    debugPrint(_wallet.cardnumber);
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.walletName: _wallet.name,
      DatabaseHelper.walletBalance: _wallet.balance,
      DatabaseHelper.walletCardNumber: _wallet.cardnumber,
      DatabaseHelper.walletCreateDate: DateTime.now().toString(),
      DatabaseHelper.walletAccountNumber: _wallet.accuntnumber
    };
    final id = await dbHelper.InsertIntoWallet(row);
    print('inserted row id: $id');
  }

  Widget _buildAboutDialog(BuildContext context) {
    return SingleChildScrollView(
      child: new AlertDialog(
        backgroundColor: Color(0xFF2d3447),
        title: const Text('ثبت کیف پول',
            style: TextStyle(
                fontSize: 15, fontFamily: 'IranSans', color: Colors.white)),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// name of wallet
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: TextField(
                style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
                textDirection: TextDirection.rtl,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "نام کیف را وارد کنید",
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: "IranSans"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
                controller: walletNameController,
              ),
            ),

            /// value of wallet

            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: TextField(
                style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
                textDirection: TextDirection.rtl,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "مانده اولیه",
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: "IranSans"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
                controller: walletValueController,
              ),
            ),

            /// discreption of wallet
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: TextField(
                style: TextStyle(color: Colors.white, fontFamily: "IranSans"),
                textDirection: TextDirection.rtl,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "توضیحات لازم",
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: "IranSans"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
                controller: walletDiscreptionController,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              _insertWallet(Wallet(
                  name: walletNameController.text,
                  balance: walletValueController.text,
                  accuntnumber: walletDiscreptionController.text));
            },
            child: const Text('تایید',
                style: TextStyle(
                    fontSize: 15, fontFamily: 'IranSans', color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
