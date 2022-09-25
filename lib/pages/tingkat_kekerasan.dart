import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:sipudak/widget/my_header.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/my_headerPp.dart';

import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/my_headerPp.dart';

// void main() {
//   runApp(KekerasanChart());
// }

// class KekerasanChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Pie Chart Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//       ),
//       darkTheme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//         brightness: Brightness.dark,
//       ),
//       home: KekerasanChart(),
//     );
//   }
// }

enum LegendShape { Circle, Rectangle }

class KekerasanChart extends StatefulWidget {
  @override
  _KekerasanChartState createState() => _KekerasanChartState();
}

class _KekerasanChartState extends State<KekerasanChart> {
  final dataMap = <String, double>{
    "Galing": 0,
    "Jawai": 3,
    "Jawai Selatan": 2,
    "Paloh": 3,
    "Pemangkat": 2,
    "Sajad": 2,
    "Sajingan Besar": 0,
    "Salatiga": 3,
    "Sambas": 4,
    "Sebawi": 0,
    "Sejangkung": 4,
    "Selakau": 5,
    "Selakau TImur": 2,
    "Semparuk": 1,
    "Subah": 3,
    "Tangaran": 1,
    "Tebas": 8,
    "Tekarang": 2,
    "Teluk Keramat": 4,
  };

  final legendLabels = <String, String>{
    "Galing": "Flutter legend",
    "React": "React legend",
    "Xamarin": "Xamarin legend",
    "Ionic": "Ionic legend",
  };

  final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
    Color.fromRGBO(429, 182, 205, 1),
    Color.fromRGBO(329, 182, 205, 1),
    Color.fromRGBO(229, 182, 205, 1),
    Color.fromRGBO(254, 154, 92, 1),
    Color.fromRGBO(223, 250, 92, 1),
    Color.fromRGBO(191, 353, 199, 1),
    Color.fromRGBO(125, 63, 62, 1.0),
    Color.fromRGBO(213, 140, 93, 1),
    Color.fromRGBO(254, 154, 92, 1),
    Color.fromRGBO(175, 63, 62, 1.0),
    Color.fromRGBO(91, 253, 199, 1),
    Color.fromRGBO(129, 182, 205, 1),
    Color.fromRGBO(223, 250, 92, 1),
    Color.fromRGBO(129, 250, 112, 1),
  ];

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = true;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;
  bool _showLegendLabel = false;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.Circle;
  LegendPosition? _legendPosition = LegendPosition.bottom;

  int key = 0;

  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: math.min(MediaQuery.of(context).size.width / 1.3, 300),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: _showCenterText ? "SAMBAS" : null,
      legendLabels: _showLegendLabel ? legendLabels : {},
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition!,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.Circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,
    );
    // final settings = SingleChildScrollView(
    //   child: Card(
    //     margin: EdgeInsets.all(12),
    //     child: Column(
    //       children: [
    //         SwitchListTile(
    //           value: _showGradientColors,
    //           title: Text("Show Gradient Colors"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showGradientColors = val;
    //             });
    //           },
    //         ),
    //         ListTile(
    //           title: Text(
    //             'Pie Chart Options'.toUpperCase(),
    //             style: Theme.of(context).textTheme.overline!.copyWith(
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text("chartType"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<ChartType>(
    //               value: _chartType,
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("disc"),
    //                   value: ChartType.disc,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("ring"),
    //                   value: ChartType.ring,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _chartType = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text("ringStrokeWidth"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<double>(
    //               value: _ringStrokeWidth,
    //               disabledHint: Text("select chartType.ring"),
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("16"),
    //                   value: 16,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("32"),
    //                   value: 32,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("48"),
    //                   value: 48,
    //                 ),
    //               ],
    //               onChanged: (_chartType == ChartType.ring)
    //                   ? (val) {
    //                       setState(() {
    //                         _ringStrokeWidth = val;
    //                       });
    //                     }
    //                   : null,
    //             ),
    //           ),
    //         ),
    //         SwitchListTile(
    //           value: _showCenterText,
    //           title: Text("showCenterText"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showCenterText = val;
    //             });
    //           },
    //         ),
    //         ListTile(
    //           title: Text("chartLegendSpacing"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<double>(
    //               value: _chartLegendSpacing,
    //               disabledHint: Text("select chartType.ring"),
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("16"),
    //                   value: 16,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("32"),
    //                   value: 32,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("48"),
    //                   value: 48,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("64"),
    //                   value: 64,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _chartLegendSpacing = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text(
    //             'Legend Options'.toUpperCase(),
    //             style: Theme.of(context).textTheme.overline!.copyWith(
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //           ),
    //         ),
    //         SwitchListTile(
    //           value: _showLegendsInRow,
    //           title: Text("showLegendsInRow"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showLegendsInRow = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showLegends,
    //           title: Text("showLegends"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showLegends = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showLegendLabel,
    //           title: Text("showLegendLabels"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showLegendLabel = val;
    //             });
    //           },
    //         ),
    //         ListTile(
    //           title: Text("legendShape"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<LegendShape>(
    //               value: _legendShape,
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("BoxShape.circle"),
    //                   value: LegendShape.Circle,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("BoxShape.rectangle"),
    //                   value: LegendShape.Rectangle,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _legendShape = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text("legendPosition"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<LegendPosition>(
    //               value: _legendPosition,
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("left"),
    //                   value: LegendPosition.left,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("right"),
    //                   value: LegendPosition.right,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("top"),
    //                   value: LegendPosition.top,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("bottom"),
    //                   value: LegendPosition.bottom,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _legendPosition = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text(
    //             'Chart values Options'.toUpperCase(),
    //             style: Theme.of(context).textTheme.overline!.copyWith(
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //           ),
    //         ),
    //         SwitchListTile(
    //           value: _showChartValueBackground,
    //           title: Text("showChartValueBackground"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValueBackground = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showChartValues,
    //           title: Text("showChartValues"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValues = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showChartValuesInPercentage,
    //           title: Text("showChartValuesInPercentage"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValuesInPercentage = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showChartValuesOutside,
    //           title: Text("showChartValuesOutside"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValuesOutside = val;
    //             });
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: ClipPath(
            clipper: MyClipper(),
            child: Container(
                height: 450,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: yellowColor,
                ),
                child:
                    //  AppBar(
                    // elevation: 0.0,
                    // backgroundColor: Colors.white,
                    // title:
                    Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(left: 20, right: 20, top: 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 60, left: 10),
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) => Beranda(),
                                        //     ));
                                      },
                                      icon: Icon(Icons.arrow_back_outlined),
                                      color: Colors.white,
                                      iconSize: 30)),
                              Text(
                                "Data Kasus Kekerasan",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    key = key + 1;
                                  });
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  size: 30,
                                  color: blueColor,
                                ),
                              ),
                            ])))),
        // title: Text("Data Kasus Kekerasan"),
        // actions: [
        //   ElevatedButton(
        //     onPressed: () {
        //       setState(() {
        //         key = key + 1;
        //       });
        //     },
        //     child: Text("Reload".toUpperCase()),
        //   ),
        // ],
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth >= 600) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: chart,
                ),
                // Flexible(
                //   flex: 2,
                //   fit: FlexFit.tight,
                //   child: settings,
                // )
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: chart,
                    margin: EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                  ),
                  // settings,
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
