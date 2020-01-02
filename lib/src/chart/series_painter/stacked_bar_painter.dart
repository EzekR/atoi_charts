part of charts;

class _StackedBarChartPainter extends CustomPainter {
  _StackedBarChartPainter({
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
  StackedBarSeries<dynamic, dynamic> series;
  static double animation;

  @override
  void paint(Canvas canvas, Size size) {
    stackedRectPainter(canvas, series, seriesAnimation, chartElementAnimation);
  }

  @override
  bool shouldRepaint(_StackedBarChartPainter oldDelegate) => isRepaint;
}
