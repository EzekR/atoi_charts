part of charts;

class _StackedArea100ChartPainter extends CustomPainter {
  _StackedArea100ChartPainter(
      {this.chart,
      this.series,
      this.isRepaint,
      this.animationController,
      this.seriesAnimation,
      this.chartElementAnimation,
      ValueNotifier<num> notifier})
      : super(repaint: notifier);
  final SfCartesianChart chart;
  final bool isRepaint;
  final Animation<double> seriesAnimation;
  final Animation<double> chartElementAnimation;
  final Animation<double> animationController;
  final XyDataSeries<dynamic, dynamic> series;

  @override
  void paint(Canvas canvas, Size size) {
    stackedAreaPainter(canvas, series, seriesAnimation, chartElementAnimation);
  }

  @override
  bool shouldRepaint(_StackedArea100ChartPainter oldDelegate) => isRepaint;
}
