import 'dart:async';
import 'dart:collection';

abstract class Runnable {
  void run() {}
}

class DelayObject {
  final String key;
  final Runnable value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DelayObject &&
          runtimeType == other.runtimeType &&
          key == other.key;

  @override
  int get hashCode => key.hashCode;

  DelayObject(this.key, this.value);
}

class DelayQueue {
  int _delayOfEachProducedMessageMillis = 1000;
  Queue<DelayObject> _delayQueue = ListQueue<DelayObject>();
  bool _startFlag;

  DelayQueue();

  void start() {
    _start().listen((_) {});
  }

  Stream<void> _start() async* {
    _startFlag = true;
    int startTime = DateTime.now().millisecondsSinceEpoch;
    while (_startFlag) {
      int currentTime = DateTime.now().millisecondsSinceEpoch;
      if (_delayQueue.length > 0 &&
          (currentTime - startTime) >= _delayOfEachProducedMessageMillis) {
        startTime = currentTime;
        var result = _delayQueue.removeFirst();
        result.value.run();
      }
    }
  }

  void add(DelayObject t) {
    _delayQueue.add(t);
  }

  void remove(DelayObject t) {
    _delayQueue.remove(t);
  }

  void stop() {
    _startFlag = false;
    _delayQueue.clear();
  }
}