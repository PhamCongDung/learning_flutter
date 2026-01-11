import 'dart:async';

class DashboardState {
  final int count;
  final bool isRunning;
  const DashboardState({required this.count, required this.isRunning});
}

class DashboardController {
  final StreamController<DashboardState> _controller =
      StreamController<DashboardState>.broadcast();
  Stream<DashboardState> get stream => _controller.stream;
  Timer? _timer;
  int _count = 0;
  bool get isRunning => _timer?.isActive == true;
  DashboardState get current =>
      DashboardState(count: _count, isRunning: isRunning);
  void _emit() {
    _controller.add(current);
  }

  void start() {
    if (isRunning) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _count++;
      _emit();
    });
    _emit();
  }

  void stop() {
    if (!isRunning) return;
    _timer?.cancel();
    _timer = null;
    _emit();
  }

  void reset() {
    stop();
    _count = 0;
    _emit();
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
