import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:walletman/Conteroller/transaction_manager.dart';

class IncomeType {
  final int id;
  final String name;
  final Icon iconData;
  IncomeType({this.id, this.name, this.iconData});
}

class SelectTransactionTypePage extends StatelessWidget {
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
                    "افزودن دارایی جدید",
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
              padding: const EdgeInsets.only(top: 50.0),
              child: Wrap(
                // Gap between adjacent chips.
                spacing: 30.0,
                // Gap between lines.
                runSpacing: 30.0,
                direction: Axis.horizontal,
                children: [
                  IncomeType(
                      id: 1,
                      name: "حساب بانکی",
                      iconData: Icon(
                        FontAwesomeIcons.landmark,
                        size: 50,
                        color: Colors.white,
                      )),
                  IncomeType(
                      id: 2,
                      name: "پول نقد ",
                      iconData: Icon(
                        FontAwesomeIcons.moneyBill,
                        size: 50,
                        color: Colors.white,
                      )),
                  IncomeType(
                      id: 3,
                      name: "ارز ",
                      iconData: Icon(
                        FontAwesomeIcons.dollarSign,
                        size: 50,
                        color: Colors.white,
                      )),
                  IncomeType(
                      id: 4,
                      name: "سایر ",
                      iconData: Icon(
                        FontAwesomeIcons.shoppingBag,
                        size: 50,
                        color: Colors.white,
                      )),
                ]
                    .map(
                      (IncomeType income_list) => InkWell(
                        child: Container(
                          decoration: new BoxDecoration(
                              color: Color(0xff16a085),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          width: ScreenUtil.getInstance().setWidth(350),
                          height: ScreenUtil.getInstance().setHeight(350),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: income_list.iconData,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  income_list.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Bkoodak",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          switch (income_list.id) {
                            case 1:
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddIncomePage(
                                            transactionid: 1,
                                            transactionName: "حساب بانکی",
                                            transactionIcon: Icon(
                                              FontAwesomeIcons.creditCard,
                                              size: 90,
                                              color: Colors.white,
                                            ),
                                          )),
                                );
                              }
                              break;
                            case 2:
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddIncomePage(
                                            transactionid: 2,
                                            transactionName: "پول نقد",
                                            transactionIcon: Icon(
                                              FontAwesomeIcons.moneyBill,
                                              size: 90,
                                              color: Colors.white,
                                            ),
                                          )),
                                );
                              }
                              break;
                            case 3:
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddIncomePage(
                                            transactionid: 3,
                                            transactionName: "ارز",
                                            transactionIcon: Icon(
                                              FontAwesomeIcons.dollarSign,
                                              size: 90,
                                              color: Colors.white,
                                            ),
                                          )),
                                );
                              }
                              break;
                            case 4:
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddIncomePage(
                                              transactionid: 4,
                                              transactionName: "سایر",
                                              transactionIcon: Icon(
                                                FontAwesomeIcons.shoppingBag,
                                                size: 90,
                                                color: Colors.white,
                                              ),
                                            )));
                              }
                              break;
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
