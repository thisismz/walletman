import 'package:walletman/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionListPage extends StatefulWidget {
  @override
  _TransactionListPageState createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 50.0, bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "لیست تراکنش ها",
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ManagerPage()),);
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: 20,
                itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: index % 2 != 0 ? incomeCard() : outcomeCard()),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget incomeCard() {
    return Card(
      color: Color(0xFF34495e),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ListTile(
              leading: Icon(
                FontAwesomeIcons.arrowDown,
                size: 50,
                color: Color(0xffeb3b5a),
              ),
              title: Text(
                "خرید",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: "IranYekan",
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'قیمت: ۲۵۰,۰۰۰',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: "IranSans"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget outcomeCard() {
  return Card(
    color: Color(0xFF34495e),
    child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(
              FontAwesomeIcons.arrowUp,
              size: 50,
              color: Color(0xff26de81),
            ),
            title: Text('دریافت حقوق',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: "IranYekan",
                    fontWeight: FontWeight.bold)),
            subtitle: Text('مبلغ : ۳۰۰,۰۰۰',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: "IranSans")),
          ),
        ],
      ),
    ),
  );
}
