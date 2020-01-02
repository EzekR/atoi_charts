part of charts;

/// Creates the segments for 100% stacked column series.
class StackedColumn100Segment extends ChartSegment {
  num x1, y1, x2, y2;
  double stackValues;
  BorderRadius _borderRadius;
  CartesianChartPoint<dynamic> _currentPoint;
  Path path;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    final bool hasPointColor = series.pointColorMapper != null ? true : false;

    /// Get and set the paint options for column series.
    if (series.gradient == null) {
      if (color != null) {
        fillPaint = Paint()
          ..color = _currentPoint.isEmpty == true
              ? series.emptyPointSettings.color
              : ((hasPointColor && _currentPoint.pointColorMapper != null)
                  ? _currentPoint.pointColorMapper
                  : color)
          ..style = PaintingStyle.fill;
      }
    } else {
      fillPaint = _getLinearGradientPaint(series.gradient, _currentPoint.region,
          series._chart._requireInvertedAxis);
    }
    if (fillPaint.color != Colors.transparent)
      fillPaint.color = fillPaint.color.withOpacity(series.opacity);
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint getStrokePaint() {
    if (strokeColor != null) {
      strokePaint = Paint()
        ..color = _currentPoint.isEmpty == true
            ? series.emptyPointSettings.borderColor
            : strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = _currentPoint.isEmpty == true
            ? series.emptyPointSettings.borderWidth
            : strokeWidth;
      _defaultStrokeColor = strokePaint;
    }
    series.borderWidth == 0
        ? strokePaint.color = Colors.transparent
        : strokePaint.color;
    strokePaint.color = strokePaint.color == Colors.transparent
        ? strokePaint.color
        : strokePaint.color.withOpacity(series.opacity);
    return strokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    final StackedColumn100Series<dynamic, dynamic> stackedColumn100Series =
        series;
    _borderRadius = stackedColumn100Series.borderRadius;
    if (_currentPoint.region != null) {
      segmentRect = RRect.fromRectAndCorners(
        _currentPoint.region,
        bottomLeft: _borderRadius.bottomLeft,
        bottomRight: _borderRadius.bottomRight,
        topLeft: _borderRadius.topLeft,
        topRight: _borderRadius.topRight,
      );
    }

    path = dashedBorder(_currentPoint, series.borderWidth);
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    renderStackingRectSeries(fillPaint, strokePaint, path, animationFactor,
        series, canvas, segmentRect, _currentPoint);
  }

  /// Method to set data.
  void _setData(List<num> values) {
    x1 = values[0];
    y1 = values[1];
  }
}
