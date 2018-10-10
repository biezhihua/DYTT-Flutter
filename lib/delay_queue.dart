import 'dart:async';
import 'dart:collection';

typedef void Runnable();

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

  DelayObject(this.key, [this.value]);
}

class DelayQueue {
  static final DelayQueue _singleton = new DelayQueue._internal();

  factory DelayQueue() {
    return _singleton;
  }

  DelayQueue._internal();

  int _delayOfEachProducedMessageMillis = 1000;
  Queue<DelayObject> _delayQueue = ListQueue<DelayObject>();
  bool _startFlag;

  StreamSubscription _listen;

  void start() {
    _start().listen((delayObject) {
      delayObject.value();
    });
  }

  Stream<DelayObject> _start() async* {
    _startFlag = true;
    int startTime = DateTime.now().millisecondsSinceEpoch;
    while (_startFlag) {
      int currentTime = DateTime.now().millisecondsSinceEpoch;
      if (_delayQueue.length > 0 &&
          (currentTime - startTime) >= _delayOfEachProducedMessageMillis) {
        startTime = currentTime;
        var result = _delayQueue.removeFirst();
        yield result;
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
    if (_listen != null) {
      _listen.cancel();
      _listen = null;
    }
  }
}
