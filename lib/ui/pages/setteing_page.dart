import 'package:walletman/ui/pages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountManegerPage extends StatefulWidget {
  @override
  _AccountManegerPageState createState() => _AccountManegerPageState();
}

class _AccountManegerPageState extends State<AccountManegerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 8, right: 8),
        child: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(top: 20, left: 8, right: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Color(0xFF34495e),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.wallet,
                  color: Colors.white,
                ),
                title: Text('مدیریت کیف پول',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'IranSans',
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WallatPage()),
                  );
                },
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 20, left: 8, right: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Color(0xFF34495e),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.sync,
                  color: Colors.white,
                ),
                title: Text('همگام سازی با سرور ',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'IranSans')),
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 20, left: 8, right: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Color(0xFF34495e),
              child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: Colors.white,
                  ),
                  title: Text('خروج از حساب',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'IranSans')),
                  onTap: () {
                    debugPrint("UR logut");
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
