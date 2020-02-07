import 'package:walletman/ui/pages/transaction_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:walletman/models/wallets_model.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:walletman/Conteroller/transaction_manager.dart';

class WalletCard extends StatelessWidget {
  final Wallet wallet;

  WalletCard(this.wallet);

  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 0.0),
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: Colors.white,
          height: ScreenUtil.getInstance().setHeight(250),
          width: ScreenUtil.getInstance().setWidth(250),
          child: new Image(
            fit: BoxFit.scaleDown,
            image: new AssetImage(wallet.logo),
          ),
        ),
      ),
    );

    final planetCard = new Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(20)),
      decoration: new BoxDecoration(
        color: const Color(0xFFa55eea),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0))
        ],
      ),
      child: new Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(200)),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    wallet.name,
                    style: TextStyle(
                        fontFamily: 'IranSans',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  new Text(
                    ":نام کیف پول",
                    style: TextStyle(
                        fontFamily: 'IranSans',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(wallet.balance.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                  new Text(":باقی مانده",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Container(
                      width: ScreenUtil().setWidth(135),
                      height: ScreenUtil().setHeight(135),
                      decoration: BoxDecoration(
                        color: Color(0xff26de81),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius:
                                20.0, // has the effect of softening the shadow
                            spreadRadius:
                                5.0, // has the effect of extending the shadow
                            offset: Offset(
                              10.0, // horizontal, move right 10
                              10.0, // vertical, move down 10
                            ),
                          ),
                        ],
                      ),
                      child: Icon(
                        FontAwesomeIcons.angleUp,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SelectTransactionTypePage()),
                      );
                    },
                  ),
                  FlatButton(
                    child: Container(
                      width: ScreenUtil().setWidth(140),
                      height: ScreenUtil().setHeight(140),
                      decoration: BoxDecoration(
                        color: const Color(0xffeb3b5a),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius:
                                20.0, // has the effect of softening the shadow
                            spreadRadius:
                                5.0, // has the effect of extending the shadow
                            offset: Offset(
                              10.0, // horizontal, move right 10
                              10.0, // vertical, move down 10
                            ),
                          ),
                        ],
                      ),
                      child: Icon(
                        FontAwesomeIcons.angleDown,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => reduce_income(),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return new Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setWidth(40), bottom: ScreenUtil().setWidth(28)),
      child: new Stack(
        children: <Widget>[
          planetCard,
          planetThumbnail,
        ],
      ),
    );
  }
}
