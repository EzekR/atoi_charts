part of charts;

/// Creates the segments for stacked area series.
class StackedAreaSegment extends ChartSegment {
  Rect _pathRect;

  ///Area series
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
    renderStackedAreaSeries(series, fillPaint, strokePaint, canvas, _pathRect,
        _seriesIndex, getFillPaint);
  }
}
