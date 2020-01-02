part of charts;

/// Renders the 100% stacked column series.
class StackedColumn100Series<T, D> extends _StackedSeriesBase<T, D> {
  StackedColumn100Series(
      {@required List<T> dataSource,
      @required ChartValueMapper<T, D> xValueMapper,
      @required ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, dynamic> sortFieldValueMapper,
      ChartValueMapper<T, Color> pointColorMapper,
      ChartValueMapper<T, String> dataLabelMapper,
      SortingOrder sortingOrder,
      String groupName,
      String xAxisName,
      String yAxisName,
      String name,
      Color color,
      double width,
      double spacing,
      MarkerSettings markerSettings,
      EmptyPointSettings emptyPointSettings,
      DataLabelSettings dataLabelSettings,
      bool isVisible,
      LinearGradient gradient,
      BorderRadius borderRadius,
      bool enableTooltip,
      double animationDuration,
      Color borderColor,
      double borderWidth,
      SelectionSettings selectionSettings,
      bool isVisibleInLegend,
      LegendIconType legendIconType,
      String legendItemText,
      List<double> dashArray,
      double opacity,
      List<int> initialSelectedDataIndexes})
      : super(
            name: name,
            dashArray: dashArray,
            groupName: groupName,
            spacing: spacing,
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            pointColorMapper: pointColorMapper,
            dataLabelMapper: dataLabelMapper,
            dataSource: dataSource,
            xAxisName: xAxisName,
            yAxisName: yAxisName,
            color: color,
            width: width ?? 0.7,
            markerSettings: markerSettings,
            dataLabelSettings: dataLabelSettings,
            isVisible: isVisible,
            gradient: gradient,
            emptyPointSettings: emptyPointSettings,
            enableTooltip: enableTooltip,
            animationDuration: animationDuration,
            borderColor: borderColor,
            borderWidth: borderWidth,
            borderRadius: borderRadius,
            selectionSettings: selectionSettings,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity,
            initialSelectedDataIndexes: initialSelectedDataIndexes);
  num _rectPosition;
  num _rectCount;

  @override
  ChartSegment createSegment() => StackedColumn100Segment();

  @override
  void createSegments() {
    int segmentIndex = 0;
    for (int i = 0; i < _dataPoints.length; i++) {
      if (_dataPoints[i].isVisible && _dataPoints[i].isGap != true) {
        final List<num> values = <num>[];
        values.add(_dataPoints[i].xValue);
        values.add(_dataPoints[i].yValue);
        _createSegment(values, _dataPoints[i], segmentIndex);
        segmentIndex++;
      }
    }
  }

  /// Stacked Column segment is created here
  void _createSegment(List<num> values,
      CartesianChartPoint<dynamic> currentPoint, int segmentIndex) {
    final StackedColumn100Segment segment = createSegment();
    _isRectSeries = true;
    if (segment != null) {
      segment._seriesIndex = _chart._chartSeries.visibleSeries.indexOf(this);
      segment.currentSegmentIndex = segmentIndex;
      segment.series = this;
      segment._currentPoint = currentPoint;
      segment._setData(values);
      segment.calculateSegmentPoints();
      customizeSegment(segment);
      segment.strokePaint = segment.getStrokePaint();
      segment.fillPaint = segment.getFillPaint();
      segments.add(segment);
    }
  }

  @override
  void customizeSegment(ChartSegment segment) {
    segment.color = segment.series._seriesColor;
    segment.strokeColor = segment.series.borderColor;
    segment.strokeWidth = segment.series.borderWidth;
  }

  @override
  void drawDataLabel(int index, Canvas canvas, String dataLabel, double pointX,
          double pointY, int angle, ChartTextStyle style) =>
      _drawText(canvas, dataLabel, Offset(pointX, pointY), style, angle);

  @override
  void drawDataMarker(int index, Canvas canvas, Paint fillPaint,
      Paint strokePaint, double pointX, double pointY) {
    canvas.drawPath(_markerShapes[index], strokePaint);
    canvas.drawPath(_markerShapes[index], fillPaint);
  }
}
