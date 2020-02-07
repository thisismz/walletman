import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:charts_flutter/flutter.dart' as charts;

/// Data class to visualize.
class _CostsData {
  final String category;
  final int cost;
  const _CostsData(this.category, this.cost);
}

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  bool isShowingMainData;
  int touchedIndex;

  // Chart configs.
  bool _animate = true;
  double _arcRatio = 0.9;
  charts.ArcLabelPosition _arcLabelPosition = charts.ArcLabelPosition.auto;
  charts.BehaviorPosition _titlePosition = charts.BehaviorPosition.end;
  charts.BehaviorPosition _legendPosition = charts.BehaviorPosition.bottom;
  String dropdownValue = "سه ماه";
  // Data to render.
  List<_CostsData> _data = [
    _CostsData('خانه', 400),
    _CostsData('غذا', 200),
    _CostsData('سلامت', 200),
    _CostsData('رفت و امد', 150),
  ];
  final List<String> droplist = ["یک ماه", "دوماه", "سه ماه", "یک سال"];
  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    final _colorPalettes =
        charts.MaterialPalette.getOrderedPalettes(this._data.length);
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DropdownButton<String>(
                      hint: Text(
                        dropdownValue,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "IranSans"),
                      ),
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      //  style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "IranSans"),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: droplist
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontFamily: "IranSans"),
                          ),
                        );
                      }).toList(),
                    ),
                    Text(
                      "انتخاب دوره",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: "IranSans"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: ScreenUtil.getInstance().setHeight(600),
                  width: ScreenUtil.getInstance().setWidth(900),
                  child: LineChart(
                    sampleData1(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 4,
                  color: Colors.white,
                ),

                /// pie
                Container(
                  height: ScreenUtil.getInstance().setHeight(800),
                  child: charts.PieChart(
                    // Pie chart can only render one series.
                    /*seriesList=*/
                    [
                      charts.Series<_CostsData, String>(
                        id: 'transaction-1',
                        colorFn: (_, idx) => _colorPalettes[idx].shadeDefault,
                        domainFn: (_CostsData sales, _) => sales.category,
                        measureFn: (_CostsData sales, _) => sales.cost,
                        data: this._data,
                        // Set a label accessor to control the text of the arc label.
                        labelAccessorFn: (_CostsData row, _) =>
                            '${row.category}: ${row.cost}',
                      ),
                    ],
                    animate: this._animate,
                    defaultRenderer: new charts.ArcRendererConfig(
                      arcRatio: this._arcRatio,
                      arcRendererDecorators: [
                        charts.ArcLabelDecorator(
                          labelPosition: this._arcLabelPosition,
                        )
                      ],
                    ),
                    behaviors: [
                      // Add title.
                      charts.ChartTitle(
                        'چارت هزینه ماهانه',
                        titleStyleSpec: charts.TextStyleSpec(
                            fontSize: 20,
                            color: charts.Color.white,
                            fontFamily: 'IranSans'),
                        behaviorPosition: this._titlePosition,
                      ),
                      // Add legend. ("Datum" means the "X-axis" of each data point.)
                      charts.DatumLegend(
                        position: this._legendPosition,
                        entryTextStyle: charts.TextStyleSpec(
                            fontSize: 12,
                            color: charts.Color.white,
                            fontFamily: 'IranSans'),
                        desiredMaxRows: 2,
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {
          print(touchResponse);
        },
        handleBuiltInTouches: true,
      ),
      gridData: const FlGridData(
        show: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
              color: const Color(0xff72719b),
              fontWeight: FontWeight.bold,
              fontSize: 15,
              fontFamily: 'IranSans'),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'فرودین';
              case 7:
                return 'اردبیهشت';
              case 12:
                return 'خرداد';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: const Color(0xff75729e),
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'IranSans'),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '۱۰۰';
              case 2:
                return '۲۰۰';
              case 3:
                return '۳۰۰';
              case 4:
                return '۴۰۰';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: const Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    LineChartBarData lineChartBarData1 = const LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
        FlSpot(14, 1)
      ],
      isCurved: true,
      colors: [
        Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: const [
        FlSpot(1, 1),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(
        show: false,
      ),
      belowBarData: const BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
    ];
  }
}
