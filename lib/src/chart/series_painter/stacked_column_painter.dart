part of charts;

class _StackedColummnChartPainter extends CustomPainter {
  _StackedColummnChartPainter({
    this.chart,
    this.series,
    this.isRepaint,
    this.animationController,
    this.seriesAnimation,
    this.chartElementAnimation,
    ValueNotifier<num> notifier,
  }) : super(repaint: notifier);

  final SfCartesianChart chart;
  CartesianChartPoint<dynamic> point;
  final bool isRepaint;
  final AnimationController animationController;
  final Animation<double> seriesAnimation;
  final Animation<double> chartElementAnimation;
  List<_ChartLocation> currentChartLocations = <_ChartLocation>[];
  StackedColumnSeries<dynamic, dynamic> series;

  @override
  void paint(Canvas canvas, Size size) {
    stackedRectPainter(canvas, series, seriesAnimation, chartElementAnimation);
  }

  @override
  bool shouldRepaint(_StackedColummnChartPainter oldDelegate) => isRepaint;
}
