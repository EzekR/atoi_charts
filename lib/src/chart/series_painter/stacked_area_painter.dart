part of charts;

class _StackedAreaChartPainter extends CustomPainter {
  _StackedAreaChartPainter(
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
  bool shouldRepaint(_StackedAreaChartPainter oldDelegate) => isRepaint;
}
