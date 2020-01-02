part of charts;

/// Creates the segments for  step area series.
class StepAreaSegment extends ChartSegment {
  Path _path, _strokePath;
  Rect _pathRect;

  ///Step Area series
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
    CartesianChartPoint<dynamic> prevPoint, point;
    _ChartLocation currentPoint, originPoint, previousPoint;
    final ChartAxis xAxis = series._xAxis;
    final ChartAxis yAxis = series._yAxis;
    final StepAreaSeries<dynamic, dynamic> areaSeries = series;
    _path = Path();
    _strokePath = Path();
    for (int pointIndex = 0;
        pointIndex < series._dataPoints.length;
        pointIndex++) {
      point = series._dataPoints[pointIndex];
      if (point.isVisible) {
        currentPoint = _calculatePoint(point.xValue, point.yValue, xAxis, yAxis,
            series._chart._requireInvertedAxis, series, rect);
        previousPoint = prevPoint != null
            ? _calculatePoint(prevPoint?.xValue, prevPoint?.yValue, xAxis,
                yAxis, series._chart._requireInvertedAxis, series, rect)
            : prevPoint;
        originPoint = _calculatePoint(
            point.xValue,
            math_lib.max(yAxis._visibleRange.minimum, 0),
            xAxis,
            yAxis,
            series._chart._requireInvertedAxis,
            series,
            rect);
        final num x = currentPoint.x;
        final num y = currentPoint.y;
        final bool closed =
            series.emptyPointSettings.mode == EmptyPointMode.drop
                ? _getVisibility(series._dataPoints, pointIndex)
                : false;
        if (prevPoint == null ||
            series._dataPoints[pointIndex - 1].isGap == true ||
            (series._dataPoints[pointIndex].isGap == true) ||
            (series._dataPoints[pointIndex - 1].isVisible == false &&
                series.emptyPointSettings.mode == EmptyPointMode.gap)) {
          _path.moveTo(originPoint.x, originPoint.y);
          if (areaSeries.borderDrawMode == BorderDrawMode.excludeBottom) {
            if (series._dataPoints[pointIndex].isGap != true) {
              _strokePath.moveTo(originPoint.x, originPoint.y);
              _strokePath.lineTo(x, y);
            }
          } else if (areaSeries.borderDrawMode == BorderDrawMode.all) {
            if (series._dataPoints[pointIndex].isGap != true) {
              _strokePath.moveTo(originPoint.x, originPoint.y);
              _strokePath.lineTo(x, y);
            }
          } else if (areaSeries.borderDrawMode == BorderDrawMode.top) {
            _strokePath.moveTo(x, y);
          }
          _path.lineTo(x, y);
        } else if (pointIndex == series._dataPoints.length - 1 ||
            series._dataPoints[pointIndex + 1].isGap == true) {
          _strokePath.lineTo(x, previousPoint.y);
          _strokePath.lineTo(x, y);
          if (areaSeries.borderDrawMode == BorderDrawMode.excludeBottom)
            _strokePath.lineTo(originPoint.x, originPoint.y);
          else if (areaSeries.borderDrawMode == BorderDrawMode.all) {
            _strokePath.lineTo(originPoint.x, originPoint.y);
            _strokePath.close();
          }
          _path.lineTo(x, previousPoint.y);
          _path.lineTo(x, y);
          _path.lineTo(originPoint.x, originPoint.y);
        } else {
          _path.lineTo(x, previousPoint.y);
          _strokePath.lineTo(x, previousPoint.y);
          _strokePath.lineTo(x, y);
          _path.lineTo(x, y);
          if (closed) {
            _path.lineTo(originPoint.x, originPoint.y);
            if (areaSeries.borderDrawMode == BorderDrawMode.excludeBottom) {
              _strokePath.lineTo(originPoint.x, originPoint.y);
            } else if (areaSeries.borderDrawMode == BorderDrawMode.all) {
              _strokePath.lineTo(originPoint.x, originPoint.y);
              _strokePath.close();
            }
          }
        }
        prevPoint = point;
      }
    }
    _pathRect = _path.getBounds();
    series.selectionSettings._selectionRenderer
        ._checkWithSelectionState(series.segments[0], series._chart);
    canvas.drawPath(
        _path, (series.gradient == null) ? fillPaint : getFillPaint());

    if (strokePaint.color != Colors.transparent)
      _drawDashedLine(canvas, series, strokePaint, _strokePath);
  }

  bool _getVisibility(List<CartesianChartPoint<dynamic>> points, int index) {
    for (int i = index; i < points.length - 1; i++) {
      if (!points[i + 1].isDrop) {
        return false;
      }
    }
    return true;
  }
}
