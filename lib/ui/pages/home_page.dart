import 'package:walletman/ui/pages/login_page.dart';
import 'package:walletman/ui/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletman/models/wallets_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'setteing_page.dart';

class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 20, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(40),
                  right: ScreenUtil().setWidth(40),
                  top: ScreenUtil().setWidth(100),
                  bottom: ScreenUtil().setWidth(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AccountManegerPage()),
                      );
                    },
                  ),
                  Material(
                    // needed
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()),
                        );
                      }, // needed
                      child: Image.asset(
                        "assets/imgs/woman.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "کیف پول",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Bkoodak",
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            //card
            Container(
              width: ScreenUtil.getInstance().setWidth(1200),
              height: ScreenUtil.getInstance().setHeight(510),
              child: new Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new WalletCard(wallets_list[index]);
                },
                itemCount: 5,
                viewportFraction: 0.9,
                scale: 0.9,
                loop: false,
              ),
            ),
            // card end
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30),
                  top: ScreenUtil().setWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('۱۴۷,۲۱۰,۰۰۰',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'IranYekan',
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  Text(': کل دارایی',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Bkoodak',
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                ],
              ),
            ),
            //chart
            Container(
              width: ScreenUtil.getInstance().setWidth(900),
              height: ScreenUtil.getInstance().setHeight(650),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: BarChart(
                  BarChartData(
                    maxY: 20,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.grey,
                        getTooltipItem: (_a, _b, _c, _d) => null,
                      ),
                      touchCallback: (response) {
                        if (response.spot == null) {
                          setState(() {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                          });
                          return;
                        }

                        touchedGroupIndex = response.spot.touchedBarGroupIndex;

                        setState(() {
                          if (response.touchInput is FlLongPressEnd ||
                              response.touchInput is FlPanEnd) {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                          } else {
                            showingBarGroups = List.of(rawBarGroups);
                            if (touchedGroupIndex != -1) {
                              double sum = 0;
                              for (BarChartRodData rod
                                  in showingBarGroups[touchedGroupIndex]
                                      .barRods) {
                                sum += rod.y;
                              }
                              final avg = sum /
                                  showingBarGroups[touchedGroupIndex]
                                      .barRods
                                      .length;

                              showingBarGroups[touchedGroupIndex] =
                                  showingBarGroups[touchedGroupIndex].copyWith(
                                barRods: showingBarGroups[touchedGroupIndex]
                                    .barRods
                                    .map((rod) {
                                  return rod.copyWith(y: avg);
                                }).toList(),
                              );
                            }
                          }
                        });
                      },
                    ),
                    gridData: FlGridData(
                      show: false,
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        textStyle: TextStyle(
                            fontFamily: 'IranYekan',
                            color: const Color(0xffdff9fb),
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                        margin: 5,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return 'شنبه';
                            case 1:
                              return 'یک شنبه';
                            case 2:
                              return 'دوشنبه';
                            case 3:
                              return 'سه شنبه';
                            case 4:
                              return 'چهارشنبه';
                            case 5:
                              return 'پنج شنبه';
                            case 6:
                              return 'جمعه';
                            default:
                              return '';
                          }
                        },
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        textStyle: TextStyle(
                            fontFamily: 'IranYekan',
                            color: const Color(0xffdff9fb),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 15,
                        reservedSize: 10,
                        getTitles: (value) {
                          if (value == 0) {
                            return '۱۰۰';
                          } else if (value == 10) {
                            return '۲۰۰';
                          } else if (value == 19) {
                            return '۳۰۰';
                          } else {
                            return '';
                          }
                        },
                      ),
                    ),
                    borderData: FlBorderData(
                        show: false,
                        border: Border(
                          bottom: BorderSide(
                            color: const Color(0xffdff9fb),
                            width: 5,
                          ),
                          left: BorderSide(
                            color:
                                Colors.white, // set transparent for dosent show
                          ),
                          right: BorderSide(
                            color: Colors.transparent,
                          ),
                          top: BorderSide(
                            color: Colors.transparent,
                          ),
                        )),
                    barGroups: showingBarGroups,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: leftBarColor,
        width: width,
        isRound: true,
      ),
      BarChartRodData(
        y: y2,
        color: rightBarColor,
        width: width,
        isRound: true,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
