import 'dart:async';
import 'dart:collection';

class DelayQueue<T> {
  int _delayOfEachProducedMessageMillis = 1000;
  Queue<T> _delayQueue = ListQueue<T>();
  bool _startFlag;

  DelayQueue() {}

  void start() {
    _start().then((_) {});
  }

  Future<void> _start() async {
    _startFlag = true;
    int startTime = DateTime.now().millisecondsSinceEpoch;
    while (_startFlag) {
      int currentTime = DateTime.now().millisecondsSinceEpoch;
      if (_delayQueue.length > 0 &&
          (currentTime - startTime) >= _delayOfEachProducedMessageMillis) {
        startTime = currentTime;
        var result = _delayQueue.removeFirst();
        print(result);
      }
    }
  }

  void add(T t) {
    _delayQueue.add(t);
  }

  void remove(T t) {
    _delayQueue.remove(t);
  }

  void stop() {
    _startFlag = false;
    _delayQueue.clear();
  }
}
