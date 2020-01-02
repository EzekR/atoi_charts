import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() {
  // Register your license here
  SyncfusionLicense.registerLicense(null);
  return runApp(ChartApp());
}

class ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
                  title: ChartTitle(
                      text: 'Automatic RangeCalculation',
                      alignment: ChartAlignment.center,
                      borderColor: Colors.transparent,
                      borderWidth: 0),
                  legend: Legend(
                      position: LegendPosition.bottom,
                      borderColor: Colors.white,
                      borderWidth: 0),
                  primaryXAxis: NumericAxis(
                     visibleMinimum: 300,
                     visibleMaximum: 500,
                      title: AxisTitle(
                        text: 'Gain',
                        textStyle: ChartTextStyle(color: Colors.black),
                        alignment: ChartAlignment.center,
                      )),
                  primaryYAxis: NumericAxis(
         
                    labelStyle: ChartTextStyle(color: Colors.black),
                    title: AxisTitle(
                        text: 'Sales',
                        textStyle: ChartTextStyle(color: Colors.black),
                        alignment: ChartAlignment.center),
                  ),
                  series: getRandomData()),
    );
  }

   static List<SplineSeries<OrdinalSales, num>> getRandomData() {
    final dynamic chartData = <OrdinalSales>[
      OrdinalSales(100, 10),
      OrdinalSales(200, 20),
      OrdinalSales(300, 40),
      OrdinalSales(400, 30),
      OrdinalSales(500, 45),
      OrdinalSales(600, 50),
      OrdinalSales(700, 38),
      OrdinalSales(800, 10)
    ];
    return <SplineSeries<OrdinalSales, num>>[
      SplineSeries<OrdinalSales, num>(
          dataSource: chartData,
          color: const Color.fromRGBO(255, 0, 102, 1),
          xValueMapper: (OrdinalSales sales, _) => sales.year,
          yValueMapper: (OrdinalSales sales, _) => sales.sales,
          markerSettings: MarkerSettings(isVisible: true)),
    ];
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}


class OrdinalSales {
  OrdinalSales(this.year, this.sales);
  final num year;
  final int sales;
}