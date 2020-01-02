part of charts;

/// Creates the segments for area series.
class RangeAreaSegment extends ChartSegment {
  Path _path;

  ///for storing the path in RangeAreaBorderMode.excludeSides mode
  Path _borderPath;
  Rect _pathRect;

  ///Range area series
  XyDataSeries<dynamic, dynamic> series;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    fillPaint = Paint();
    if (series.gradient == null) {
      if (color != null) {
        fillPaint.color = color;
        fillPaint.style = PaintingStyle.fill;
      }
    } else {
      fillPaint = (_pathRect != null)
          ? _getLinearGradientPaint(
              series.gradient, _pathRect, series._chart._requireInvertedAxis)
          : fillPaint;
    }
    fillPaint.color = fillPaint.color.withOpacity(series.opacity);
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint getStrokePaint() {
    final Paint strokePaint = Paint();
    if (strokeColor != null) {
      strokePaint
        ..color = series.borderColor.withOpacity(series.opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = series.borderWidth;
      series.borderWidth == 0
          ? strokePaint.color = Colors.transparent
          : strokePaint.color;
    }
    strokePaint.strokeCap = StrokeCap.round;
    _defaultStrokeColor = strokePaint;
    return strokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {}

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    final Rect rect = series._chart._chartAxis._axisClipRect;
    CartesianChartPoint<dynamic> prevPoint;
    _ChartLocation currentPointLow, currentPointHigh;
    final ChartAxis xAxis = series._xAxis;
    final ChartAxis yAxis = series._yAxis;
    CartesianChartPoint<dynamic> point;
    _path = Path();
    _borderPath = Path();
    for (int pointIndex = 0;
        pointIndex < series._dataPoints.length;
        pointIndex++) {
      point = series._dataPoints[pointIndex];
      if (point.isVisible && !point.isDrop) {
        currentPointLow = _calculatePoint(point.xValue, point.low, xAxis, yAxis,
            series._chart._requireInvertedAxis, series, rect);
        currentPointHigh = _calculatePoint(point.xValue, point.high, xAxis,
            yAxis, series._chart._requireInvertedAxis, series, rect);

        if (prevPoint == null ||
            series._dataPoints[pointIndex - 1].isGap == true ||
            (series._dataPoints[pointIndex].isGap == true) ||
            (series._dataPoints[pointIndex - 1].isVisible == false &&
                series.emptyPointSettings.mode == EmptyPointMode.gap)) {
          _path.moveTo(currentPointLow.x, currentPointLow.y);
          _path.lineTo(currentPointHigh.x, currentPointHigh.y);
          _borderPath.moveTo(currentPointHigh.x, currentPointHigh.y);
        } else if (pointIndex == series._dataPoints.length - 1 ||
            series._dataPoints[pointIndex + 1].isGap == true) {
          _path.lineTo(currentPointHigh.x, currentPointHigh.y);
          _path.lineTo(currentPointLow.x, currentPointLow.y);
          _borderPath.lineTo(currentPointHigh.x, currentPointHigh.y);
          _borderPath.moveTo(currentPointLow.x, currentPointLow.y);
        } else {
          _borderPath.lineTo(currentPointHigh.x, currentPointHigh.y);
          _path.lineTo(currentPointHigh.x, currentPointHigh.y);
        }
        prevPoint = point;
      }
    }
    for (int pointIndex = series._dataPoints.length - 2;
        pointIndex >= 0;
        pointIndex--) {
      point = series._dataPoints[pointIndex];
      if (point.isVisible && !point.isDrop) {
        currentPointLow = _calculatePoint(point.xValue, point.low, xAxis, yAxis,
            series._chart._requireInvertedAxis, series, rect);
        currentPointHigh = _calculatePoint(point.xValue, point.high, xAxis,
            yAxis, series._chart._requireInvertedAxis, series, rect);

        if (series._dataPoints[pointIndex + 1].isGap == true) {
          _borderPath.moveTo(currentPointLow.x, currentPointLow.y);
          _path.moveTo(currentPointLow.x, currentPointLow.y);
        } else if (series._dataPoints[pointIndex].isGap != true) {
          _borderPath.lineTo(currentPointLow.x, currentPointLow.y);
          _path.lineTo(currentPointLow.x, currentPointLow.y);
        }

        prevPoint = point;
      }
    }
    _pathRect = _path.getBounds();
    series.selectionSettings._selectionRenderer
        ._checkWithSelectionState(series.segments[0], series._chart);
    canvas.drawPath(
        _path, (series.gradient == null) ? fillPaint : getFillPaint());

    if (strokePaint.color != Colors.transparent) {
      final RangeAreaSeries<dynamic, dynamic> _series = series;
      _drawDashedLine(
          canvas,
          series,
          strokePaint,
          _series.borderDrawMode == RangeAreaBorderMode.all
              ? _path
              : _borderPath);
    }
  }
}
