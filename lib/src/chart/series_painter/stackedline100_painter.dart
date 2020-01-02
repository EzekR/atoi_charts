part of charts;

class _StackedLine100ChartPainter extends CustomPainter {
  _StackedLine100ChartPainter({
    this.chart,
    this.series,
    this.isRepaint,
    this.animationController,
    this.seriesAnimation,
    this.chartElementAnimation,
    ValueNotifier<num> notifier,
  }) : super(repaint: notifier);
  final SfCartesianChart chart;
  final bool isRepaint;
  final AnimationController animationController;
  final Animation<double> seriesAnimation;
  final Animation<double> chartElementAnimation;
  final XyDataSeries<dynamic, dynamic> series;

  @override
  void paint(Canvas canvas, Size size) {
    stackedLinePainter(canvas, series, seriesAnimation, chartElementAnimation);
  }

  @override
  bool shouldRepaint(_StackedLine100ChartPainter oldDelegate) => isRepaint;
}
