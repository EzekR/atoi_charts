part of charts;

class _StackedLineChartPainter extends CustomPainter {
  _StackedLineChartPainter({
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
  bool shouldRepaint(_StackedLineChartPainter oldDelegate) => isRepaint;
}
