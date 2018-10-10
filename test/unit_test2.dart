import 'dart:async';
import 'dart:io';
import 'dart:math';

Future<String> asyncFunc1() async {
  return "async return1";
}

Future<String> asyncFunc2() async {
  return "async return2";
}

Stream<String> streamFunc() async* {
  yield "stream return";
}

Stream<int> endlessCountDown() async* {
  var i = pow(2, 30) - 1;
  while (true) {
    sleep(new Duration(seconds: 1));
    yield i--;
  }
}

Stream<int> endlessCountUp() async* {
  var i = 0;
  while (true) {
    sleep(new Duration(seconds: 1));
    yield i++;
  }
}

void main() async {
  endlessCountUp().listen((tick) {
    print("coutUp $tick");
  });

  await for (var tick in endlessCountDown()) {
    print("coutDown $tick");
  }

//  streamFunc().listen((result) {
//    print(result);
//  });
//
//  // ①
//  asyncFunc1().then((_) => asyncFunc2()).then((result) {
//    print(result);
//  });
//
//  // ②
//  var asyncResult1 = await asyncFunc1();
//  var asyncResult2 = await asyncFunc2();
//  print(asyncResult2);
//
//  // ③
//  var list = await Future.wait([asyncFunc1(), asyncFunc2()]);
//  print(list[1]);
//
//  // ④
//  asyncFunc1().asStream().asyncMap((_) => asyncFunc2()).listen((result) {
//    print(result);
//  });
//
//  // ⑤
//  var stream = asyncFunc1().asStream().asyncMap((_) => asyncFunc2());
//  await for (var result in stream) {
//    print(result);
//  }
//
//  // ⑥
//  asyncFunc1()
//      .asStream()
//      .asyncExpand((_) => asyncFunc2().asStream())
//      .listen((result) {
//    print(result);
//  });
//
//  // ⑦
//  asyncFunc1().asStream().asyncExpand((_) async* {
//    yield await asyncFunc2();
//  }).listen((result) {
//    print(result);
//  });
}
