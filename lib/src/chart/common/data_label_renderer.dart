part of charts;

void _calculateDataLabelPosition(XyDataSeries<dynamic, dynamic> series,
    CartesianChartPoint<dynamic> point, int index, SfCartesianChart chart) {
  final DataLabelSettings dataLabel = series.dataLabelSettings;
  final EdgeInsets margin = dataLabel.margin;
  Size textSize, textSize2;
  final bool transposed = chart._requireInvertedAxis;
  final bool inversed = series._yAxis.isInversed;
  final Rect clipRect = _calculatePlotOffset(chart._chartAxis._axisClipRect,
      Offset(series._xAxis.plotOffset, series._yAxis.plotOffset));
  final bool isRangeSeries = series._seriesType.contains('range');

  if (point != null && point.isVisible && point.isGap != true) {
    final num markerPointX = point.markerPoint.x;
    final num markerPointY = point.markerPoint.y;
    final String label = point.dataLabelMapper ??
        _getLabelText(
            isRangeSeries
                ? (!inversed ? point.high : point.low)
                : ((dataLabel.showCumulativeValues &&
                        point.cumulativeValue != null)
                    ? point.cumulativeValue
                    : point.yValue),
            series,
            chart);
    if (isRangeSeries)
      point.label2 = point.dataLabelMapper ??
          _getLabelText(!inversed ? point.low : point.high, series, chart);
    final ChartTextStyle font =
        (dataLabel.textStyle == null) ? ChartTextStyle() : dataLabel.textStyle;
    point.label = label;
    if (label.isNotEmpty) {
      _ChartLocation chartLocation, chartLocation2;
      textSize = _measureText(label, font);
      chartLocation = _ChartLocation(markerPointX, markerPointY);
      if (isRangeSeries) {
        textSize2 = _measureText(point.label2, font);
        chartLocation2 =
            _ChartLocation(point.markerPoint2.x, point.markerPoint2.y);
      }

      final double alignmentValue = textSize.height +
          (series.markerSettings.isVisible
              ? ((series.markerSettings.borderWidth * 2) +
                  series.markerSettings.height)
              : 0);
      if ((series._seriesType.contains('bar') && !chart.isTransposed) ||
          (series._seriesType.contains('column') && chart.isTransposed)) {
        chartLocation.x =
            (dataLabel.labelAlignment == ChartDataLabelAlignment.auto)
                ? chartLocation.x
                : _calculateAlignment(
                    alignmentValue,
                    chartLocation.x,
                    dataLabel.alignment,
                    (isRangeSeries ? point.high : point.yValue) < 0,
                    transposed);
        if (isRangeSeries) {
          chartLocation2.x =
              (dataLabel.labelAlignment == ChartDataLabelAlignment.auto)
                  ? chartLocation2.x
                  : _calculateAlignment(
                      alignmentValue,
                      chartLocation2.x,
                      dataLabel.alignment,
                      (isRangeSeries ? point.low : point.yValue) < 0,
                      transposed);
        }
      } else {
        chartLocation.y =
            (dataLabel.labelAlignment == ChartDataLabelAlignment.auto)
                ? chartLocation.y
                : _calculateAlignment(
                    alignmentValue,
                    chartLocation.y,
                    dataLabel.alignment,
                    (isRangeSeries ? point.high : point.yValue) < 0,
                    transposed);
        if (isRangeSeries) {
          chartLocation2.y =
              (dataLabel.labelAlignment == ChartDataLabelAlignment.auto)
                  ? chartLocation2.y
                  : _calculateAlignment(
                      alignmentValue,
                      chartLocation2.y,
                      dataLabel.alignment,
                      (isRangeSeries ? point.low : point.yValue) < 0,
                      transposed);
        }
      }

      if (!series._isRectSeries && series._seriesType != 'rangearea') {
        chartLocation.y = _calculatePathPosition(
            chartLocation.y,
            dataLabel.labelAlignment,
            textSize,
            dataLabel.borderWidth,
            series,
            index,
            transposed,
            chartLocation,
            chart,
            point,
            Size(
                series.markerSettings.isVisible
                    ? series.markerSettings.width / 2
                    : 0,
                series.markerSettings.isVisible
                    ? series.markerSettings.height / 2
                    : 0));
      } else {
        final num value = isRangeSeries ? point.high : point.yValue;
        final bool minus =
            (value < 0 && !inversed) || (!(value < 0) && inversed);
        if (!chart._requireInvertedAxis) {
          chartLocation.y = _calculateRectPosition(
              chartLocation.y,
              point.region,
              minus,
              isRangeSeries
                  ? ((dataLabel.labelAlignment ==
                              ChartDataLabelAlignment.outer ||
                          dataLabel.labelAlignment ==
                              ChartDataLabelAlignment.top)
                      ? dataLabel.labelAlignment
                      : ChartDataLabelAlignment.auto)
                  : dataLabel.labelAlignment,
              series,
              textSize,
              dataLabel.borderWidth,
              index,
              chartLocation,
              chart,
              transposed,
              margin);
          if (isRangeSeries) {
            final num value = isRangeSeries ? point.low : point.yValue;
            final bool minus =
                (value < 0 && !inversed) || (!(value < 0) && inversed);
            chartLocation2.y = _calculateRectPosition(
                chartLocation2.y,
                point.region,
                minus,
                dataLabel.labelAlignment == ChartDataLabelAlignment.top
                    ? ChartDataLabelAlignment.auto
                    : ChartDataLabelAlignment.top,
                series,
                textSize,
                dataLabel.borderWidth,
                index,
                chartLocation,
                chart,
                transposed,
                margin);
          }
        } else {
          chartLocation.x = _calculateRectPosition(
              chartLocation.x,
              point.region,
              minus,
              isRangeSeries
                  ? ((dataLabel.labelAlignment ==
                              ChartDataLabelAlignment.outer ||
                          dataLabel.labelAlignment ==
                              ChartDataLabelAlignment.top)
                      ? dataLabel.labelAlignment
                      : ChartDataLabelAlignment.auto)
                  : dataLabel.labelAlignment,
              series,
              textSize,
              dataLabel.borderWidth,
              index,
              chartLocation,
              chart,
              transposed,
              margin);
          if (isRangeSeries) {
            chartLocation2.x = _calculateRectPosition(
                chartLocation2.x,
                point.region,
                minus,
                dataLabel.labelAlignment == ChartDataLabelAlignment.top
                    ? ChartDataLabelAlignment.auto
                    : ChartDataLabelAlignment.top,
                series,
                textSize,
                dataLabel.borderWidth,
                index,
                chartLocation,
                chart,
                transposed,
                margin);
          }
        }
      }
      Rect rect, rect2;
      rect = _calculateLabelRect(chartLocation, textSize, margin);
      rect = (chart._chartState.initialRender ||
              chart._chartState.widgetNeedUpdate)
          ? _validateRect(rect, clipRect)
          : rect;
      if (isRangeSeries) {
        rect2 = _calculateLabelRect(chartLocation2, textSize2, margin);
        rect2 = (chart._chartState.initialRender ||
                chart._chartState.widgetNeedUpdate)
            ? _validateRect(rect2, clipRect)
            : rect2;
      }

      if (dataLabel.color != null ||
          dataLabel.useSeriesColor ||
          (dataLabel.borderColor != null && dataLabel.borderWidth > 0)) {
        final RRect fillRect =
            _calculatePaddedFillRect(rect, dataLabel.borderRadius, margin);
        point.labelLocation = _ChartLocation(
            fillRect.center.dx - textSize.width / 2,
            fillRect.center.dy - textSize.height / 2);
        point.dataLabelRegion = Rect.fromLTWH(point.labelLocation.x,
            point.labelLocation.y, textSize.width, textSize.height);
        if (margin == const EdgeInsets.all(0)) {
          point.labelFillRect = fillRect;
        } else {
          final Rect rect = fillRect.middleRect;
          point.labelLocation = _ChartLocation(
              rect.left + rect.width / 2 - textSize.width / 2,
              rect.top + rect.height / 2 - textSize.height / 2);
          point.dataLabelRegion = Rect.fromLTWH(point.labelLocation.x,
              point.labelLocation.y, textSize.width, textSize.height);
          point.labelFillRect = _rectToRrect(rect, dataLabel.borderRadius);
        }
        if (isRangeSeries) {
          final RRect fillRect2 =
              _calculatePaddedFillRect(rect2, dataLabel.borderRadius, margin);
          point.labelLocation2 = _ChartLocation(
              fillRect2.center.dx - textSize2.width / 2,
              fillRect2.center.dy - textSize2.height / 2);
          point.dataLabelRegion2 = Rect.fromLTWH(point.labelLocation2.x,
              point.labelLocation2.y, textSize2.width, textSize2.height);
          if (margin == const EdgeInsets.all(0)) {
            point.labelFillRect2 = fillRect2;
          } else {
            final Rect rect2 = fillRect2.middleRect;
            point.labelLocation2 = _ChartLocation(
                rect2.left + rect2.width / 2 - textSize2.width / 2,
                rect2.top + rect2.height / 2 - textSize2.height / 2);
            point.dataLabelRegion2 = Rect.fromLTWH(point.labelLocation2.x,
                point.labelLocation2.y, textSize2.width, textSize2.height);
            point.labelFillRect2 = _rectToRrect(rect2, dataLabel.borderRadius);
          }
        }
      } else {
        point.labelLocation = _ChartLocation(
            rect.left + rect.width / 2 - textSize.width / 2,
            rect.top + rect.height / 2 - textSize.height / 2);
        point.dataLabelRegion = Rect.fromLTWH(point.labelLocation.x,
            point.labelLocation.y, textSize.width, textSize.height);
        if (isRangeSeries) {
          point.labelLocation2 = _ChartLocation(
              rect2.left + rect2.width / 2 - textSize2.width / 2,
              rect2.top + rect2.height / 2 - textSize2.height / 2);
          point.dataLabelRegion2 = Rect.fromLTWH(point.labelLocation2.x,
              point.labelLocation2.y, textSize2.width, textSize2.height);
        }
      }
    }
  }
}

double _calculatePathPosition(
    double labelLocation,
    ChartDataLabelAlignment position,
    Size size,
    double borderWidth,
    CartesianSeries<dynamic, dynamic> series,
    int index,
    bool inverted,
    _ChartLocation point,
    SfCartesianChart chart,
    CartesianChartPoint<dynamic> currentPoint,
    Size markerSize) {
  const double padding = 5;
  final bool needFill = series.dataLabelSettings.color != null ||
      series.dataLabelSettings.color != Colors.transparent ||
      series.dataLabelSettings.useSeriesColor;
  final num fillSpace = needFill ? padding : 0;
  if (series._seriesType.contains('area') &&
      series._seriesType != 'rangearea' &&
      series._yAxis.isInversed) {
    position = position == ChartDataLabelAlignment.top
        ? ChartDataLabelAlignment.bottom
        : (position == ChartDataLabelAlignment.bottom
            ? ChartDataLabelAlignment.top
            : position);
  }
  switch (position) {
    case ChartDataLabelAlignment.top:
    case ChartDataLabelAlignment.outer:
      labelLocation = labelLocation -
          markerSize.height -
          borderWidth -
          (size.height / 2) -
          padding -
          fillSpace;
      break;
    case ChartDataLabelAlignment.bottom:
      labelLocation = labelLocation +
          markerSize.height +
          borderWidth +
          (size.height / 2) +
          padding +
          fillSpace;
      break;
    case ChartDataLabelAlignment.auto:
      labelLocation = _calculatePathActualPosition(
          series,
          size,
          index,
          inverted,
          borderWidth,
          point,
          chart,
          currentPoint,
          series._yAxis.isInversed);
      break;
    case ChartDataLabelAlignment.middle:
      break;
  }
  return labelLocation;
}

///Below method is for dataLabel alignment calculation
double _calculateAlignment(double value, double labelLocation,
    ChartAlignment alignment, bool isMinus, bool inverted) {
  switch (alignment) {
    case ChartAlignment.far:
      labelLocation = !inverted
          ? (isMinus ? labelLocation + value : labelLocation - value)
          : (isMinus ? labelLocation - value : labelLocation + value);
      break;
    case ChartAlignment.near:
      labelLocation = !inverted
          ? (isMinus ? labelLocation - value : labelLocation + value)
          : (isMinus ? labelLocation + value : labelLocation - value);
      break;
    case ChartAlignment.center:
      labelLocation = labelLocation;
      break;
  }
  return labelLocation;
}

double _calculatePathActualPosition(
    CartesianSeries<dynamic, dynamic> series,
    Size size,
    int index,
    bool inverted,
    double borderWidth,
    _ChartLocation point,
    SfCartesianChart chart,
    CartesianChartPoint<dynamic> currentPoint,
    bool inversed) {
  final List<CartesianChartPoint<dynamic>> points = series._dataPoints;
  final num yValue = points[index].yValue;
  ChartDataLabelAlignment position;
  final CartesianChartPoint<dynamic> nextPoint =
      points.length - 1 > index ? points[index + 1] : null;
  final CartesianChartPoint<dynamic> previousPoint =
      index > 0 ? points[index - 1] : null;
  double yLocation;
  bool isOverLap = true;
  Rect labelRect;
  bool isBottom;
  int positionIndex;
  if (series._seriesType == 'bubble' || index == points.length - 1) {
    position = ChartDataLabelAlignment.top;
  } else {
    if (index == 0) {
      position = (!nextPoint.isVisible ||
              yValue > nextPoint.yValue ||
              (yValue < nextPoint.yValue && inversed))
          ? ChartDataLabelAlignment.top
          : ChartDataLabelAlignment.bottom;
    } else if (index == points.length - 1) {
      position = (!previousPoint.isVisible ||
              yValue > previousPoint.yValue ||
              (yValue < previousPoint.yValue && inversed))
          ? ChartDataLabelAlignment.top
          : ChartDataLabelAlignment.bottom;
    } else {
      if (!nextPoint.isVisible && !previousPoint.isVisible) {
        position = ChartDataLabelAlignment.top;
      } else if (!nextPoint.isVisible) {
        position = (nextPoint.yValue > yValue || previousPoint.yValue > yValue)
            ? ChartDataLabelAlignment.bottom
            : ChartDataLabelAlignment.top;
      } else {
        final num slope = (nextPoint.yValue - previousPoint.yValue) / 2;
        final num intersectY =
            (slope * index) + (nextPoint.yValue - (slope * (index + 1)));
        position = !inversed
            ? intersectY < yValue
                ? ChartDataLabelAlignment.top
                : ChartDataLabelAlignment.bottom
            : intersectY < yValue
                ? ChartDataLabelAlignment.bottom
                : ChartDataLabelAlignment.top;
      }
    }
  }

  isBottom = position == ChartDataLabelAlignment.bottom;
  final List<String> dataLabelPosition = List<String>(5);
  dataLabelPosition[0] = 'DataLabelPosition.Outer';
  dataLabelPosition[1] = 'DataLabelPosition.Top';
  dataLabelPosition[2] = 'DataLabelPosition.Bottom';
  dataLabelPosition[3] = 'DataLabelPosition.Middle';
  dataLabelPosition[4] = 'DataLabelPosition.Auto';
  positionIndex = dataLabelPosition.indexOf(position.toString()).toInt();
  while (isOverLap && positionIndex < 4) {
    yLocation = _calculatePathPosition(
        point.y.toDouble(),
        position,
        size,
        borderWidth,
        series,
        index,
        inverted,
        point,
        chart,
        currentPoint,
        Size(
            series.markerSettings.width / 2, series.markerSettings.height / 2));
    labelRect = _calculateLabelRect(_ChartLocation(point.x, yLocation), size,
        series.dataLabelSettings.margin);
    isOverLap = labelRect.top < 0 ||
        ((labelRect.top + labelRect.height) >
            chart._chartAxis._axisClipRect.height) ||
        _isCollide(labelRect, chart._chartState.renderDatalabelRegions);
    positionIndex = isBottom ? positionIndex - 1 : positionIndex + 1;
    isBottom = false;
  }
  return yLocation;
}

ChartDataLabelAlignment _getPosition(int position) {
  ChartDataLabelAlignment dataLabelPosition;
  switch (position) {
    case 0:
      dataLabelPosition = ChartDataLabelAlignment.outer;
      break;
    case 1:
      dataLabelPosition = ChartDataLabelAlignment.top;
      break;
    case 2:
      dataLabelPosition = ChartDataLabelAlignment.bottom;
      break;
    case 3:
      dataLabelPosition = ChartDataLabelAlignment.middle;
      break;
    case 4:
      dataLabelPosition = ChartDataLabelAlignment.auto;
      break;
  }
  return dataLabelPosition;
}

Rect _calculateLabelRect(
        _ChartLocation location, Size textSize, EdgeInsets margin) =>
    Rect.fromLTWH(
        location.x - (textSize.width / 2) - margin.left,
        location.y - (textSize.height / 2) - margin.top,
        textSize.width + margin.left + margin.right,
        textSize.height + margin.top + margin.bottom);

/// Below method is for Rendering data label
void _drawDataLabel(
    Canvas canvas,
    CartesianSeries<dynamic, dynamic> series,
    SfCartesianChart chart,
    DataLabelSettings dataLabel,
    CartesianChartPoint<dynamic> point,
    int index,
    Animation<double> dataLabelAnimation) {
  final double opacity =
      dataLabelAnimation != null ? dataLabelAnimation.value : 1;
  DataLabelRenderArgs dataLabelArgs;
  ChartTextStyle dataLabelStyle;
  String label = point.dataLabelMapper ?? point.label;
  final String label2 = point.dataLabelMapper ?? point.label2;
  final bool isRangeSeries = series._seriesType.contains('range');
  dataLabelStyle = dataLabel.textStyle;
  if (chart.onDataLabelRender != null) {
    dataLabelArgs = DataLabelRenderArgs();
    dataLabelArgs.text = label;
    dataLabelArgs.textStyle = dataLabelStyle;
    dataLabelArgs.series = series;
    dataLabelArgs.dataPoints = series._dataPoints;
    dataLabelArgs.pointIndex = index;
    chart.onDataLabelRender(dataLabelArgs);
    label = point.label = dataLabelArgs.text;
    dataLabelStyle = dataLabelArgs.textStyle;
    index = dataLabelArgs.pointIndex;
  }
  if (label != null &&
      point != null &&
      point.isVisible &&
      point.isGap != true) {
    final ChartTextStyle font =
        (dataLabelStyle == null) ? ChartTextStyle() : dataLabelStyle;
    final Color fontColor = font.color != null
        ? font.color
        : _getDataLabelSaturationColor(point, series, chart);
    final Rect labelRect = (point.labelFillRect != null)
        ? Rect.fromLTWH(point.labelFillRect.left, point.labelFillRect.top,
            point.labelFillRect.width, point.labelFillRect.height)
        : Rect.fromLTWH(point.labelLocation.x, point.labelLocation.y,
            point.dataLabelRegion.width, point.dataLabelRegion.height);
    final bool isDatalabelCollide =
        _isCollide(labelRect, chart._chartState.renderDatalabelRegions);
    if (label.isNotEmpty && isDatalabelCollide
        ? dataLabel.labelIntersectAction == LabelIntersectAction.none
        : true) {
      final ChartTextStyle textStyle = ChartTextStyle(
          color: fontColor.withOpacity(opacity),
          fontSize: font.fontSize,
          fontFamily: font.fontFamily,
          fontStyle: font.fontStyle,
          fontWeight: font.fontWeight);
      if (dataLabel.color != null ||
          dataLabel.useSeriesColor ||
          (dataLabel.borderColor != null && dataLabel.borderWidth > 0)) {
        final RRect fillRect = point.labelFillRect;
        final Path path = Path();
        path.addRRect(fillRect);
        final RRect fillRect2 = point.labelFillRect2;
        final Path path2 = Path();
        if (isRangeSeries) {
          path2.addRRect(fillRect2);
        }
        if (dataLabel.borderColor != null && dataLabel.borderWidth > 0) {
          final Paint strokePaint = Paint()
            ..color = dataLabel.borderColor.withOpacity(
                (opacity - (1 - dataLabel.opacity)) < 0
                    ? 0
                    : opacity - (1 - dataLabel.opacity))
            ..strokeWidth = dataLabel.borderWidth
            ..style = PaintingStyle.stroke;
          dataLabel.borderWidth == 0
              ? strokePaint.color = Colors.transparent
              : strokePaint.color = strokePaint.color;
          canvas.drawPath(path, strokePaint);
          if (isRangeSeries) {
            canvas.drawPath(path2, strokePaint);
          }
        }
        if (dataLabel.color != null || dataLabel.useSeriesColor) {
          final Paint paint = Paint()
            ..color = (dataLabel.color ??
                    (point.pointColorMapper ?? series._seriesColor))
                .withOpacity((opacity - (1 - dataLabel.opacity)) < 0
                    ? 0
                    : opacity - (1 - dataLabel.opacity))
            ..style = PaintingStyle.fill;
          canvas.drawPath(path, paint);
          if (isRangeSeries) {
            canvas.drawPath(path2, paint);
          }
        }
      }

      series.drawDataLabel(
          index,
          canvas,
          label,
          dataLabel.angle != 0
              ? point.dataLabelRegion.center.dx
              : point.labelLocation.x,
          dataLabel.angle != 0
              ? point.dataLabelRegion.center.dy
              : point.labelLocation.y,
          dataLabel.angle,
          textStyle);

      if (isRangeSeries) {
        series.drawDataLabel(index, canvas, label2, point.labelLocation2.x,
            point.labelLocation2.y, dataLabel.angle, textStyle);
      }
      chart._chartState.renderDatalabelRegions.add(labelRect);
    }
  }
}

/// Following method returns the data label text
String _getLabelText(dynamic labelValue,
    CartesianSeries<dynamic, dynamic> series, SfCartesianChart chart) {
  if (labelValue is double) {
    final String str = labelValue.toString();
    final List<dynamic> list = str.split('.');
    labelValue = double.parse(labelValue.toStringAsFixed(6));
    if (list[1] == '0' ||
        list[1] == '00' ||
        list[1] == '000' ||
        list[1] == '0000' ||
        list[1] == '00000' ||
        list[1] == '000000') {
      labelValue = labelValue.round();
    }
  }
  final dynamic yAxis = series._yAxis;
  final dynamic value = yAxis.numberFormat != null
      ? yAxis.numberFormat.format(labelValue)
      : labelValue;
  return (yAxis.labelFormat != null && yAxis.labelFormat != '')
      ? yAxis.labelFormat.replaceAll(RegExp('{value}'), value.toString())
      : value.toString();
}

/// Calculating rect position for dataLabel
double _calculateRectPosition(
    double labelLocation,
    Rect rect,
    bool isMinus,
    ChartDataLabelAlignment position,
    CartesianSeries<dynamic, dynamic> series,
    Size textSize,
    double borderWidth,
    int index,
    _ChartLocation point,
    SfCartesianChart chart,
    bool inverted,
    EdgeInsets margin) {
  const double padding = 5;
  final bool needFill = series.dataLabelSettings.color != null ||
      series.dataLabelSettings.color != Colors.transparent ||
      series.dataLabelSettings.useSeriesColor;
  final double textLength = !inverted ? textSize.height : textSize.width;
  final double extraSpace =
      borderWidth + textLength / 2 + padding + (needFill ? padding : 0);
  if (series._seriesType.contains('stack')) {
    position = position == ChartDataLabelAlignment.outer
        ? ChartDataLabelAlignment.top
        : position;
  }

  /// Locating the data label based on position
  switch (position) {
    case ChartDataLabelAlignment.bottom:
      labelLocation = !inverted
          ? (isMinus
              ? (labelLocation - rect.height + extraSpace)
              : (labelLocation + rect.height - extraSpace))
          : (isMinus
              ? (labelLocation + rect.width - extraSpace)
              : (labelLocation - rect.width + extraSpace));
      break;
    case ChartDataLabelAlignment.middle:
      labelLocation = !inverted
          ? (isMinus
              ? labelLocation - (rect.height / 2)
              : labelLocation + (rect.height / 2))
          : (isMinus
              ? labelLocation + (rect.width / 2)
              : labelLocation - (rect.width / 2));
      break;
    case ChartDataLabelAlignment.auto:
      labelLocation = _calculateRectActualPosition(labelLocation, rect, isMinus,
          series, textSize, index, point, inverted, borderWidth, chart, margin);
      break;
    default:
      labelLocation = _calculateTopAndOuterPosition(
          textSize,
          labelLocation,
          rect,
          position,
          series,
          index,
          extraSpace,
          isMinus,
          point,
          inverted,
          borderWidth,
          chart);
      break;
  }
  return labelLocation;
}

/// Calculating the label location if position is given as auto
double _calculateRectActualPosition(
    double labelLocation,
    Rect rect,
    bool minus,
    CartesianSeries<dynamic, dynamic> series,
    Size textSize,
    int index,
    _ChartLocation point,
    bool inverted,
    double borderWidth,
    SfCartesianChart chart,
    EdgeInsets margin) {
  double location;
  Rect labelRect;
  bool isOverLap = true;
  int position = 0;
  final int finalPosition = series._seriesType.contains('range') ? 2 : 4;
  while (isOverLap && position < finalPosition) {
    location = _calculateRectPosition(
        labelLocation,
        rect,
        minus,
        _getPosition(position),
        series,
        textSize,
        borderWidth,
        index,
        point,
        chart,
        inverted,
        margin);
    if (!inverted) {
      labelRect = _calculateLabelRect(
          _ChartLocation(point.x, location), textSize, margin);
      isOverLap = labelRect.top < 0 ||
          labelRect.top > chart._chartAxis._axisClipRect.height ||
          _isCollide(labelRect, chart._chartState.renderDatalabelRegions);
    } else {
      labelRect = _calculateLabelRect(
          _ChartLocation(location, point.y), textSize, margin);
      isOverLap = labelRect.left < 0 ||
          labelRect.left + labelRect.width >
              chart._chartAxis._axisClipRect.right ||
          _isCollide(labelRect, chart._chartState.renderDatalabelRegions);
    }
    series._dataPoints[index].dataLabelSaturationRegionInside =
        isOverLap || series._dataPoints[index].dataLabelSaturationRegionInside
            ? true
            : false;
    position++;
  }
  return location;
}

///calculation for top and outer position of datalabel for rect series
double _calculateTopAndOuterPosition(
    Size textSize,
    double location,
    Rect rect,
    ChartDataLabelAlignment position,
    CartesianSeries<dynamic, dynamic> series,
    int index,
    double extraSpace,
    bool isMinus,
    _ChartLocation point,
    bool inverted,
    double borderWidth,
    SfCartesianChart chart) {
  final num markerHeight =
      series.markerSettings.isVisible ? series.markerSettings.height / 2 : 0;
  if (((isMinus && !series._seriesType.contains('range')) &&
          position == ChartDataLabelAlignment.top) ||
      ((!isMinus || series._seriesType.contains('range')) &&
          position == ChartDataLabelAlignment.outer)) {
    location = !inverted
        ? location - extraSpace - markerHeight
        : location + extraSpace + markerHeight;
  } else {
    location = !inverted
        ? location + extraSpace + markerHeight
        : location - extraSpace - markerHeight;
  }
  return location;
}

/// Add padding for fill rect (if datalabel fill color is given)
RRect _calculatePaddedFillRect(Rect rect, num radius, EdgeInsets margin) {
  rect = Rect.fromLTRB(rect.left - margin.left, rect.top - margin.top,
      rect.right + margin.right, rect.bottom + margin.bottom);

  return _rectToRrect(rect, radius);
}

/// Converting rect into rounded rect
RRect _rectToRrect(Rect rect, num radius) => RRect.fromRectAndCorners(rect,
    topLeft: Radius.elliptical(radius, radius),
    topRight: Radius.elliptical(radius, radius),
    bottomLeft: Radius.elliptical(radius, radius),
    bottomRight: Radius.elliptical(radius, radius));

/// Checking the condition whether data Label has been exist in the clip rect
Rect _validateRect(Rect rect, Rect clipRect) {
  const int padding = 10;
  if (clipRect.top > rect.top ||
      clipRect.left > rect.left ||
      clipRect.right < rect.right ||
      clipRect.bottom < rect.bottom) {
    num left, top;
    left = rect.left < clipRect.left ? clipRect.left + padding / 2 : rect.left;
    top = rect.top < clipRect.top ? clipRect.top + padding / 2 : rect.top;
    left -= ((left + rect.width) > clipRect.width)
        ? (left + rect.width) - clipRect.right + padding
        : 0;
    top -= (top + rect.height) > clipRect.bottom
        ? (top + rect.height) - clipRect.bottom + padding
        : 0;
    left = left < clipRect.left ? clipRect.left + padding / 2 : left;
    rect = Rect.fromLTWH(left, top, rect.width, rect.height);
  }
  return rect;
}
