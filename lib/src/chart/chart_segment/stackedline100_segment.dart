part of charts;

/// Creates the segments for 100% stacked line series.
class StackedLine100Segment extends ChartSegment {
  num x1,
      y1,
      x2,
      y2,
      _currentCummulativePos,
      _nextCummulativePos,
      currentCummulativeValue,
      nextCummulativeValue,
      _x1Pos,
      _y1Pos,
      _x2Pos,
      _y2Pos;

  Color _pointColorMapper;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    final Paint fillPaint = Paint();
    if (color != null) {
      fillPaint.color = _pointColorMapper ?? color.withOpacity(series.opacity);
    }
    fillPaint.strokeWidth = strokeWidth;
    fillPaint.style = PaintingStyle.fill;
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the stroke color of the series.
  @override
  Paint getStrokePaint() {
    final Paint strokePaint = Paint();
    if (series.gradient == null) {
      if (strokeColor != null) {
        strokePaint.color =
            _pointColorMapper ?? strokeColor.withOpacity(series.opacity);
      }
    } else {
      strokePaint.color = series.gradient.colors[0];
    }
    strokePaint.strokeWidth = strokeWidth;
    strokePaint.style = PaintingStyle.stroke;
    strokePaint.strokeCap = StrokeCap.round;
    _defaultStrokeColor = strokePaint;
    return strokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    final dynamic start = series._xAxis._visibleRange.minimum;
    final dynamic end = series._xAxis._visibleRange.maximum;
    x1 = y1 = x2 = y2 = double.nan;
    final Rect rect = _calculatePlotOffset(
        series._chart._chartAxis._axisClipRect,
        Offset(series._xAxis.plotOffset, series._yAxis.plotOffset));
    if ((_x1Pos != null &&
            _x2Pos != null &&
            _y1Pos != null &&
            _y2Pos != null &&
            _currentCummulativePos != null &&
            _nextCummulativePos != null) &&
        ((_x1Pos >= start && _x1Pos <= end) ||
            (_x2Pos >= start && _x2Pos <= end) ||
            (start >= _x1Pos && start <= _x2Pos))) {
      final _ChartLocation currentChartPoint = _calculatePoint(
          _x1Pos,
          _y1Pos,
          series._xAxis,
          series._yAxis,
          series._chart._requireInvertedAxis,
          series,
          rect);
      final _ChartLocation nextPoint = _calculatePoint(
          _x2Pos,
          _y2Pos,
          series._xAxis,
          series._yAxis,
          series._chart._requireInvertedAxis,
          series,
          rect);

      final _ChartLocation currentCummulativePoint = _calculatePoint(
          _x1Pos,
          _currentCummulativePos,
          series._xAxis,
          series._yAxis,
          series._chart._requireInvertedAxis,
          series,
          rect);

      final _ChartLocation nextCummulativePoint = _calculatePoint(
          _x2Pos,
          _nextCummulativePos,
          series._xAxis,
          series._yAxis,
          series._chart._requireInvertedAxis,
          series,
          rect);

      x1 = currentChartPoint.x;
      y1 = currentChartPoint.y;
      x2 = nextPoint.x;
      y2 = nextPoint.y;
      currentCummulativeValue = currentCummulativePoint.y;
      nextCummulativeValue = nextCummulativePoint.y;
    }
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    renderStackedLineSeries(series, canvas, strokePaint);
  }

  /// Method to set data.
  void _setData(List<num> values) {
    _x1Pos = values[0];
    _y1Pos = values[1];
    _x2Pos = values[3];
    _y2Pos = values[4];
    _currentCummulativePos = values[2];
    _nextCummulativePos = values[5];
  }
}
