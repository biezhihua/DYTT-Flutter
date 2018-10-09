import 'package:DYTT_FLUTTER/delay_queue.dart';
import 'package:test/test.dart';

void main() {
  test('my first unit test', () {
//    var answer = 42;
//    expect(answer, 42);

    DelayQueue<String> dq = DelayQueue();
    dq.start();

    dq.add("test");
    dq.add("test1");
    dq.add("test2");
    dq.add("test3");
    dq.add("test4");


  });
}
