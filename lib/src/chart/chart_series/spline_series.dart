part of charts;

/// Renders the spline series.
class SplineSeries<T, D> extends XyDataSeries<T, D> {
  SplineSeries(
      {@required List<T> dataSource,
      @required ChartValueMapper<T, D> xValueMapper,
      @required ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, dynamic> sortFieldValueMapper,
      ChartValueMapper<T, Color> pointColorMapper,
      ChartValueMapper<T, String> dataLabelMapper,
      String xAxisName,
      String yAxisName,
      String name,
      Color color,
      double width,
      LinearGradient gradient,
      MarkerSettings markerSettings,
      this.splineType,
      double cardinalSplineTension,
      EmptyPointSettings emptyPointSettings,
      DataLabelSettings dataLabelSettings,
      bool isVisible,
      bool enableTooltip,
      List<double> dashArray,
      double animationDuration,
      SelectionSettings selectionSettings,
      bool isVisibleInLegend,
      LegendIconType legendIconType,
      SortingOrder sortingOrder,
      String legendItemText,
      double opacity,
      List<int> initialSelectedDataIndexes})
      : cardinalSplineTension = cardinalSplineTension ?? 0.5,
        super(
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            pointColorMapper: pointColorMapper,
            dataLabelMapper: dataLabelMapper,
            dataSource: dataSource,
            xAxisName: xAxisName,
            yAxisName: yAxisName,
            name: name,
            color: color,
            width: width ?? 2,
            gradient: gradient,
            markerSettings: markerSettings,
            dataLabelSettings: dataLabelSettings,
            emptyPointSettings: emptyPointSettings,
            enableTooltip: enableTooltip,
            isVisible: isVisible,
            dashArray: dashArray,
            animationDuration: animationDuration,
            selectionSettings: selectionSettings,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity,
            initialSelectedDataIndexes: initialSelectedDataIndexes);

  ///Type of the spline curve. Various type of curves such as clamped, cardinal,
  ///monotonic, and natural can be rendered between the data points.
  ///
  ///Defaults to splineType.natural
  ///
  ///Also refer [SplineType]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  splineType: SplineType.monotonic,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final SplineType splineType;

  ///Line tension of the cardinal spline. The value ranges from 0 to 1.
  ///
  ///Defaults to 0.5
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  splineType: SplineType.natural,
  ///                  cardinalSplineTension: 0.4,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double cardinalSplineTension;

  /// Creates a segment for a data point in the series.
  @override
  ChartSegment createSegment() => SplineSegment();

  /// Creates a collection of segments for the points in the series.
  @override
  void createSegments() {
    final Rect rect = _calculatePlotOffset(_chart._chartAxis._axisClipRect,
        Offset(_xAxis.plotOffset, _yAxis.plotOffset));
    List<num> yCoef = <num>[];
    final List<num> xValues = <num>[];
    final List<num> yValues = <num>[];
    List<double> controlPoints = <double>[];
    double x1, x2, y1, y2;
    double startControlX;
    double startControlY;
    double endControlX;
    double endControlY;
    dynamic splineType;

    if (this is SplineSeries) {
      splineType = this.splineType;
    }

    for (int i = 0; i < _dataPoints.length; i++) {
      if (_dataPoints[i].isDrop != true) {
        xValues.add(_dataPoints[i].xValue);
        yValues.add(_dataPoints[i].yValue);
      }
    }

    if (xValues.isNotEmpty) {
      final List<num> dx = List<num>(xValues.length - 1);

      /// Check the type of spline
      if (splineType == SplineType.monotonic) {
        yCoef =
            _getMonotonicSpline(xValues, yValues, yCoef, xValues.length, dx);
      } else if (splineType == SplineType.cardinal) {
        if (this is SplineSeries) {
          yCoef = _getCardinalSpline(
              xValues, yValues, yCoef, xValues.length, cardinalSplineTension);
        }
      } else {
        yCoef =
            _naturalSpline(xValues, yValues, yCoef, xValues.length, splineType);
      }
      for (int pointIndex = 0; pointIndex < xValues.length - 1; pointIndex++) {
        if (xValues[pointIndex] != null &&
            yValues[pointIndex] != null &&
            xValues[pointIndex + 1] != null &&
            yValues[pointIndex + 1] != null) {
          final double x = xValues[pointIndex].toDouble();
          final double y = yValues[pointIndex].toDouble();
          final double nextX = xValues[pointIndex + 1].toDouble();
          final double nextY = yValues[pointIndex + 1].toDouble();
          if (splineType == SplineType.monotonic) {
            controlPoints = _calculateMonotonicControlPoints(
                x,
                y,
                nextX,
                nextY,
                yCoef[pointIndex].toDouble(),
                yCoef[pointIndex + 1].toDouble(),
                dx[pointIndex].toDouble());
          } else if (splineType == SplineType.cardinal) {
            controlPoints = _calculateCardinalControlPoints(x, y, nextX, nextY,
                yCoef[pointIndex].toDouble(), yCoef[pointIndex + 1].toDouble());
          } else {
            controlPoints = _calculateControlPoints(
                xValues,
                yValues,
                yCoef[pointIndex].toDouble(),
                yCoef[pointIndex + 1].toDouble(),
                pointIndex);
          }

          final num currentPointXValue = xValues[pointIndex];
          final num currentPointYValue = yValues[pointIndex];
          final num nextPointXValue = xValues[pointIndex + 1];
          final num nextPointYValue = yValues[pointIndex + 1];

          x1 = _calculatePoint(currentPointXValue, currentPointYValue, _xAxis,
                  _yAxis, _chart._requireInvertedAxis, this, rect)
              .x;
          y1 = _calculatePoint(currentPointXValue, currentPointYValue, _xAxis,
                  _yAxis, _chart._requireInvertedAxis, this, rect)
              .y;

          x2 = _calculatePoint(nextPointXValue, nextPointYValue, _xAxis, _yAxis,
                  _chart._requireInvertedAxis, this, rect)
              .x;
          y2 = _calculatePoint(nextPointXValue, nextPointYValue, _xAxis, _yAxis,
                  _chart._requireInvertedAxis, this, rect)
              .y;

          startControlX = _calculatePoint(controlPoints[0], controlPoints[1],
                  _xAxis, _yAxis, _chart._requireInvertedAxis, this, rect)
              .x;
          startControlY = _calculatePoint(controlPoints[0], controlPoints[1],
                  _xAxis, _yAxis, _chart._requireInvertedAxis, this, rect)
              .y;
          endControlX = _calculatePoint(controlPoints[2], controlPoints[3],
                  _xAxis, _yAxis, _chart._requireInvertedAxis, this, rect)
              .x;
          endControlY = _calculatePoint(controlPoints[2], controlPoints[3],
                  _xAxis, _yAxis, _chart._requireInvertedAxis, this, rect)
              .y;

          final List<num> values = <num>[];
          values.add(x1);
          values.add(y1);
          values.add(x2);
          values.add(y2);
          values.add(startControlX);
          values.add(startControlY);
          values.add(endControlX);
          values.add(endControlY);
          _createSegment(
              values, _dataPoints[pointIndex], _dataPoints[pointIndex + 1]);
        }
      }
    }
  }

  /// Spline segment is created here
  void _createSegment(List<num> values, CartesianChartPoint<dynamic> currentPt,
      CartesianChartPoint<dynamic> nextPt) {
    final SplineSegment segment = createSegment();
    _isRectSeries = false;
    if (segment != null) {
      segment._currentPoint = currentPt;
      segment._pointColorMapper = currentPt.pointColorMapper;
      segment._nextPoint = nextPt;
      segment.currentSegmentIndex = _dataPoints.indexOf(currentPt);
      segment._seriesIndex = _chart._chartSeries.visibleSeries.indexOf(this);
      segment.series = this;
      if (_chart._chartState.widgetNeedUpdate &&
          _xAxis._zoomFactor == 1 &&
          _yAxis._zoomFactor == 1 &&
          _chart._chartState.prevWidgetSeries != null &&
          _chart._chartState.prevWidgetSeries.isNotEmpty &&
          _chart._chartState.prevWidgetSeries.length - 1 >=
              segment._seriesIndex &&
          _chart._chartState.prevWidgetSeries[segment._seriesIndex]
                  ._seriesName ==
              segment.series._seriesName) {
        segment.oldSeries =
            _chart._chartState.prevWidgetSeries[segment._seriesIndex];
      }
      segment._setData(values);
      segment.calculateSegmentPoints();
      customizeSegment(segment);
      segment.strokePaint = segment.getStrokePaint();
      segment.fillPaint = segment.getFillPaint();
      segments.add(segment);
    }
  }

  /// Changes the series color, border color, and border width.
  @override
  void customizeSegment(ChartSegment segment) {
    segment.color = segment.series._seriesColor;
    segment.strokeColor = segment.series._seriesColor;
    segment.strokeWidth = segment.series.width;
  }

  ///Draws marker with different shape and color of the appropriate data point in the series.
  @override
  void drawDataMarker(int index, Canvas canvas, Paint fillPaint,
      Paint strokePaint, double pointX, double pointY) {
    canvas.drawPath(_markerShapes[index], strokePaint);
    canvas.drawPath(_markerShapes[index], fillPaint);
  }

  /// Draws data label text of the appropriate data point in a series.
  @override
  void drawDataLabel(int index, Canvas canvas, String dataLabel, double pointX,
          double pointY, int angle, ChartTextStyle style) =>
      _drawText(canvas, dataLabel, Offset(pointX, pointY), style, angle);
}
