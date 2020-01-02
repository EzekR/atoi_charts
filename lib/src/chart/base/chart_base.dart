part of charts;

/// Returns the TooltipArgs.
typedef ChartTooltipCallback = void Function(TooltipArgs tooltipArgs);

/// Returns the ActualRangeChangedArgs.
typedef ChartActualRangeChangedCallback = void Function(
    ActualRangeChangedArgs rangeChangedArgs);

/// Returns the AxisLabelRenderArgs.
typedef ChartAxisLabelRenderCallback = void Function(
    AxisLabelRenderArgs axisLabelRenderArgs);

/// Returns the DataLabelRenderArgs.
typedef ChartDataLabelRenderCallback = void Function(
    DataLabelRenderArgs dataLabelArgs);

/// Returns the LegendRenderArgs.
typedef ChartLegendRenderCallback = void Function(
    LegendRenderArgs legendRenderArgs);

///Returns the TrackballArgs.
typedef ChartTrackballCallback = void Function(TrackballArgs trackballArgs);

/// Returns the CrosshairRenderArgs
typedef ChartCrosshairCallback = void Function(
    CrosshairRenderArgs crosshairArgs);

/// Returns the ZoomPanArgs.
typedef ChartZoomingCallback = void Function(ZoomPanArgs zoomingArgs);

/// Returns the  PointTapArgs.
typedef ChartPointTapCallback = void Function(PointTapArgs pointTapArgs);

/// Returns the  AxisLabelTapArgs.
typedef ChartAxisLabelTapCallback = void Function(
    AxisLabelTapArgs axisLabelTapArgs);

/// Returns the  LegendTapArgs.
typedef ChartLegendTapCallback = void Function(LegendTapArgs legendTapArgs);

/// Returns the SelectionArgs.
typedef ChartSelectionCallback = void Function(SelectionArgs selectionArgs);

/// Returns the offset.
typedef ChartTapCallback = void Function(Offset tapArgs);

///Renders the cartesian type chart
///
///```dart
///Widget build(BuildContext context) {
///  return Center(
///    child:SfCartesianChart(
///      title: ChartTitle(text: 'Flutter Chart'),
///     legend: Legend(isVisible: true),
///     series: getDefaultData(),
///     tooltipBehavior: TooltipBehavior(enable: true),
///    )
/// );
///}
///static List<LineSeries<SalesData, num>> getDefaultData() {
///    final dynamic chartData = <SalesData>[
///      SalesData(DateTime(2005, 0, 1), 'India', 1.5, 21, 28, 680, 760),
///      SalesData(DateTime(2006, 0, 1), 'China', 2.2, 24, 44, 550, 880),
///      SalesData(DateTime(2007, 0, 1), 'USA', 3.32, 36, 48, 440, 788),
///      SalesData(DateTime(2008, 0, 1), 'Japan', 4.56, 38, 50, 350, 560),
///      SalesData(DateTime(2009, 0, 1), 'Russia', 5.87, 54, 66, 444, 566),
///      SalesData(DateTime(2010, 0, 1), 'France', 6.8, 57, 78, 780, 650),
///     SalesData(DateTime(2011, 0, 1), 'Germany', 8.5, 70, 84, 450, 800)
///    ];
///   return <LineSeries<SalesData, num>>[
///      LineSeries<SalesData, num>(
///          enableToolTip: isTooltipVisible,
///          dataSource: chartData,
///          xValueMapper: (SalesData sales, _) => sales.numeric,
///          yValueMapper: (SalesData sales, _) => sales.sales1,
///          width: lineWidth ?? 2,
///          enableAnimation: false,
///         markerSettings: MarkerSettings(
///              isVisible: isMarkerVisible,
///              height: markerWidth ?? 4,
///              width: markerHeight ?? 4,
///              shape: DataMarkerType.Circle,
///              borderWidth: 3,
///              borderColor: Colors.red),
///          dataLabelSettings: DataLabelSettings(
///              visible: isDataLabelVisible, position: ChartDataLabelAlignment.Auto)),
///      LineSeries<SalesData, num>(
///          enableToolTip: isTooltipVisible,
///          dataSource: chartData,
///          enableAnimation: false,
///          width: lineWidth ?? 2,
///          xValueMapper: (SalesData sales, _) => sales.numeric,
///          yValueMapper: (SalesData sales, _) => sales.sales2,
///          markerSettings: MarkerSettings(
///              isVisible: isMarkerVisible,
///              height: markerWidth ?? 4,
///              width: markerHeight ?? 4,
///              shape: DataMarkerType.Circle,
///              borderWidth: 3,
///              borderColor: Colors.black),
///          dataLabelSettings: DataLabelSettings(
///              isVisible: isDataLabelVisible, position: ChartDataLabelAlignment.Auto))
///    ];
///  }
///  ```
///
// ignore: must_be_immutable
class SfCartesianChart extends StatefulWidget {
  SfCartesianChart(
      {Key key,
      this.backgroundColor = Colors.transparent,
      this.enableSideBySideSeriesPlacement = true,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0,
      this.plotAreaBackgroundColor,
      this.plotAreaBorderColor = const Color.fromRGBO(219, 219, 219, 1),
      this.plotAreaBorderWidth = 0.7,
      this.plotAreaBackgroundImage,
      this.onTooltipRender,
      this.onActualRangeChanged,
      this.onAxisLabelRender,
      this.onDataLabelRender,
      this.onLegendItemRender,
      this.onTrackballPositionChanging,
      this.onCrosshairPositionChanging,
      this.onZooming,
      this.onZoomStart,
      this.onZoomEnd,
      this.onZoomReset,
      this.onPointTapped,
      this.onAxisLabelTapped,
      this.onLegendTapped,
      this.onSelectionChanged,
      this.onChartTapped,
      this.isTransposed = false,
      this.annotations,
      this.palette = const <Color>[
        Color.fromRGBO(53, 92, 125, 1),
        Color.fromRGBO(192, 108, 132, 1),
        Color.fromRGBO(246, 114, 128, 1),
        Color.fromRGBO(248, 177, 149, 1),
        Color.fromRGBO(116, 180, 155, 1),
        Color.fromRGBO(0, 168, 181, 1),
        Color.fromRGBO(73, 76, 162, 1),
        Color.fromRGBO(255, 205, 96, 1),
        Color.fromRGBO(255, 240, 219, 1),
        Color.fromRGBO(238, 238, 238, 1)
      ],
      ChartAxis primaryXAxis,
      ChartAxis primaryYAxis,
      EdgeInsets margin,
      TooltipBehavior tooltipBehavior,
      ZoomPanBehavior zoomPanBehavior,
      Legend legend,
      SelectionType selectionType,
      ActivationMode selectionGesture,
      bool enableMultiSelection,
      CrosshairBehavior crosshairBehavior,
      TrackballBehavior trackballBehavior,
      dynamic series,
      ChartTitle title,
      List<ChartAxis> axes})
      : primaryXAxis = primaryXAxis ?? NumericAxis(),
        primaryYAxis = primaryYAxis ?? NumericAxis(),
        title = title ?? ChartTitle(),
        axes = axes ?? <ChartAxis>[],
        series = series ?? <ChartSeries<dynamic, dynamic>>[],
        margin = margin ?? const EdgeInsets.all(10),
        zoomPanBehavior = zoomPanBehavior ?? ZoomPanBehavior(),
        tooltipBehavior = tooltipBehavior ?? TooltipBehavior(),
        crosshairBehavior = crosshairBehavior ?? CrosshairBehavior(),
        trackballBehavior = trackballBehavior ?? TrackballBehavior(),
        legend = legend ?? Legend(),
        selectionType = selectionType ?? SelectionType.point,
        selectionGesture = selectionGesture ?? ActivationMode.singleTap,
        enableMultiSelection = enableMultiSelection ?? false,
        super(key: key) {
    _chartAxis = _ChartAxis();
    _chartSeries = _ChartSeries();
    _chartLegend = _ChartLegend();
    _chartTheme = _ChartTheme();
    _containerArea = _ContainerArea();
  }

  ///Customizes the chart title
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            title: ChartTitle(
  ///                    text: 'Area with animation',
  ///                    alignment: ChartAlignment.center,
  ///                    backgroundColor: Colors.white,
  ///                    borderColor: Colors.transparent,
  ///                    borderWidth: 0)
  ///        ));
  ///}
  ///```
  final ChartTitle title;

  ///Customizes the legend in the chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(isVisible: true),
  ///        ));
  ///}
  ///```
  final Legend legend;

  ///Background color of the chart.
  ///
  ///Defaults to Colors.transparent
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            backgroundColor: Colors.blue
  ///        ));
  ///}
  ///```
  final Color backgroundColor;

  ///Color of the chart border.
  ///
  ///Defaults to Colors.transparent
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            borderColor: Colors.red
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Width of the chart border.
  ///
  ///Defaults to 0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            borderColor: Colors.red,
  ///            borderWidth: 2
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Background color of the plot area.
  ///
  ///Defaults to Colors.transparent
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            plotAreaBackgroundColor: Colors.red,
  ///        ));
  ///}
  ///```
  final Color plotAreaBackgroundColor;

  ///Border color of the plot area.
  ///
  ///Defaults to Colors.grey
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            plotAreaBorderColor: Colors.red,
  ///        ));
  ///}
  ///```
  final Color plotAreaBorderColor;

  ///Border width of the plot area.
  ///
  ///Defaults to 0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            plotAreaBorderColor: Colors.red,
  ///            plotAreaBorderWidth: 2
  ///        ));
  ///}
  ///```
  final double plotAreaBorderWidth;

  ///Customizes the primary x-axis in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: DateTimeAxis(interval: 1)
  ///        ));
  ///}
  ///```
  final ChartAxis primaryXAxis;

  ///Customizes the primary y-axis in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryYAxis: NumericAxis(isinversed: false)
  ///        ));
  ///}
  ///```
  final ChartAxis primaryYAxis;

  ///Margin for chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            margin: const EdgeInsets.all(2),
  ///            borderColor: Colors.blue
  ///        ));
  ///}
  ///```
  final EdgeInsets margin;

  ///Customizes the additional axes in the chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///             axes: <ChartAxis>[
  ///                NumericAxis(
  ///                             majorGridLines: MajorGridLines(
  ///                                     color: Colors.transparent)
  ///                             )]
  ///        ));
  ///}
  ///```
  final List<ChartAxis> axes;

  ///Enables or disables the placing of series side by side.
  ///
  ///Defaults to true.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           enableSideBySideSeriesPlacement: false
  ///        ));
  ///}
  ///```
  final bool enableSideBySideSeriesPlacement;

  /// Occurs while tooltip is rendered. You can customize the position and header.
  /// Here, you can get the text, header, point index, series, x and y-positions.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            tooltipBehavior: TooltipBehavior(enable: true)
  ///            onTooltipRender: (TooltipArgs args) => tool(args)
  ///        ));
  ///}
  ///dynamic tool(TooltipArgs args) {
  ///   args.locationX = 30;
  ///}
  ///```
  final ChartTooltipCallback onTooltipRender;

  /// Occurs when the visible range of an axis is changed, i.e. value changes for minimum,
  ///  maximum, and interval. Here, you can get the actual and visible range of an axis.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onActualRangeChanged: (ActualRangeChangedArgs args) => range(args)
  ///        ));
  ///}
  ///dynamic range(ActualRangeChangedArgs args) {
  ///   print(args.visibleMin);
  ///}
  ///```
  final ChartActualRangeChangedCallback onActualRangeChanged;

  /// Occurs while rendering the axis labels. Text and text styles such as color, font size,
  /// and font weight can be customized.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onAxisLabelRender: (AxisLabelRenderArgs args) => axis(args),
  ///        ));
  ///}
  ///dynamic axis(AxisLabelRenderArgs args) {
  ///   args.text = 'axis Label';
  ///}
  ///```
  final ChartAxisLabelRenderCallback onAxisLabelRender;

  /// Occurs when tapping the axis label. Here, you can get the appropriate axis that is
  /// tapped and the axis label text.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onDataLabelRender: (DataLabelRenderArgs args) => dataLabel(args),
  ///        ));
  ///}
  ///dynamic dataLabel(DataLabelRenderArgs args) {
  ///   args.text = 'data Label';
  ///}
  ///```
  final ChartDataLabelRenderCallback onDataLabelRender;

  /// Occurs when the legend item is rendered. Here, you can get the legend’s text,
  /// shape, series index, and point index of circular series.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(isVisible: true),
  ///            onLegendItemRender: (LegendRenderArgs args) => legend(args)
  ///        ));
  ///}
  ///dynamic legend(LegendRenderArgs args) {
  ///   args.seriesIndex = 2;
  ///}
  ///```
  final ChartLegendRenderCallback onLegendItemRender;

  /// Occurs while the trackball position is changed. Here, you can customize the text of
  /// the trackball.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            trackballBehavior: TrackballBehavior(enable: true),
  ///            onTrackballPositionChanging: (TrackballArgs args) => trackball(args)
  ///        ));
  ///}
  ///dynamic trackball(TrackballArgs args) {
  ///    args.chartPointInfo = ChartPointInfo();
  ///}
  ///```
  final ChartTrackballCallback onTrackballPositionChanging;

  /// Occurs when tapping the axis label. Here, you can get the appropriate axis that is
  /// tapped and the axis label text.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            crosshairBehavior: CrosshairBehavior(enable: true),
  ///            onCrosshairPositionChanging: (CrosshairRenderArgs args) => crosshair(args)
  ///        ));
  ///}
  ///dynamic crosshair(CrosshairRenderArgs args) {
  ///    args.text = 'crosshair';
  ///}
  ///```
  final ChartCrosshairCallback onCrosshairPositionChanging;

  /// Occurs when zooming action begins. You can customize the zoom factor and zoom
  /// position of an axis. Here, you can get the axis, current zoom factor, current
  /// zoom position, previous zoom factor, and previous zoom position.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true),
  ///            onZoomStart: (ZoomPanArgs args) => zoom(args),
  ///        ));
  ///}
  ///dynamic zoom(ZoomPanArgs args) {
  ///    args.currentZoomFactor = 0.2;
  ///}
  ///```
  final ChartZoomingCallback onZoomStart;

  /// Occurs when the zooming action is completed. Here, you can get the axis, current
  /// zoom factor, current zoom position, previous zoom factor, and previous zoom position.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true),
  ///            onZoomEnd: (ZoomPanArgs args) => zoom(args),
  ///        ));
  ///}
  ///dynamic zoom(ZoomPanArgs args) {
  ///    print(args.currentZoomPosition);
  ///}
  ///```
  final ChartZoomingCallback onZoomEnd;

  /// Occurs when zoomed state is reset. Here, you can get the axis, current zoom factor,
  /// current zoom position, previous zoom factor, and previous zoom position.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true),
  ///            onZoomReset: (ZoomPanArgs args) => zoom(args),
  ///        ));
  ///}
  ///dynamic zoom(ZoomPanArgs args) {
  ///    print(args.currentZoomPosition);
  ///}
  ///```
  final ChartZoomingCallback onZoomReset;

  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true),
  ///            onZooming: (ZoomPanArgs args) => zoom(args),
  ///        ));
  ///}
  ///dynamic zoom(ZoomPanArgs args) {
  ///    print(args.currentZoomPosition);
  ///}
  ///```
  final ChartZoomingCallback onZooming;

  /// Occurs when tapping the series point. Here, you can get the series, series index
  /// and point index.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onPointTapped: (PointTapArgs args) => point(args),
  ///        ));
  ///}
  ///dynamic point(PointTapArgs args) {
  ///   print(args.seriesIndex);
  ///}
  ///```

  final ChartPointTapCallback onPointTapped;

  /// Occurs when tapping the axis label. Here, you can get the appropriate axis that is
  /// tapped and the axis label text.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onAxisLabelTapped: (AxisLabelTapArgs args) => axis(args),
  ///        ));
  ///}
  ///dynamic axis(AxisLabelTapArgs args) {
  ///   print(args.text);
  ///}
  ///```
  final ChartAxisLabelTapCallback onAxisLabelTapped;

  /// Occurs when the legend item is rendered. Here, you can get the legend’s text,
  /// shape, series index, and point index of circular series.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onLegendTapped: (LegendTapArgs args) => legend(args),
  ///        ));
  ///}
  ///dynamic legend(LegendTapArgs args) {
  ///   print(args.pointIndex);
  ///}
  ///```
  final ChartLegendTapCallback onLegendTapped;

  /// Occurs while selection changes. Here, you can get the series, selected color,
  /// unselected color, selected border color, unselected border color, selected border
  ///  width, unselected border width, series index, and point index.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onSelectionChanged: (SelectionArgs args) => print(args.selectedColor),
  ///        ));
  ///}
  final ChartSelectionCallback onSelectionChanged;

  /// Occurs when tapped on the chart area.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            onChartTapped: (Offset args){
  ///               print(args.dx.toString());
  ///               print(args.dy.toString());
  ///             }
  ///        ));
  ///}
  ///```
  final ChartTapCallback onChartTapped;

  ///Customizes the tooltip in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            tooltipBehavior: TooltipBehavior(enable: true)
  ///        ));
  ///}
  ///```
  final TooltipBehavior tooltipBehavior;

  ///Customizes the crosshair in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            crosshairBehavior: CrosshairBehavior(enable: true),
  ///        ));
  ///}
  ///```
  final CrosshairBehavior crosshairBehavior;

  ///Customizes the trackball in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            trackballBehavior: TrackballBehavior(enable: true),
  ///        ));
  ///}
  ///```
  final TrackballBehavior trackballBehavior;

  ///Customizes the zooming and panning settings.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            zoomPanBehavior: ZoomPanBehavior( enablePanning: true),
  ///        ));
  ///}
  ///```
  final ZoomPanBehavior zoomPanBehavior;

  ///Mode of selecting the data points or series.
  ///
  ///Defaults to SelectionType.point
  ///
  ///Also refer [SelectionType]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionType: SelectionType.series,
  ///        ));
  ///}
  ///```
  final SelectionType selectionType;

  ///Customizes the annotations. Annotations are used to mark the specific area of interest
  /// in the plot area with texts, shapes, or images.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            annotations: <CartesianChartAnnotation>[
  ///                CartesianChartAnnotation(
  ///                    child: Container(
  ///                    child: const Text('Empty data')),
  ///                    coordinateUnit: CoordinateUnit.point,
  ///                    region: AnnotationRegion.chartArea,
  ///                    x: 3.5,
  ///                    y: 60
  ///                 ),
  ///             ],
  ///        ));
  ///}
  ///```
  final List<CartesianChartAnnotation> annotations;

  ///Enables or disables the multiple data points or series selection.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            enableMultiSelection: true,
  ///            series: <BarSeries<SalesData, num>>[
  ///                BarSeries<SalesData, num>(
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool enableMultiSelection;

  ///Gesture for activating the selection. Selection can be activated in tap,
  ///double tap, and long press.
  ///
  ///Defaults to ActivationMode.tap
  ///
  ///Also refer [ActivationMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <BarSeries<SalesData, num>>[
  ///                BarSeries<SalesData, num>(
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ActivationMode selectionGesture;

  ///Background image for chart.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            plotAreaBackgroundImage: const AssetImage('images/bike.png'),
  ///        ));
  ///}
  ///```
  final ImageProvider plotAreaBackgroundImage;

  ///Data points or series can be selected while performing interaction on the chart.
  ///It can also be selected at the initial rendering using this property.
  ///
  ///Defaults to []
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           series: <BarSeries<SalesData, num>>[
  ///                BarSeries<SalesData, num>(
  ///                 initialSelectedDataIndexes: <int>[2, 0],
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```

  ///By setting this, the orientation of x-axis is set to vertical and orientation of
  ///y-axis is set to horizontal.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            isTransposed: true,
  ///        ));
  ///}
  ///```
  final bool isTransposed;

  ///Customizes the series in chart.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           series: <ChartSeries<SalesData, num>>[
  ///                AreaSeries<SalesData, num>(
  ///                    dataSource: chartData,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final List<ChartSeries<dynamic, dynamic>> series;

  ///Color palette for chart series. If the series color is not specified, then the series
  ///will be rendered with appropriate palette color. Ten colors are available by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            palette: <Color>[Colors.red, Colors.green]
  ///        ));
  ///}
  ///```
  final List<Color> palette;

  /// Setting series animation duration factor
  final double _seriesDurationFactor = 0.85;

  /// Holds the information of chart state class
  _SfCartesianChartState _chartState;

  /// Whether to check chart axis is inverted or not
  bool _requireInvertedAxis;

  /// Holds the information of AxisBase class
  _ChartAxis _chartAxis;

  /// Holds the information of SeriesBase class
  _ChartSeries _chartSeries;

  /// Holds the information of LegendBase class
  _ChartLegend _chartLegend;

  /// Holds the information of ChartTheme class
  _ChartTheme _chartTheme;

  /// Holds the information of _ContainerArea class
  // ignore:unused_field
  _ContainerArea _containerArea;

  //ignore: prefer_final_fields
  List<_ChartPointInfo> _chartPointInfo = <_ChartPointInfo>[];

  @override
  State<StatefulWidget> createState() => _SfCartesianChartState();
}

class _SfCartesianChartState extends State<SfCartesianChart>
    with TickerProviderStateMixin {
  /// Animation controller for series
  AnimationController animationController;

  /// Holds the animation controller list for all series
  List<AnimationController> controllerList;

  /// Repaint notifier for zoom container
  ValueNotifier<int> zoomRepaintNotifier;

  /// Repaint notifier for axis container
  ValueNotifier<int> axisRepaintNotifier;

  /// Repaint notifier for series container
  ValueNotifier<int> seriesRepaintNotifier;

  /// Repaint notifier for tooltip container
  ValueNotifier<int> tooltipRepaintNotifier;

  /// Repaint notifier for trackball container
  ValueNotifier<int> trackballRepaintNotifier;

  /// Repaint notifier for crosshair container
  ValueNotifier<int> crosshairRepaintNotifier;

  /// To measure legend size and position
  List<_MeasureWidgetContext> legendWidgetContext;

  /// Chart Template info
  List<_ChartTemplateInfo> templates;
  List<ChartAxis> zoomedAxisStates;

  /// Contains chart container size
  Rect containerRect;
  bool zoomProgress;
  List<_ZoomAxisRange> zoomAxes;
  bool initialRender;
  List<_LegendRenderContext> legendToggleStates;
  List<ChartSegment> selectedSegments;
  List<ChartSegment> unselectedSegments;
  List<_MeasureWidgetContext> legendToggleTemplateStates;
  List<Rect> renderDatalabelRegions;
  Orientation deviceOrientation;
  List<Rect> dataLabelTemplateRegions;
  List<Rect> annotationRegions;
  bool animateCompleted;
  bool widgetNeedUpdate;
  _DataLabelRenderer renderDataLabel;
  List<ChartSeries<dynamic, dynamic>> prevWidgetSeries;
  bool _isLegendToggled;
  List<ChartSegment> segments;
  List<bool> _oldSeriesVisible;
  bool zoomedState;
  Animation<double> chartElementAnimation;
  List<PointerEvent> _touchStartPositions;
  List<PointerEvent> _touchMovePositions;
  bool _enableDoubleTap;
  Orientation _oldDeviceOrientation;
  bool _legendToggling;
  dart_ui.Image _backgroundImage;
  dart_ui.Image _legendIconImage;

  void _initializeDefaultValues() {
    controllerList = <AnimationController>[];
    zoomRepaintNotifier = ValueNotifier<int>(0);
    axisRepaintNotifier = ValueNotifier<int>(0);
    seriesRepaintNotifier = ValueNotifier<int>(0);
    tooltipRepaintNotifier = ValueNotifier<int>(0);
    trackballRepaintNotifier = ValueNotifier<int>(0);
    crosshairRepaintNotifier = ValueNotifier<int>(0);
    legendWidgetContext = <_MeasureWidgetContext>[];
    templates = <_ChartTemplateInfo>[];
    zoomedAxisStates = <ChartAxis>[];
    zoomAxes = <_ZoomAxisRange>[];
    containerRect = const Rect.fromLTRB(0, 0, 0, 0);
    zoomProgress = false;
    initialRender = true;
    legendToggleStates = <_LegendRenderContext>[];
    selectedSegments = <ChartSegment>[];
    unselectedSegments = <ChartSegment>[];
    legendToggleTemplateStates = <_MeasureWidgetContext>[];
    renderDatalabelRegions = <Rect>[];
    dataLabelTemplateRegions = <Rect>[];
    annotationRegions = <Rect>[];
    animateCompleted = false;
    widgetNeedUpdate = false;
    prevWidgetSeries = <ChartSeries<dynamic, dynamic>>[];
    _isLegendToggled = false;
    _oldSeriesVisible = <bool>[];
    _touchStartPositions = <PointerEvent>[];
    _touchMovePositions = <PointerEvent>[];
    _enableDoubleTap = false;
    _legendToggling = false;
  }

  @override
  void initState() {
    _initializeDefaultValues();
    super.initState();
  }

  @override
  void didUpdateWidget(SfCartesianChart oldWidget) {
    _needsRepaintChart(widget, oldWidget);
    _isLegendToggled = false;
    if (widget._chartState != null &&
        widget._chartState.legendWidgetContext != null &&
        widget._chartState.legendWidgetContext.isNotEmpty) {
      widget._chartState.legendWidgetContext.clear();
    }
    _oldDeviceOrientation = oldWidget._chartState.deviceOrientation;
    initialRender = false;
    widgetNeedUpdate = true;
    prevWidgetSeries = oldWidget._chartSeries.visibleSeries;
    super.didUpdateWidget(oldWidget);
  }

  void _refresh() {
    if (widget._chartState.legendWidgetContext.isNotEmpty) {
      for (int i = 0; i < widget._chartState.legendWidgetContext.length; i++) {
        final _MeasureWidgetContext templateContext =
            widget._chartState.legendWidgetContext[i];
        final RenderBox renderBox = templateContext.context.findRenderObject();
        templateContext.size = renderBox.size;
      }
      setState(() {});
    }
  }

  void _redraw() {
    widget._chartState.initialRender = false;
    if (widget._chartState._isLegendToggled) {
      widget._chartState.segments = <ChartSegment>[];
      widget._chartState._oldSeriesVisible =
          List<bool>(widget._chartSeries.visibleSeries.length);
      for (int i = 0; i < widget._chartSeries.visibleSeries.length; i++) {
        final CartesianSeries<dynamic, dynamic> series =
            widget._chartSeries.visibleSeries[i];
        for (int j = 0; j < series.segments.length; j++) {
          widget._chartState.segments.add(series.segments[j]);
        }
      }
    }
    if (widget._chartState.zoomedAxisStates != null &&
        widget._chartState.zoomedAxisStates.isNotEmpty) {
      zoomedState = true;
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    if (controllerList != null) {
      for (int index = 0; index < controllerList.length; index++) {
        controllerList[index].dispose();

        /// Need to dispose all the animation controller instance otherwise it will cause memory leak
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget._chartState = this;
    final ThemeData theme = Theme.of(context);
    widget._chartTheme.initializeChartTheme(theme);
    _findVisibleSeries(context);
    return _ChartContainer(
        child: Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          border:
              Border.all(color: widget.borderColor, width: widget.borderWidth)),
      child: Container(
          margin: EdgeInsets.fromLTRB(widget.margin.left, widget.margin.top,
              widget.margin.right, widget.margin.bottom),
          child: Column(
            children: <Widget>[_renderTitle(), _renderChartElements()],
          )),
    ));
  }

  Widget _renderTitle() {
    Widget titleWidget;
    if (widget.title.text != null && widget.title.text.isNotEmpty) {
      final Paint titleBackground = Paint()
        ..color = widget.title.borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = widget.title.borderWidth;
      final ChartTextStyle titleStyle = _getTextStyle(
          textStyle: widget.title.textStyle,
          background: titleBackground,
          fontColor: widget.title.textStyle.color ??
              widget._chartTheme.chartTitleColor);
      final TextStyle textStyle = TextStyle(
          color: titleStyle.color,
          fontSize: titleStyle.fontSize,
          fontFamily: titleStyle.fontFamily,
          fontStyle: titleStyle.fontStyle,
          fontWeight: titleStyle.fontWeight);
      titleWidget = Container(
        child: Container(
          child: Text(widget.title.text,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              textScaleFactor: 1.2,
              style: textStyle),
          decoration: BoxDecoration(
              color: widget.title.backgroundColor ??
                  widget._chartTheme.titleBackgroundColor,
              border: Border.all(
                  color: widget.title.borderWidth == 0
                      ? Colors.transparent
                      : widget.title.borderColor ??
                          widget._chartTheme.chartTitleColor,
                  width: widget.title.borderWidth)),
        ),
        alignment: (widget.title.alignment == ChartAlignment.near)
            ? Alignment.topLeft
            : (widget.title.alignment == ChartAlignment.far)
                ? Alignment.topRight
                : (widget.title.alignment == ChartAlignment.center)
                    ? Alignment.topCenter
                    : Alignment.topCenter,
      );
    } else {
      titleWidget = Container();
    }
    return titleWidget;
  }

  /// To arrange the chart area and legend area based on the legend position
  Widget _renderChartElements() {
    if (widget.plotAreaBackgroundImage != null || widget.legend.image != null)
      _getImage(widget);
    return Expanded(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        Widget element;
        if (widget._chartState.deviceOrientation != null &&
            widget._chartState.deviceOrientation !=
                MediaQuery.of(context).orientation) {
          widget._chartState.deviceOrientation =
              MediaQuery.of(context).orientation;
        } else {
          widget._chartState.selectedSegments = <ChartSegment>[];
          widget._chartState.unselectedSegments = <ChartSegment>[];
          widget._chartState.deviceOrientation =
              MediaQuery.of(context).orientation;
        }
        final List<Widget> legendTemplates =
            _bindCartesianLegendTemplateWidgets();
        if (legendTemplates.isNotEmpty && legendWidgetContext.isEmpty) {
          element = Container(child: Stack(children: legendTemplates));
          SchedulerBinding.instance.addPostFrameCallback((_) => _refresh());
        } else {
          _initialize(constraints);
          widget._chartLegend
              ._calculateLegendBounds(widget._chartLegend.chartSize);
          element =
              _getElements(widget, _ContainerArea(chart: widget), constraints);
        }
        return element;
      }),
    );
  }

  List<Widget> _bindCartesianLegendTemplateWidgets() {
    Widget legendWidget;
    final List<Widget> templates = <Widget>[];
    if (widget.legend.isVisible && widget.legend.legendItemBuilder != null) {
      for (int i = 0; i < widget.series.length; i++) {
        final CartesianSeries<dynamic, dynamic> series = widget.series[i];
        if (series.isVisibleInLegend) {
          legendWidget = widget.legend
              .legendItemBuilder(series._seriesName, series, null, i);
          templates.add(_MeasureWidgetSize(
              chart: widget,
              seriesIndex: i,
              pointIndex: null,
              type: 'Legend',
              currentKey: GlobalKey(),
              currentWidget: legendWidget,
              opacityValue: 0.0));
        }
      }
    }
    return templates;
  }

  void _initialize(BoxConstraints constraints) {
    widget._chartLegend.chart = widget;
    widget._chartSeries.chart = widget;
    widget._chartAxis._chartWidget = widget;
    final double width = constraints.maxWidth;
    final double height = constraints.maxHeight;
    widget.legend.legendPosition =
        (widget.legend.position == LegendPosition.auto)
            ? (height > width ? LegendPosition.bottom : LegendPosition.right)
            : widget.legend.position;
    final LegendPosition position = widget.legend.legendPosition;
    final double widthPadding =
        position == LegendPosition.left || position == LegendPosition.right
            ? 5
            : 0;
    final double heightPadding =
        position == LegendPosition.top || position == LegendPosition.bottom
            ? 5
            : 0;
    widget._chartLegend.chartSize =
        Size(width - widthPadding, height - heightPadding);
  }

  void _findVisibleSeries(BuildContext context) {
    bool _legendCheck = false;
    widget._chartSeries.visibleSeries = <CartesianSeries<dynamic, dynamic>>[];
    for (int i = 0; i < widget.series.length; i++) {
      widget.series[i]._seriesName = widget.series[i].name ?? 'Series $i';
      if (widget._chartState.initialRender ||
          (widget._chartState.widgetNeedUpdate &&
              !widget._chartState._legendToggling &&
              (widget._chartState._oldDeviceOrientation ==
                  MediaQuery.of(context).orientation))) {
        widget.series[i]._visible =
            widget._chartState.prevWidgetSeries.isNotEmpty &&
                    widget._chartState.prevWidgetSeries.length > i &&
                    widget._chartState.prevWidgetSeries[i].isVisible ==
                        widget.series[i].isVisible
                ? widget._chartState.prevWidgetSeries[i]._visible
                : widget._chartState.initialRender
                    ? widget.series[i].isVisible
                    : widget.series[i]._visible ?? widget.series[i].isVisible;
      } else {
        if (widget._chartState._oldSeriesVisible.isNotEmpty) {
          widget._chartState._oldSeriesVisible[i] = widget.series[i]._visible;
        }
        _legendCheck = true;
      }
      if (i == 0 ||
          (!widget.series[0].runtimeType.toString().contains('Bar') &&
              !widget.series[i].runtimeType.toString().contains('Bar')) ||
          (widget.series[0].runtimeType.toString().contains('Bar') &&
              (widget.series[i].runtimeType.toString().contains('Bar')))) {
        widget._chartSeries.visibleSeries.add(widget.series[i]);
        if (_legendCheck)
          widget
                  ._chartSeries
                  .visibleSeries[widget._chartSeries.visibleSeries.length - 1]
                  ._visible =
              _checkWithLegendToggleState(
                  widget._chartSeries.visibleSeries.length - 1,
                  widget
                      ._chartSeries
                      .visibleSeries[
                          widget._chartSeries.visibleSeries.length - 1]
                      ._visible);
      }
      _legendCheck = false;
    }
  }

  bool _checkWithLegendToggleState(int seriesIndex, bool seriesVisible) {
    bool seriesRender;
    if (widget.legend.legendItemBuilder != null) {
      final List<_MeasureWidgetContext> legendToggles =
          widget._chartState.legendToggleTemplateStates;
      if (legendToggles.isNotEmpty) {
        for (int j = 0; j < legendToggles.length; j++) {
          final _MeasureWidgetContext item = legendToggles[j];
          if (seriesIndex == item.seriesIndex) {
            seriesRender = false;
            break;
          }
        }
      }
    } else {
      if (widget._chartState.legendToggleStates.isNotEmpty) {
        for (int j = 0; j < widget._chartState.legendToggleStates.length; j++) {
          final _LegendRenderContext legendRenderContext =
              widget._chartState.legendToggleStates[j];
          if (seriesIndex == legendRenderContext.seriesIndex) {
            seriesRender = false;
            break;
          }
        }
      }
    }
    return seriesRender ?? true;
  }
}

// ignore: must_be_immutable
class _ContainerArea extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  _ContainerArea({this.chart});
  SfCartesianChart chart;
  List<Widget> _chartWidgets;
  RenderBox renderBox;
  Offset _touchPosition;
  Offset _tapDownDetails;
  CartesianSeries<dynamic, dynamic> _series;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: _initializeChart(constraints, context));
    });
  }

  Offset _zoomStartPosition;
  Widget _initializeChart(BoxConstraints constraints, BuildContext context) {
    _calculateSize(constraints);
    _calculateBounds();
    return Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: _renderWidgets(constraints, context));
  }

  void _calculateSize(BoxConstraints constraints) {
    final double width = constraints.maxWidth;
    final double height = constraints.maxHeight;
    chart._chartState.containerRect = Rect.fromLTWH(0, 0, width, height);
  }

  void _calculateBounds() {
    chart._chartSeries.chart = chart;
    chart._chartAxis._chartWidget = chart;
    chart._chartSeries?.processData();
    chart._chartAxis?._measureAxesBounds();
  }

  void _createSegment(SfCartesianChart chart, int index) {
    final CartesianSeries<dynamic, dynamic> chartSeries =
        chart._chartSeries.visibleSeries[index];
    chartSeries._internalCreateSegments();
  }

  Widget _renderWidgets(BoxConstraints constraints, BuildContext context) {
    _chartWidgets = <Widget>[];
    chart._chartState.renderDatalabelRegions = <Rect>[];
    chart.zoomPanBehavior._setChart(chart);
    _bindAxisWidgets('outside');
    _bindPlotBandWidgets(true);
    _bindSeriesWidgets();
    _bindPlotBandWidgets(false);
    _bindDataLabelWidgets();
    _bindAxisWidgets('inside');
    _renderTemplates();
    _bindInteractionWidgets(constraints, context);
    renderBox = context.findRenderObject();
    chart._containerArea = this;
    return Container(child: Stack(children: _chartWidgets));
  }

  void _bindPlotBandWidgets(bool shouldRenderAboveSeries) {
    _chartWidgets.add(CustomPaint(
        painter: _PlotBandPainter(
            chart: chart, shouldRenderAboveSeries: shouldRenderAboveSeries)));
  }

  void _bindDataLabelWidgets() {
    chart._chartState.renderDataLabel = _DataLabelRenderer(
        cartesianChart: chart, show: chart._chartState.animateCompleted);
    _chartWidgets.add(chart._chartState.renderDataLabel);
  }

  void _renderTemplates() {
    Widget labelWidget;
    CartesianChartPoint<dynamic> point;
    chart._chartState.dataLabelTemplateRegions = <Rect>[];
    chart._chartState.annotationRegions = <Rect>[];
    chart._chartState.templates = chart._chartState.initialRender
        ? <_ChartTemplateInfo>[]
        : chart._chartState.templates;
    for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
      final CartesianSeries<dynamic, dynamic> series =
          chart._chartSeries.visibleSeries[i];
      if (!series._visible) {
        for (int index = 0;
            index < chart._chartState.templates.length;
            index++) {
          final _ChartTemplateInfo templateInfo =
              chart._chartState.templates[index];
          if (templateInfo.templateType == 'DataLabel' &&
              templateInfo.seriesIndex == i) {
            chart._chartState.templates.removeAt(index);
            index--;
          }
        }
      }
      if (series.dataLabelSettings.isVisible && series._visible) {
        for (int j = 0; j < series._dataPoints.length; j++) {
          point = series._dataPoints[j];
          if (point.isVisible && !point.isGap) {
            _calculateDataLabelPosition(series, point, j, chart);
            labelWidget = (series.dataLabelSettings.builder != null)
                ? series.dataLabelSettings
                    .builder(series.dataSource[j], point, series, i, j)
                : null;
            if (labelWidget != null) {
              final _ChartTemplateInfo templateInfo = _ChartTemplateInfo(
                  key: GlobalKey(),
                  templateType: 'DataLabel',
                  pointIndex: j,
                  seriesIndex: i,
                  needMeasure: true,
                  clipRect: chart._chartAxis._axisClipRect,
                  animationDuration:
                      (series.animationDuration + 1000.0).floor(),
                  widget: labelWidget,
                  location: Offset(point.markerPoint.x, point.markerPoint.y));

              (!chart._chartState.widgetNeedUpdate &&
                      !chart._chartState.initialRender)
                  ? _replaceTemplates(templateInfo)
                  : chart._chartState.templates.add(templateInfo);
              if (series._seriesType.contains('range')) {
                final _ChartTemplateInfo templateInfo2 = _ChartTemplateInfo(
                    key: GlobalKey(),
                    templateType: 'DataLabel',
                    pointIndex: j,
                    seriesIndex: i,
                    needMeasure: true,
                    clipRect: chart._chartAxis._axisClipRect,
                    animationDuration:
                        (series.animationDuration + 1000.0).floor(),
                    widget: labelWidget,
                    location:
                        Offset(point.markerPoint2.x, point.markerPoint2.y));
                (!chart._chartState.widgetNeedUpdate &&
                        !chart._chartState.initialRender)
                    ? _replaceTemplates(templateInfo2)
                    : chart._chartState.templates.add(templateInfo2);
              }
            }
          }
        }
      }
    }
    if (chart.annotations != null && chart.annotations.isNotEmpty) {
      for (int i = 0; i < chart.annotations.length; i++) {
        final CartesianChartAnnotation annotation = chart.annotations[i];
        final _ChartLocation location =
            _getAnnotationLocation(annotation, chart);
        final _ChartTemplateInfo chartTemplateInfo = _ChartTemplateInfo(
            key: GlobalKey(),
            animationDuration: 200,
            widget: annotation.widget,
            templateType: 'Annotation',
            needMeasure: true,
            pointIndex: i,
            verticalAlignment: annotation.verticalAlignment,
            horizontalAlignment: annotation.horizontalAlignment,
            clipRect: annotation.region == AnnotationRegion.chart
                ? chart._chartState.containerRect
                : chart._chartAxis._axisClipRect,
            location: Offset(location.x.toDouble(), location.y.toDouble()));
        !chart._chartState.initialRender
            ? _replaceTemplates(chartTemplateInfo)
            : chart._chartState.templates.add(chartTemplateInfo);
      }
      chart._chartState.widgetNeedUpdate = false;
    }

    if (chart._chartState.templates.isNotEmpty) {
      final int templateLength = chart._chartState.templates.length;
      for (int i = 0; i < chart._chartState.templates.length; i++) {
        final _ChartTemplateInfo templateInfo = chart._chartState.templates[i];
        _chartWidgets.add(_RenderTemplate(
            template: templateInfo,
            templateIndex: i,
            templateLength: templateLength,
            chart: chart));
      }
    }
  }

  void _replaceTemplates(_ChartTemplateInfo currentTemplate) {
    bool isReplaced = false;
    if (chart._chartState.templates.isNotEmpty) {
      for (int i = 0; i < chart._chartState.templates.length; i++) {
        final _ChartTemplateInfo templateInfo = chart._chartState.templates[i];
        if (templateInfo.templateType == currentTemplate.templateType) {
          if (currentTemplate.templateType == 'DataLabel'
              ? templateInfo.pointIndex == currentTemplate.pointIndex &&
                  templateInfo.seriesIndex == currentTemplate.seriesIndex
              : templateInfo.pointIndex == currentTemplate.pointIndex &&
                  templateInfo.size != null) {
            templateInfo.needMeasure = false;
            templateInfo.animationDuration = 0;
            templateInfo.clipRect = currentTemplate.clipRect;
            templateInfo.location = currentTemplate.location;
            isReplaced = true;
            break;
          }
        }
      }
    }
    if (!isReplaced) {
      chart._chartState.templates.add(currentTemplate);
    }
  }

  void _bindSeriesWidgets() {
    Animation<double> seriesAnimation;
    for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
      _series = chart._chartSeries.visibleSeries[i];
      if (_series != null && _series._visible) {
        _series._renderSeries(chart, i);
        _createSegment(chart, i);
        if (_series.selectionSettings != null) {
          _series.selectionSettings._selectionRenderer ??= _SelectionRenderer();
          _series.selectionSettings._selectionRenderer.chart = chart;
          _series.selectionSettings._selectionRenderer.selectedSegments =
              chart._chartState.selectedSegments;
          _series.selectionSettings._selectionRenderer.unselectedSegments =
              chart._chartState.unselectedSegments;
          if (_series.selectionSettings.enable &&
              _series.initialSelectedDataIndexes.isNotEmpty) {
            _series.selectionSettings._selectedDataPointIndex(
                _series, _series.initialSelectedDataIndexes);
          }
        }
        if (_series.animationDuration > 0 &&
            chart._chartState != null &&
            chart._chartState.zoomedState != true &&
            (chart._chartState.initialRender ||
                chart._chartState.widgetNeedUpdate ||
                chart._chartState._isLegendToggled)) {
          chart._chartState.animationController =
              AnimationController(vsync: chart._chartState)
                ..addListener(() {
                  chart._chartState.seriesRepaintNotifier.value++;
                });

          chart._chartState.animationController.duration =
              Duration(milliseconds: _series.animationDuration.toInt());
          seriesAnimation =
              Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: chart._chartState.animationController,
            curve: const Interval(0.1, 0.8, curve: Curves.decelerate),
          ));

          chart._chartState.chartElementAnimation =
              Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: chart._chartState.animationController,
            curve: const Interval(0.85, 1.0, curve: Curves.decelerate),
          ));
          chart._chartState.animationController.forward(from: 0.0);
          chart._chartState.controllerList
              .add(chart._chartState.animationController);
        }
      }
      _chartWidgets.add(Container(
          child: RepaintBoundary(
              child: CustomPaint(
        painter: _getSeriesPainter(i, chart._chartState.animationController,
            seriesAnimation, chart._chartState.chartElementAnimation),
      ))));
    }
    _chartWidgets.add(Container(
        color: Colors.red,
        child: RepaintBoundary(
            child: CustomPaint(
                painter: _ZoomRectPainter(
                    isRepaint: true,
                    chart: chart,
                    notifier: chart._chartState.zoomRepaintNotifier)))));

    _animateComplete(chart._chartState.controllerList, chart);
    chart._chartState._legendToggling = false;
  }

  void _bindAxisWidgets(String renderType) {
    if (chart._chartAxis._axisCollections != null &&
        chart._chartAxis._axisCollections.isNotEmpty &&
        chart._chartAxis._axisCollections.length > 1) {
      _chartWidgets.add(Container(
        child: RepaintBoundary(
            child: CustomPaint(
                painter: _CartesianAxesPainter(
                    chart: chart,
                    renderType: renderType,
                    isRepaint: chart._chartAxis._needsRepaint,
                    notifier: chart._chartState.axisRepaintNotifier))),
      ));
    }
  }

  CartesianSeries<dynamic, dynamic> _findSeries(Offset position) {
    CartesianSeries<dynamic, dynamic> series;
    outerLoop:
    for (int i = chart._chartSeries.visibleSeries.length - 1; i >= 0; i--) {
      series = chart._chartSeries.visibleSeries[i];
      if (series._seriesType == 'column' ||
          series._seriesType == 'bar' ||
          series._seriesType == 'scatter' ||
          series._seriesType == 'bubble' ||
          series._seriesType == 'fastline' ||
          series._seriesType.contains('area') ||
          series._seriesType.contains('stackedcolumn') ||
          series._seriesType.contains('stackedbar') ||
          series._seriesType.contains('range')) {
        for (int j = 0; j < series._dataPoints.length; j++) {
          if (series._dataPoints[j].region != null &&
              series._dataPoints[j].region.contains(position)) {
            series._isOuterRegion = false;
            break outerLoop;
          } else {
            series._isOuterRegion = true;
          }
        }
      } else {
        bool isSelect = false;
        series = chart._chartSeries.visibleSeries[i];
        for (int k = chart._chartSeries.visibleSeries.length - 1; k >= 0; k--) {
          isSelect = series.selectionSettings.enable
              ? series.selectionSettings._selectionRenderer
                  ._isSeriesContainsPoint(
                      chart._chartSeries.visibleSeries[i], position)
              : false;
          if (isSelect) {
            return chart._chartSeries.visibleSeries[i];
          }
        }
      }
    }
    return series;
  }

  void _performPointerDown(PointerDownEvent event) {
    _tapDownDetails = event.position;
    if (chart.zoomPanBehavior.enablePinching == true) {
      ZoomPanArgs zoomStartArgs;
      if (chart._chartState._touchStartPositions.length < 2) {
        chart._chartState._touchStartPositions.add(event);
      }
      if (chart._chartState._touchStartPositions.length == 2) {
        for (int axisIndex = 0;
            axisIndex < chart._chartAxis._axisCollections.length;
            axisIndex++) {
          final dynamic axis = chart._chartAxis._axisCollections[axisIndex];
          if (chart.onZoomStart != null) {
            zoomStartArgs =
                _zoomEvent(chart, axis, zoomStartArgs, chart.onZoomStart);
            axis._zoomFactor = zoomStartArgs.currentZoomFactor;
            axis._zoomPosition = zoomStartArgs.currentZoomPosition;
          }
          chart.zoomPanBehavior.onPinchStart(
              axis,
              chart._chartState._touchStartPositions[0].position.dx,
              chart._chartState._touchStartPositions[0].position.dy,
              chart._chartState._touchStartPositions[1].position.dx,
              chart._chartState._touchStartPositions[1].position.dy,
              axis._zoomFactor);
        }
      }
    }
    final Offset position = renderBox.globalToLocal(event.position);
    _touchPosition = position;
    if (chart._chartSeries.visibleSeries != null &&
        chart._chartSeries.visibleSeries.isNotEmpty &&
        chart.selectionGesture == ActivationMode.singleTap &&
        chart.zoomPanBehavior._isPinching != true) {
      final CartesianSeries<dynamic, dynamic> selectionSeries =
          _findSeries(position);
      if (!selectionSeries._isOuterRegion &&
          selectionSeries.selectionSettings._selectionRenderer != null) {
        selectionSeries.selectionSettings._selectionRenderer.series =
            selectionSeries;
        selectionSeries.selectionSettings.onTouchDown(position.dx, position.dy);
      }
    }
    if (chart.trackballBehavior != null &&
        chart.trackballBehavior.enable &&
        chart.trackballBehavior.activationMode == ActivationMode.singleTap) {
      chart.trackballBehavior.onTouchDown(position.dx, position.dy);
    }
    if (chart.crosshairBehavior != null &&
        chart.crosshairBehavior.enable &&
        chart.crosshairBehavior.activationMode == ActivationMode.singleTap) {
      chart.crosshairBehavior.onTouchDown(position.dx, position.dy);
    }
  }

  void _performPointerMove(PointerMoveEvent event) {
    ZoomPanArgs zoomingArgs;
    for (int index = 0;
        index < chart._chartAxis._axisCollections.length;
        index++) {
      final dynamic axis = chart._chartAxis._axisCollections[index];
      if (chart.onZooming != null) {
        _zoomEvent(chart, axis, zoomingArgs, chart.onZooming);
      }
    }
    if (chart.zoomPanBehavior.enablePinching == true &&
        chart._chartState._touchStartPositions.length == 2) {
      chart.zoomPanBehavior._isPinching = true;
      final int pointerID = event.pointer;
      bool addPointer = true;
      for (int i = 0; i < chart._chartState._touchMovePositions.length; i++) {
        if (chart._chartState._touchMovePositions[i].pointer == pointerID) {
          addPointer = false;
        }
      }
      if (chart._chartState._touchMovePositions.length < 2 && addPointer) {
        chart._chartState._touchMovePositions.add(event);
      }

      if (chart._chartState._touchMovePositions.length == 2 &&
          chart._chartState._touchStartPositions.length == 2) {
        if (chart._chartState._touchMovePositions[0].pointer == event.pointer) {
          chart._chartState._touchMovePositions[0] = event;
        }
        if (chart._chartState._touchMovePositions[1].pointer == event.pointer) {
          chart._chartState._touchMovePositions[1] = event;
        }

        chart.zoomPanBehavior._performPinchZooming(
            chart._chartState._touchStartPositions,
            chart._chartState._touchMovePositions);
      }
    }
  }

  void _performPointerUp(PointerUpEvent event) {
    if (chart._chartState._touchStartPositions.length == 2 &&
        chart._chartState._touchMovePositions.length == 2 &&
        chart.zoomPanBehavior._isPinching) {
      ZoomPanArgs zoomEndArgs, zoomResetArgs;
      bool resetFlag = false;
      int axisIndex;
      for (axisIndex = 0;
          axisIndex < chart._chartAxis._axisCollections.length;
          axisIndex++) {
        final ChartAxis axis = chart._chartAxis._axisCollections[axisIndex];

        if (chart.onZoomEnd != null) {
          zoomEndArgs = _zoomEvent(chart, axis, zoomEndArgs, chart.onZoomEnd);
          axis._zoomFactor = zoomEndArgs.currentZoomFactor;
          axis._zoomPosition = zoomEndArgs.currentZoomPosition;
        }
        if (axis._zoomFactor.toInt() == 1 &&
            axis._zoomPosition.toInt() == 0 &&
            chart.onZoomReset != null) {
          resetFlag = true;
        }
        chart._chartState.zoomAxes = <_ZoomAxisRange>[];
        chart.zoomPanBehavior.onPinchEnd(
            axis,
            chart._chartState._touchMovePositions[0].position.dx,
            chart._chartState._touchMovePositions[0].position.dy,
            chart._chartState._touchMovePositions[1].position.dx,
            chart._chartState._touchMovePositions[1].position.dy,
            axis._zoomFactor);
      }
      if (resetFlag) {
        for (int index = 0;
            index < chart._chartAxis._axisCollections.length;
            index++) {
          final dynamic axis = chart._chartAxis._axisCollections[index];
          _zoomEvent(chart, axis, zoomResetArgs, chart.onZoomReset);
        }
      }
    }
    chart._chartState._touchStartPositions = <PointerEvent>[];
    chart._chartState._touchMovePositions = <PointerEvent>[];
    chart.zoomPanBehavior._isPinching = false;
    chart.zoomPanBehavior._delayRedraw = false;
    final Offset position = renderBox.globalToLocal(event.position);
    if (chart.tooltipBehavior.enable &&
        chart.tooltipBehavior.activationMode == ActivationMode.singleTap) {
      if (chart.tooltipBehavior.builder != null) {
        const double padding = 15;
        if (chart._chartAxis._axisClipRect.contains(position)) {
          bool isTooltipRegion = false;
          for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
            final CartesianSeries<dynamic, dynamic> series =
                chart._chartSeries.visibleSeries[i];
            int j = 0;
            if (series.enableTooltip && series._regionalData != null) {
              series._regionalData
                  .forEach((dynamic regionRect, dynamic values) {
                final Rect region = regionRect[0];
                final double left = region.left - padding;
                final double right = region.right + padding;
                final double top = region.top - padding;
                final double bottom = region.bottom + padding;
                final Rect paddedRegion =
                    Rect.fromLTRB(left, top, right, bottom);
                if (paddedRegion.contains(position)) {
                  final Offset tooltipPosition = regionRect[1];
                  chart.tooltipBehavior._tooltipTemplate.rect = Rect.fromLTWH(
                      tooltipPosition.dx,
                      tooltipPosition.dy - padding / 2,
                      region.width,
                      region.height);
                  chart.tooltipBehavior._tooltipTemplate.template =
                      chart.tooltipBehavior.builder(series.dataSource[j],
                          series._dataPoints[j], series, j, i);
                  isTooltipRegion = true;
                  if (series._visible) {
                    chart.tooltipBehavior._tooltipTemplate.show =
                        isTooltipRegion;
                    chart.tooltipBehavior._tooltipTemplate?.state
                        ?._performTooltip();
                  }
                }
                j++;
              });
            }
          }
        }
      } else {
        chart.tooltipBehavior.onTouchUp(position.dx, position.dy);
      }
    }
    if ((chart.trackballBehavior != null &&
            chart.trackballBehavior.enable &&
            !chart.trackballBehavior.shouldAlwaysShow &&
            chart.trackballBehavior.activationMode !=
                ActivationMode.doubleTap &&
            chart.zoomPanBehavior._isPinching != true) ||
        (chart.zoomPanBehavior != null &&
            ((chart.zoomPanBehavior.enableDoubleTapZooming ||
                    chart.zoomPanBehavior.enablePanning ||
                    chart.zoomPanBehavior.enablePinching ||
                    chart.zoomPanBehavior.enableSelectionZooming) &&
                !chart.trackballBehavior.shouldAlwaysShow))) {
      chart.trackballBehavior.onTouchUp(position.dx, position.dy);
      chart.trackballBehavior._isLongPressActivated = false;
    }
    if ((chart.crosshairBehavior != null &&
            chart.crosshairBehavior.enable &&
            !chart.crosshairBehavior.shouldAlwaysShow &&
            chart.crosshairBehavior.activationMode !=
                ActivationMode.doubleTap &&
            chart.zoomPanBehavior._isPinching != true) ||
        (chart.zoomPanBehavior != null &&
            ((chart.zoomPanBehavior.enableDoubleTapZooming ||
                    chart.zoomPanBehavior.enablePanning ||
                    chart.zoomPanBehavior.enablePinching ||
                    chart.zoomPanBehavior.enableSelectionZooming) &&
                !chart.crosshairBehavior.shouldAlwaysShow))) {
      chart.crosshairBehavior.onTouchUp(position.dx, position.dy);
      chart.crosshairBehavior._isLongPressActivated = true;
    }
  }

  void _performLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    final Offset position = renderBox.globalToLocal(details.globalPosition);
    if (chart.zoomPanBehavior._isPinching != true) {
      if (chart.zoomPanBehavior.enableSelectionZooming &&
          position != null &&
          _zoomStartPosition != null) {
        chart.zoomPanBehavior._canPerformSelection = true;
        chart.zoomPanBehavior.onDrawSelectionZoomRect(position.dx, position.dy,
            _zoomStartPosition.dx, _zoomStartPosition.dy);
      }
    }
    if (chart.trackballBehavior != null &&
        chart.trackballBehavior.enable &&
        chart.trackballBehavior.activationMode != ActivationMode.doubleTap &&
        position != null) {
      if (chart.trackballBehavior.activationMode == ActivationMode.singleTap) {
        chart.trackballBehavior.onTouchMove(position.dx, position.dy);
      } else if (chart.trackballBehavior.activationMode ==
              ActivationMode.longPress &&
          chart.trackballBehavior._isLongPressActivated) {
        chart.trackballBehavior.onTouchMove(position.dx, position.dy);
      }
    }
    if (chart.crosshairBehavior != null &&
        chart.crosshairBehavior.enable &&
        chart.crosshairBehavior.activationMode != ActivationMode.doubleTap &&
        position != null) {
      if (chart.crosshairBehavior.activationMode == ActivationMode.singleTap) {
        chart.crosshairBehavior.onTouchMove(position.dx, position.dy);
      } else if ((chart.crosshairBehavior != null &&
              chart.crosshairBehavior.activationMode ==
                  ActivationMode.longPress &&
              chart.crosshairBehavior._isLongPressActivated) &&
          !chart.zoomPanBehavior.enableSelectionZooming) {
        chart.crosshairBehavior.onTouchMove(position.dx, position.dy);
      }
    }
  }

  void _performLongPressEnd() {
    if (chart.zoomPanBehavior._isPinching != true) {
      chart.zoomPanBehavior._canPerformSelection = false;
      if (chart.zoomPanBehavior.enableSelectionZooming &&
          chart.zoomPanBehavior._zoomingRect.width != 0) {
        chart.zoomPanBehavior
            ._doSelectionZooming(chart.zoomPanBehavior._zoomingRect);
        if (chart.zoomPanBehavior._canPerformSelection != true) {
          chart.zoomPanBehavior._zoomingRect = const Rect.fromLTRB(0, 0, 0, 0);
        }
      }
    }
  }

  void _performPanDown(DragDownDetails details) {
    if (chart.zoomPanBehavior._isPinching != true) {
      _zoomStartPosition = renderBox.globalToLocal(details.globalPosition);
      if (chart.zoomPanBehavior.enablePanning == true) {
        chart.zoomPanBehavior._isPanning = true;
        chart.zoomPanBehavior._previousMovedPosition = null;
      }
    }
  }

  void _performLongPress() {
    Offset position;
    if (_tapDownDetails != null) {
      position = renderBox.globalToLocal(_tapDownDetails);
      if (chart.tooltipBehavior.enable &&
          chart.tooltipBehavior.activationMode == ActivationMode.longPress) {
        chart.tooltipBehavior.onLongPress(position.dx, position.dy);
      }
    }
    if (chart._chartSeries.visibleSeries != null &&
        chart.selectionGesture == ActivationMode.longPress) {
      final CartesianSeries<dynamic, dynamic> selectionSeries =
          _findSeries(position);
      selectionSeries.selectionSettings._selectionRenderer.series =
          selectionSeries;
      selectionSeries.selectionSettings.onLongPress(position.dx, position.dy);
    }
    if ((chart.trackballBehavior != null &&
            chart.trackballBehavior.enable == true &&
            chart.trackballBehavior.activationMode ==
                ActivationMode.longPress) &&
        chart.zoomPanBehavior._isPinching != true) {
      chart.trackballBehavior._isLongPressActivated = true;
      chart.trackballBehavior.onTouchDown(position.dx, position.dy);
    }
    if ((chart.crosshairBehavior != null &&
            chart.crosshairBehavior.enable == true &&
            chart.crosshairBehavior.activationMode ==
                ActivationMode.longPress) &&
        !chart.zoomPanBehavior.enableSelectionZooming &&
        chart.zoomPanBehavior._isPinching != true &&
        position != null) {
      chart.crosshairBehavior._isLongPressActivated = true;
      chart.crosshairBehavior.onTouchDown(position.dx, position.dy);
    }
  }

  void _performDoubleTap() {
    if (_tapDownDetails != null) {
      final Offset position = renderBox.globalToLocal(_tapDownDetails);
      if (chart.tooltipBehavior.enable &&
          chart.tooltipBehavior.activationMode == ActivationMode.doubleTap) {
        chart.tooltipBehavior.onDoubleTap(position.dx, position.dy);
      }
      if (chart.trackballBehavior != null &&
          chart.trackballBehavior.enable &&
          chart.trackballBehavior.activationMode == ActivationMode.doubleTap) {
        chart.trackballBehavior.onDoubleTap(position.dx, position.dy);
        chart._chartState._enableDoubleTap = true;
        chart.trackballBehavior.onTouchUp(position.dx, position.dy);
        chart._chartState._enableDoubleTap = false;
      }
      if (chart.crosshairBehavior != null &&
          chart.crosshairBehavior.enable &&
          chart.crosshairBehavior.activationMode == ActivationMode.doubleTap) {
        chart.crosshairBehavior.onDoubleTap(position.dx, position.dy);
        chart._chartState._enableDoubleTap = true;
        chart.crosshairBehavior.onTouchUp(position.dx, position.dy);
        chart._chartState._enableDoubleTap = false;
      }
      if (chart._chartSeries.visibleSeries != null &&
          chart.selectionGesture == ActivationMode.doubleTap) {
        final CartesianSeries<dynamic, dynamic> selectionSeries =
            _findSeries(position);
        selectionSeries.selectionSettings._selectionRenderer.series =
            selectionSeries;
        selectionSeries.selectionSettings.onDoubleTap(position.dx, position.dy);
      }
    }

    if (chart.zoomPanBehavior.enableDoubleTapZooming == true) {
      final Offset doubleTapPosition = _touchPosition;
      final Offset position = doubleTapPosition;
      if (position != null)
        chart.zoomPanBehavior.onDoubleTap(
            position.dx, position.dy, chart.zoomPanBehavior._zoomFactor);
    }
  }

  void _performPanUpdate(DragUpdateDetails details) {
    Offset position;
    if (chart.zoomPanBehavior._isPinching != true) {
      position = renderBox.globalToLocal(details.globalPosition);
      if (chart.zoomPanBehavior._isPanning == true &&
          chart.zoomPanBehavior.enablePanning &&
          chart.zoomPanBehavior._previousMovedPosition != null) {
        chart.zoomPanBehavior.onPan(position.dx, position.dy);
      }
      chart.zoomPanBehavior._previousMovedPosition = position;
    }
    if (chart.trackballBehavior != null &&
        chart.trackballBehavior.enable &&
        chart.trackballBehavior.activationMode != ActivationMode.doubleTap) {
      if (chart.trackballBehavior.activationMode == ActivationMode.singleTap) {
        chart.trackballBehavior.onTouchMove(position?.dx, position?.dy);
      } else if (chart.trackballBehavior != null &&
          chart.trackballBehavior.activationMode == ActivationMode.longPress &&
          chart.trackballBehavior._isLongPressActivated == true) {
        chart.trackballBehavior.onTouchMove(position?.dx, position?.dy);
      }
    }
    if (chart.crosshairBehavior != null &&
        chart.crosshairBehavior.enable &&
        chart.crosshairBehavior.activationMode != ActivationMode.doubleTap &&
        position != null) {
      if (chart.crosshairBehavior.activationMode == ActivationMode.singleTap) {
        chart.crosshairBehavior.onTouchMove(position.dx, position.dy);
      } else if (chart.crosshairBehavior != null &&
          chart.crosshairBehavior.activationMode == ActivationMode.longPress &&
          chart.crosshairBehavior._isLongPressActivated) {
        chart.crosshairBehavior.onTouchMove(position.dx, position.dy);
      }
    }
  }

  void _performPanEnd(DragEndDetails details) {
    if (chart.zoomPanBehavior._isPinching != true) {
      chart.zoomPanBehavior._isPanning = false;
      chart.zoomPanBehavior._previousMovedPosition = null;
    }
    if (chart.trackballBehavior.enable &&
        !chart.trackballBehavior.shouldAlwaysShow &&
        chart.trackballBehavior.activationMode != ActivationMode.doubleTap &&
        _touchPosition != null) {
      chart.trackballBehavior.onTouchUp(_touchPosition.dx, _touchPosition.dy);
      chart.trackballBehavior._isLongPressActivated = false;
    }
    if (chart.crosshairBehavior.enable &&
        !chart.crosshairBehavior.shouldAlwaysShow &&
        chart.crosshairBehavior.activationMode != ActivationMode.doubleTap) {
      chart.crosshairBehavior.onTouchUp(_touchPosition?.dx, _touchPosition?.dy);
    }
  }

  void _bindInteractionWidgets(
      BoxConstraints constraints, BuildContext context) {
    final RenderBox renderBox = context.findRenderObject();
    _TrackballPainter trackballPainter;
    _CrosshairPainter crosshairPainter;
    final _TooltipPainter tooltipPainter = _TooltipPainter(
        valueNotifier: chart._chartState.tooltipRepaintNotifier);
    tooltipPainter._chartState = chart._chartState;
    tooltipPainter._chart = chart;
    tooltipPainter.tooltip = chart.tooltipBehavior;
    chart.tooltipBehavior._painter = tooltipPainter;
    final _ZoomRectPainter zoomRectPainter = _ZoomRectPainter(chart: chart);
    chart.zoomPanBehavior._painter = zoomRectPainter;

    if (chart.tooltipBehavior.enable) {
      if (chart.tooltipBehavior.builder != null) {
        chart.tooltipBehavior._tooltipTemplate = _TooltipTemplate(
            show: false, clipRect: chart._chartAxis._axisClipRect);
        _chartWidgets.add(chart.tooltipBehavior._tooltipTemplate);
      } else {
        _chartWidgets.add(Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: CustomPaint(painter: tooltipPainter)));
      }
    }
    if (chart.trackballBehavior != null && chart.trackballBehavior.enable) {
      trackballPainter = _TrackballPainter(
          chart: chart,
          valueNotifier: chart._chartState.trackballRepaintNotifier);
      chart.trackballBehavior._trackballPainter = trackballPainter;
      _chartWidgets.add(Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: CustomPaint(painter: trackballPainter)));
    }
    if (chart.crosshairBehavior != null && chart.crosshairBehavior.enable) {
      crosshairPainter = _CrosshairPainter(
          chart: chart,
          valueNotifier: chart._chartState.crosshairRepaintNotifier);
      chart.crosshairBehavior._crosshairPainter = crosshairPainter;
      _chartWidgets.add(Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: CustomPaint(painter: crosshairPainter)));
    }
    _chartWidgets.add(Listener(
        onPointerDown: (PointerDownEvent event) {
          _performPointerDown(event);
        },
        onPointerMove: (PointerMoveEvent event) {
          _performPointerMove(event);
        },
        onPointerUp: (PointerUpEvent event) {
          _performPointerUp(event);
          if (chart.onChartTapped != null) {
            chart.onChartTapped(renderBox.globalToLocal(event.position));
          }
        },
        child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              final Offset position =
                  renderBox.globalToLocal(details.globalPosition);
              _touchPosition = position;
              if (chart.onPointTapped != null) {
                _getPointSeriesIndex(chart, position);
              }
              if (chart.onAxisLabelTapped != null) {
                _triggerAxisLabelEvent(position);
              }
            },
            onDoubleTap: () {
              _performDoubleTap();
            },
            onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
              _performLongPressMoveUpdate(details);
            },
            onLongPress: () {
              _performLongPress();
            },
            onLongPressEnd: (LongPressEndDetails details) {
              _performLongPressEnd();
            },
            onPanUpdate: (DragUpdateDetails details) {
              _performPanUpdate(details);
            },
            onPanEnd: (DragEndDetails details) {
              _performPanEnd(details);
            },
            onPanDown: (DragDownDetails details) {
              _performPanDown(details);
            },
            child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: const BoxDecoration(color: Colors.transparent)))));
  }

  /// Find point index for selection
  void _getPointSeriesIndex(SfCartesianChart chart, Offset position) {
    for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
      final CartesianSeries<dynamic, dynamic> series =
          chart._chartSeries.visibleSeries[i];

      num pointIndex;
      int count = 0;
      final double padding = (series._seriesType == 'bubble') ||
              (series._seriesType == 'scatter') ||
              (series._seriesType == 'bar') ||
              (series._seriesType == 'column' ||
                  series._seriesType == 'rangecolumn' ||
                  series._seriesType.contains('stackedcolumn') ||
                  series._seriesType.contains('stackedbar'))
          ? 0
          : 15;

      /// regional padding to detect smooth touch
      series._regionalData.forEach((dynamic regionRect, dynamic values) {
        final Rect region = regionRect[0];
        final double left = region.left - padding;
        final double right = region.right + padding;
        final double top = region.top - padding;
        final double bottom = region.bottom + padding;
        final Rect paddedRegion = Rect.fromLTRB(left, top, right, bottom);
        if (paddedRegion.contains(position)) {
          pointIndex = count;
        }
        count++;
      });

      if (pointIndex != null) {
        PointTapArgs pointTapArgs;
        pointTapArgs = PointTapArgs();
        pointTapArgs.pointIndex = pointIndex;
        pointTapArgs.seriesIndex = i;
        pointTapArgs.dataPoints = series._dataPoints;
        chart.onPointTapped(pointTapArgs);
      }
    }
  }

  /// Triggering onAxisLabelTapped event
  void _triggerAxisLabelEvent(Offset position) {
    for (int i = 0; i < chart._chartAxis._axisCollections.length; i++) {
      final List<AxisLabel> labels =
          chart._chartAxis._axisCollections[i]._visibleLabels;
      for (int k = 0; k < labels.length; k++) {
        if (chart._chartAxis._axisCollections[i].isVisible &&
            labels[k]._labelRegion.contains(position)) {
          AxisLabelTapArgs labelArgs;
          labelArgs = AxisLabelTapArgs();
          labelArgs.text = labels[k].text;
          labelArgs.axis = chart._chartAxis._axisCollections[i];
          labelArgs.axisName = chart._chartAxis._axisCollections[i]._name;
          labelArgs.value = labels[k].value;
          chart.onAxisLabelTapped(labelArgs);
        }
      }
    }
  }

  CustomPainter _getSeriesPainter(
      int value,
      AnimationController controller,
      Animation<double> seriesAnimation,
      Animation<double> chartElementAnimation) {
    CustomPainter customPainter;
    final CartesianSeries<dynamic, dynamic> series =
        chart._chartSeries.visibleSeries[value];
    if (series._seriesType == 'line') {
      customPainter = _LineChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'spline') {
      customPainter = _SplineChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'column') {
      customPainter = _ColumnChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : true,
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'scatter') {
      customPainter = _ScatterChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'stepline') {
      customPainter = _StepLineChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'area') {
      customPainter = _AreaChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'bubble') {
      customPainter = _BubbleChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'bar') {
      customPainter = _BarChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : true,
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'fastline') {
      customPainter = _FastLineChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'stackedcolumn') {
      customPainter = _StackedColummnChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'stackedbar') {
      customPainter = _StackedBarChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'rangecolumn') {
      customPainter = _RangeColumnChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'rangearea') {
      customPainter = _RangeAreaChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'steparea') {
      customPainter = _StepAreaChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'stackedarea') {
      customPainter = _StackedAreaChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'stackedarea100') {
      customPainter = _StackedArea100ChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'stackedline') {
      customPainter = _StackedLineChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'stackedline100') {
      customPainter = _StackedLine100ChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'stackedcolumn100') {
      customPainter = _StackedColumn100ChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'stackedbar100') {
      customPainter = _StackedBar100ChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    } else if (series._seriesType == 'splinearea') {
      customPainter = _SplineAreaChartPainter(
          chart: chart,
          series: series,
          isRepaint: chart._chartState.zoomedState != null
              ? chart._chartState.zoomedState
              : (chart._chartState._legendToggling
                  ? true
                  : series._needsRepaint),
          animationController: controller,
          seriesAnimation: seriesAnimation,
          chartElementAnimation: chartElementAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
    }
    return customPainter;
  }
}
