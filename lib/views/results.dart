import 'dart:async';
import 'dart:math';
import 'package:fcs_predictor/constants/variables.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../constants/units.dart';

class Results extends StatefulWidget {
  Results({Key? key}) : super(key: key);
  List<Color> get availableColors => const <Color>[
        Colors.purple,
        Colors.yellow,
        Colors.blue,
        Colors.green,
        Colors.pink,
      ];

  final Color barBackgroundColor = Colors.blue.shade200.withOpacity(0.3);
  final Color barColor = Colors.grey.shade800;
  final Color touchedBarColor = Colors.green;

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  int len = 5;
  List temp = Variables.temp;
  List prod = Variables.production;
  int start = Variables.start;

  Widget data() {
    return Column(
      children: [
        for (int i = 0; i < len; i++)
          Container(
            padding:
                EdgeInsets.symmetric(vertical: Units.width(context) * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  (start + i).toString(),
                  style: TextStyle(fontSize: Units.regularText(context)),
                ),
                Text(
                  temp[i].toString(),
                  style: TextStyle(fontSize: Units.regularText(context)),
                ),
                Text(
                  prod[i].toString().substring(0, 9),
                  style: TextStyle(fontSize: Units.regularText(context)),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // /  backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(
          child: Text(
            'FCS Predictor',
            style: TextStyle(
                fontSize: Units.heading(context),
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Predicted values',
                          style: TextStyle(
                            color: Color.fromARGB(255, 108, 202, 113),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: BarChart(
                              isPlaying ? randomData() : mainBarData(),
                              swapAnimationDuration: animDuration,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            isPlaying = !isPlaying;
                            if (isPlaying) {
                              refreshState();
                            }
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Units.height(context) * 0.06,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: Units.width(context) * 0.03,
                  horizontal: Units.width(context) * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Year",
                    style: TextStyle(
                        fontSize: Units.regularText(context),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Temperature",
                    style: TextStyle(
                        fontSize: Units.regularText(context),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Production",
                    style: TextStyle(
                        fontSize: Units.regularText(context),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            data(),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.black, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(5, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, (prod[i] - 3.8) * 100000,
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, (prod[i] - 3.8) * 100000,
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, (prod[i] - 3.8) * 100000,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, (prod[i] - 3.8) * 100000,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, (prod[i] - 3.8) * 100000,
                isTouched: i == touchedIndex);

          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String year;
            switch (group.x) {
              case 0:
                year = start.toString();
                break;
              case 1:
                year = (start + 1).toString();
                break;
              case 2:
                year = (start + 2).toString();
                break;
              case 3:
                year = (start + 3).toString();
                break;
              case 4:
                year = (start + 4).toString();
                break;

              default:
                throw Error();
            }
            return BarTooltipItem(
              '$year\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    int s = start;
    switch (value.toInt()) {
      case 0:
        text = Text((s).toString(), style: style);
        break;
      case 1:
        text = Text((s + 1).toString(), style: style);
        break;
      case 2:
        text = Text((s + 2).toString(), style: style);
        break;
      case 3:
        text = Text((s + 3).toString(), style: style);
        break;
      case 4:
        text = Text((s + 4).toString(), style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(5, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );

          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}
