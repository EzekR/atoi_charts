part of charts;

class _StackedBar100ChartPainter extends CustomPainter {
  _StackedBar100ChartPainter({
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
  StackedBar100Series<dynamic, dynamic> series;
  static double animation;

  @override
  void paint(Canvas canvas, Size size) {
    stackedRectPainter(canvas, series, seriesAnimation, chartElementAnimation);
  }

  @override
  bool shouldRepaint(_StackedBar100ChartPainter oldDelegate) => isRepaint;
}
