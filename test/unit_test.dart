import 'dart:async';
import 'dart:io';

import 'package:DYTT_FLUTTER/delay_queue.dart';

Stream<int> endlessCountUp() async* {
  var i = 0;
  while (true) {
    sleep(new Duration(seconds: 1));
    yield i++;
  }
}

void main() {
  DelayQueue dq = DelayQueue();
  dq.add(DelayObject("test1", () {
    print("test1");
  }));
  dq.add(DelayObject("test2", () {
    print("test2");
  }));
  dq.add(DelayObject("test3", () {
    print("test3");
  }));
  dq.add(DelayObject("test4", () {
    print("test4");
  }));
  dq.add(DelayObject("test5", () {
    print("test5");
  }));
  dq.start();
  dq.remove(DelayObject("test5"));
  print("start");

  dq.stop();
  print("stop");
}
