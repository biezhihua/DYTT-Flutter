import 'dart:async';

import 'package:DYTT_FLUTTER/delay_queue.dart';

class Test implements Runnable {
  @override
  void run() {
    print("fdfdf");
  }

}

void main() {
  DelayQueue dq = DelayQueue();
  dq.add(DelayObject("test1", new Test()));
  dq.start();
  dq.add(DelayObject("test2", new Test()));
  dq.add(DelayObject("test3", new Test()));
  dq.add(DelayObject("test4", new Test()));
  dq.add(DelayObject("test5", new Test()));


}

