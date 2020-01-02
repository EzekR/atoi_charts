part of charts;

/// Renders the xy series.
abstract class XyDataSeries<T, D> extends CartesianSeries<T, D> {
  XyDataSeries(
      {ChartValueMapper<T, D> xValueMapper,
      ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, String> dataLabelMapper,
      String name,
      @required List<T> dataSource,
      String xAxisName,
      String yAxisName,
      ChartValueMapper<T, Color> pointColorMapper,
      String legendItemText,
      ChartValueMapper<T, dynamic> sortFieldValueMapper,
      LinearGradient gradient,
      ChartValueMapper<T, num> sizeValueMapper,
      ChartValueMapper<T, num> highValueMapper,
      ChartValueMapper<T, num> lowValueMapper,
      double width,
      MarkerSettings markerSettings,
      bool isVisible,
      bool enableTooltip,
      EmptyPointSettings emptyPointSettings,
      DataLabelSettings dataLabelSettings,
      double animationDuration,
      List<double> dashArray,
      Color borderColor,
      double borderWidth,
      SelectionSettings selectionSettings,
      bool isVisibleInLegend,
      LegendIconType legendIconType,
      double opacity,
      List<ChartSegment> segments,
      Color color,
      List<int> initialSelectedDataIndexes,
      SortingOrder sortingOrder})
      : drawControlPoints = <_ListControlPoints>[],
        super(
            isVisible: isVisible,
            legendItemText: legendItemText,
            xAxisName: xAxisName,
            dashArray: dashArray,
            segments: segments,
            isVisibleInLegend: isVisibleInLegend,
            borderColor: borderColor,
            borderWidth: borderWidth,
            yAxisName: yAxisName,
            color: color,
            name: name,
            width: width,
            xValueMapper: (int index) => xValueMapper(dataSource[index], index),
            yValueMapper: (int index) => yValueMapper(dataSource[index], index),
            sortFieldValueMapper: sortFieldValueMapper != null
                ? (int index) => sortFieldValueMapper(dataSource[index], index)
                : null,
            pointColorMapper: pointColorMapper != null
                ? (int index) => pointColorMapper(dataSource[index], index)
                : null,
            dataLabelMapper: dataLabelMapper != null
                ? (int index) => dataLabelMapper(dataSource[index], index)
                : null,
            sizeValueMapper: sizeValueMapper != null
                ? (int index) => sizeValueMapper(dataSource[index], index)
                : null,
            highValueMapper: highValueMapper != null
                ? (int index) => highValueMapper(dataSource[index], index)
                : null,
            lowValueMapper: lowValueMapper != null
                ? (int index) => lowValueMapper(dataSource[index], index)
                : null,
            dataSource: dataSource,
            emptyPointSettings: emptyPointSettings,
            dataLabelSettings: dataLabelSettings,
            enableTooltip: enableTooltip,
            animationDuration: animationDuration,
            selectionSettings: selectionSettings,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity,
            gradient: gradient,
            markerSettings: markerSettings,
            initialSelectedDataIndexes: initialSelectedDataIndexes);

  /// Stores the series type
  String _seriesType;

  /// Holds the collection of cartesian data points
  List<CartesianChartPoint<dynamic>> _dataPoints;

  /// Whether to check the series is rect series or not
  bool _isRectSeries;

  List<_ListControlPoints> drawControlPoints;

  @override
  void calculateEmptyPointValue(
      int pointIndex, CartesianChartPoint<dynamic> currentPoint) {
    final int pointLength = _dataPoints.length - 1;
    final CartesianChartPoint<dynamic> nextPoint = getPointFromData(
        this,
        pointLength < dataSource.length - 1
            ? dataSource.indexOf(dataSource[pointLength + 1])
            : dataSource.indexOf(dataSource[pointLength]));
    final CartesianChartPoint<dynamic> prevPoint =
        _dataPoints[_dataPoints.length >= 2 ? pointLength - 1 : pointLength];
    if (_seriesType.contains('range')
        ? (currentPoint.low == null || currentPoint.high == null)
        : currentPoint.y == null) {
      switch (emptyPointSettings.mode) {
        case EmptyPointMode.zero:
          currentPoint.isEmpty = true;
          if (_seriesType.contains('range')) {
            currentPoint.high = 0;
            currentPoint.low = 0;
          } else
            currentPoint.y = 0;
          break;

        case EmptyPointMode.average:
          if (_seriesType.contains('range')) {
            if (pointIndex == 0) {
              if (currentPoint.low == null) {
                pointIndex == dataSource.length - 1
                    ? currentPoint.low = 0
                    : currentPoint.low = ((nextPoint.low) ?? 0) / 2;
              }
              if (currentPoint.high == null) {
                pointIndex == dataSource.length - 1
                    ? currentPoint.high = 0
                    : currentPoint.high = ((nextPoint.high) ?? 0) / 2;
              }
            } else if (pointIndex == dataSource.length - 1) {
              currentPoint.low = currentPoint.low == null
                  ? ((prevPoint.low) ?? 0) / 2
                  : currentPoint.low;
              currentPoint.high = currentPoint.high == null
                  ? ((prevPoint.high) ?? 0) / 2
                  : currentPoint.high;
            } else {
              currentPoint.low = currentPoint.low == null
                  ? (((prevPoint.low) ?? 0) + ((nextPoint.low) ?? 0)) / 2
                  : currentPoint.low;
              currentPoint.high = currentPoint.high == null
                  ? (((prevPoint.high) ?? 0) + ((nextPoint.high) ?? 0)) / 2
                  : currentPoint.high;
            }
          } else {
            if (pointIndex == 0) {
              ///Check the first point is null
              pointIndex == dataSource.length - 1
                  ?

                  ///Check the series contains single point with null value
                  currentPoint.y = 0
                  : currentPoint.y = ((nextPoint.y) ?? 0) / 2;
            } else if (pointIndex == dataSource.length - 1) {
              ///Check the last point is null
              currentPoint.y = ((prevPoint.y) ?? 0) / 2;
            } else {
              currentPoint.y =
                  (((prevPoint.y) ?? 0) + ((nextPoint.y) ?? 0)) / 2;
            }
          }
          currentPoint.isEmpty = true;
          break;

        case EmptyPointMode.gap:
          if (_seriesType == 'scatter' ||
              _seriesType == 'column' ||
              _seriesType == 'bar' ||
              _seriesType == 'bubble' ||
              _seriesType == 'splinearea' ||
              _seriesType.contains('stacked') ||
              _seriesType == 'rangecolumn' ||
              _seriesType == 'rangearea') {
            currentPoint.y = pointIndex != 0 &&
                    (!_seriesType.contains('stackedcolumn') &&
                        !_seriesType.contains('stackedbar'))
                ? prevPoint.y
                : 0;
            currentPoint.isVisible = false;
          } else if (_seriesType.contains('line') ||
              _seriesType == 'area' ||
              _seriesType == 'steparea') {
            currentPoint.y = pointIndex != 0 ? prevPoint.y : 0;
          }
          currentPoint.isGap = true;
          break;
        case EmptyPointMode.drop:
          currentPoint.y = pointIndex != 0 &&
                  (_seriesType != 'area' &&
                      _seriesType != 'splinearea' &&
                      _seriesType != 'steparea' &&
                      !_seriesType.contains('stackedcolumn') &&
                      !_seriesType.contains('stackedbar'))
              ? prevPoint.y
              : 0;
          currentPoint.isDrop = true;
          currentPoint.isVisible = false;
          break;
        default:
          currentPoint.y = 0;
          break;
      }
    }
  }
}

/// Returns the widget.
typedef ChartDataLabelTemplateBuilder<T> = Widget Function(
    T data, CartesianChartPoint<dynamic> point, int pointIndex,
    {int seriesIndex, CartesianSeries<dynamic, dynamic> series});

class CartesianChartPoint<D> {
  CartesianChartPoint(this.x, this.y,
      [this.dataLabelMapper,
      this.pointColorMapper,
      this.bubbleSize,
      this.high,
      this.low]) {
    x = x;
    y = y;
    sortValue = sortValue;
    markerPoint = markerPoint;
    isEmpty = isEmpty;
    isGap = isGap;
    isVisible = isVisible;
    bubbleSize = bubbleSize;
    pointColorMapper = pointColorMapper;
    dataLabelMapper = dataLabelMapper;
    high = high;
    low = low;
    markerPoint2 = markerPoint2;
  }

  D x;
  D y;
  D xValue;
  D yValue;
  D sortValue;
  D high;
  D low;
  _ChartLocation markerPoint;
  _ChartLocation markerPoint2;
  double bubbleSize;
  bool isEmpty;
  bool isGap = false;
  bool isDrop = false;
  bool isVisible = true;
  Color pointColorMapper;
  String dataLabelMapper;
  Rect region;
  List<_ChartLocation> symbolLocations;
  List<Rect> regions;
  double cumulativeValue;
  Rect trackerRectRegion;
  String label;
  String label2;
  RRect labelFillRect;
  RRect labelFillRect2;
  _ChartLocation labelLocation;
  _ChartLocation labelLocation2;
  bool dataLabelSaturationRegionInside = false;

  ///Stores the data label region
  Rect dataLabelRegion;
  Rect dataLabelRegion2;
}

class _ChartLocation {
  _ChartLocation(this.x, this.y);
  num x;
  num y;
}

/// To calculate dash array path for series
Path _dashPath(
  Path source, {
  @required _CircularIntervalList<double> dashArray,
}) {
  if (source == null) {
    return null;
  }
  const double intialValue = 0.0;
  final Path path = Path();
  for (final PathMetric measurePath in source.computeMetrics()) {
    double distance = intialValue;
    bool draw = true;
    while (distance < measurePath.length) {
      final double length = dashArray.next;
      if (draw) {
        path.addPath(
            measurePath.extractPath(distance, distance + length), Offset.zero);
      }
      distance += length;
      draw = !draw;
    }
  }
  return path;
}

/// A circular array for dash offsets and lengths.
class _CircularIntervalList<T> {
  _CircularIntervalList(this._values);
  final List<T> _values;
  int _index = 0;
  T get next {
    if (_index >= _values.length) {
      _index = 0;
    }
    return _values[_index++];
  }
}
