import 'dart:async';

Future<String> asyncFunc1() async {
  return "async return1";
}

Future<String> asyncFunc2() async {
  return "async return2";
}

Stream<String> streamFunc() async* {
  yield "stream return";
}

void main() async {
  streamFunc().listen((result) {
    print(result);
  });

  // ①
  asyncFunc1().then((_) => asyncFunc2()).then((result) {
    print(result);
  });

  // ②
  var asyncResult1 = await asyncFunc1();
  var asyncResult2 = await asyncFunc2();
  print(asyncResult2);

  // ③
  var list = await Future.wait([asyncFunc1(), asyncFunc2()]);
  print(list[1]);

  // ④
  asyncFunc1().asStream().asyncMap((_) => asyncFunc2()).listen((result) {
    print(result);
  });

  // ⑤
  var stream = asyncFunc1().asStream().asyncMap((_) => asyncFunc2());
  await for (var result in stream) {
    print(result);
  }

  // ⑥
  asyncFunc1()
      .asStream()
      .asyncExpand((_) => asyncFunc2().asStream())
      .listen((result) {
    print(result);
  });

  // ⑦
  asyncFunc1().asStream().asyncExpand((_) async* {
    yield await asyncFunc2();
  }).listen((result) {
    print(result);
  });
}
