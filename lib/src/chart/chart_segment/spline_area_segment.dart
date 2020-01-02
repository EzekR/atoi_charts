part of charts;

/// Creates the segments for area series.
class SplineAreaSegment extends ChartSegment {
  Path _path, _strokePath;
  Rect _pathRect;
  List<CartesianChartPoint<dynamic>> points = <CartesianChartPoint<dynamic>>[];

  ///SplineArea series
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
    _path = Path();
    _strokePath = Path();
    final ChartAxis xAxis = series._xAxis;
    final ChartAxis yAxis = series._yAxis;
    SplineAreaSeries<dynamic, dynamic> splineAreaSeries;
    _ChartLocation startPoint,
        startPoint1,
        renderPoint,
        renderControlPoint1,
        renderControlPoint2;
    List<_ControlPoints> controlPoint;
    splineAreaSeries = series;
    final int pointsLength = series._dataPoints.length;
    CartesianChartPoint<dynamic> firstPoint, point;
    for (int i = 0; i < pointsLength; i++) {
      point = series._dataPoints[i];
      if (point.isVisible) {
        if (firstPoint != null) {
          controlPoint = series
              .drawControlPoints[series._dataPoints.indexOf(point) - 1]
              ._listControlPoints;
          renderPoint = _calculatePoint(point.xValue, point.yValue, xAxis,
              yAxis, series._chart._requireInvertedAxis, series, rect);
          renderControlPoint1 = _calculatePoint(
              controlPoint[0].controlPoint1,
              controlPoint[0].controlPoint2,
              xAxis,
              yAxis,
              series._chart._requireInvertedAxis,
              series,
              rect);
          renderControlPoint2 = _calculatePoint(
              controlPoint[1].controlPoint1,
              controlPoint[1].controlPoint2,
              xAxis,
              yAxis,
              series._chart._requireInvertedAxis,
              series,
              rect);
          _path.cubicTo(
              renderControlPoint1.x,
              renderControlPoint1.y,
              renderControlPoint2.x,
              renderControlPoint2.y,
              renderPoint.x,
              renderPoint.y);
          _strokePath.cubicTo(
              renderControlPoint1.x,
              renderControlPoint1.y,
              renderControlPoint2.x,
              renderControlPoint2.y,
              renderPoint.x,
              renderPoint.y);
        } else {
          startPoint = _calculatePoint(
              series._dataPoints[i].xValue,
              math_lib.max(yAxis._visibleRange.minimum, 0),
              xAxis,
              yAxis,
              series._chart._requireInvertedAxis,
              series,
              rect);
          _path.moveTo(startPoint.x, startPoint.y);
          if (splineAreaSeries.borderDrawMode != BorderDrawMode.top)
            _strokePath.moveTo(startPoint.x, startPoint.y);
          startPoint1 = _calculatePoint(
              series._dataPoints[i].xValue,
              series._dataPoints[i].yValue,
              xAxis,
              yAxis,
              series._chart._requireInvertedAxis,
              series,
              rect);
          _path.lineTo(startPoint1.x, startPoint1.y);
          _strokePath.lineTo(startPoint1.x, startPoint1.y);
          //  _strokePath.lineTo(renderPoint.x, renderPoint.y);
        }
        firstPoint = point;
      } else {
        if (i != 0 && point.isDrop == true) {
          firstPoint = point;
        } else
          firstPoint = null;
      }
      if (((i + 1 < pointsLength && !series._dataPoints[i + 1].isVisible) ||
              i == pointsLength - 1) &&
          renderPoint != null &&
          startPoint != null) {
        startPoint = _calculatePoint(
            i + 1 < pointsLength && series._dataPoints[i + 1].isDrop
                ? series._dataPoints[i].xValue
                : i == pointsLength - 1 && series._dataPoints[i].isDrop
                    ? series._dataPoints[i - 1].xValue
                    : series._dataPoints[i].xValue,
            i + 1 < pointsLength && series._dataPoints[i + 1].isDrop
                ? series._dataPoints[i].yValue
                : math_lib.max(yAxis._visibleRange.minimum, 0),
            xAxis,
            yAxis,
            series._chart._requireInvertedAxis,
            series,
            rect);
        _path.lineTo(startPoint.x, startPoint.y);
        if (splineAreaSeries.borderDrawMode != BorderDrawMode.top)
          _strokePath.lineTo(startPoint.x, startPoint.y);
      }
    }

    _pathRect = _path.getBounds();
    canvas.drawPath(
        _path, (series.gradient == null) ? fillPaint : getFillPaint());
    _drawDashedLine(canvas, series, strokePaint, _strokePath);
  }
}
