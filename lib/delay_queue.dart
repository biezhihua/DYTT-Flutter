import 'dart:async';
import 'dart:collection';

typedef void Runnable();

class DelayObject {
  final String key;
  final Runnable value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DelayObject && key == other.key;

  @override
  int get hashCode => key.hashCode;

  DelayObject(this.key, [this.value]);
}

class DelayQueue {
  static final DelayQueue _singleton = new DelayQueue._internal();

  factory DelayQueue() {
    return _singleton;
  }

  DelayQueue._internal();

  Queue<DelayObject> _delayQueue = ListQueue<DelayObject>();

  Timer _timer;

  void start() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (_delayQueue.length > 0) {
        var result = _delayQueue.removeFirst();
        result.value();
      }
    });
  }

  void add(DelayObject t) {
    _delayQueue.add(t);
  }

  void remove(DelayObject t) {
    print("remove before ${_delayQueue.length} ${t.key}");
    var result = _delayQueue.remove(t);
    print("remove after ${_delayQueue.length} $result");
  }

  void clear() {
    _delayQueue.clear();
  }

  void stop() {
    _timer.cancel();
    _delayQueue.clear();
  }
}
