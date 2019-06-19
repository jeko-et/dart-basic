import 'dart:async';
import '../ansicolor.dart';
import '../L6/Avenger.dart';
import '../L6/Gadget.dart';
import '../L6/Spiderman.dart';
import '../L6/CaptainAmerica.dart';
import '../L6/Thanos.dart';
import '../L6/Hulk.dart';
import '../L6/Thor.dart';

const STREAM_CLOSE_TIMEOUT = 3;
const AVENGER_GO_TIMEOUT = 1;
AnsiPen greenText = AnsiPen()..green(bold: true);
AnsiPen redText = AnsiPen()..red(bold: true);
AnsiPen yellowText = AnsiPen()..yellow(bold: true);
void onCloseHandler() {
  print('[StreamController.close()] ---> ⌚  ' +
      greenText("${STREAM_CLOSE_TIMEOUT}s passed. Stream is closed"));
}

bool isReadyGadget(Avenger avenger) {
  return avenger.hasGadget();
}

Future delay(int seconds) {
  return Future.delayed(
      Duration(seconds: seconds), () => print('⌚  ${seconds.toString()}s'));
}

void addAvengers(StreamController streamCtrl, List<dynamic> avengers) async {
  for (final avenger in avengers) {
    try {
      print('${yellowText('>>>')} Pushed ' + avenger.runtimeType.toString());
      if (streamCtrl.isClosed) {
        print('${redText('☒ Stream is closed ☒')}');
        print('${redText('✖')} ${redText(avenger.name)} is late ');
      } else
        streamCtrl.sink.add(avenger);
      await delay(AVENGER_GO_TIMEOUT);
    } catch (e) {
      print(e);
    }
    // break;
  }
}

Future<List<dynamic>> transformAvengers(List<dynamic> avengers) async {
  List<dynamic> transformedAvengers = [];

  StreamController streamCtrl = new StreamController(
    onCancel: onCloseHandler,
  );

  StreamSubscription streamSubscription;
  streamSubscription = streamCtrl.stream.listen((avenger) async {
    switch (avenger.runtimeType.toString()) {
      case "Thor":
        print('⌚  Thor is fetching the Mjolnir hammer...');
        await avenger.findGadget();
        break;
    }
    if (isReadyGadget(avenger)) {
      transformedAvengers.add(avenger);
      print("${greenText('✓')} Accepted: " + avenger.runtimeType.toString());
    } else
      print("${redText('✖')} Rejected: " +
          avenger.runtimeType.toString() +
          " -> without gadget");
  }, onDone: () {
     print("[StreamSubscription.onDone()] ---> " +
        greenText('Transforming Avengers done'));
  }, onError: (error) {
    print("Some Error");
  });

  Future.delayed(const Duration(seconds: STREAM_CLOSE_TIMEOUT), () {
    streamCtrl.close();
  });

  await addAvengers(streamCtrl, avengers);
  return transformedAvengers;
}

// Liệt kê avengers đã qua đường hầm lượng tử
void showAvengers(List<dynamic> transformedAvengers) {
  print('\r\n<====Final Transformed Avenger=====>');
  transformedAvengers.forEach((avenger) {
    print(avenger.runtimeType.toString());
  });
}

List<dynamic> avengers = [
  Thanos(
    name: 'Củ khoai tím',
    sexual: 'Male',
    gadget: Gadget('Găng tay vô cực 6 đá'),
  ),
  Thor(name: 'Thần Sét', sexual: 'Male'),
  CaptainAmerica(
    name: 'Lớp trưởng Mỹ',
    sexual: 'Male',
    gadget: Gadget('Supper Khiên'),
  ),
  Spiderman(
    name: 'Người Nhện',
    sexual: 'Male',
    gadget: Gadget('Tơ Nhện'),
  ),
  Hulk(
    name: 'Khổng Lồ Xanh',
    sexual: 'Male',
    gadget: Gadget('Cú đấm'),
  ),
];
void main() async {
  transformAvengers(avengers).then((value) {
    showAvengers(value);
  });
  
  /////////////// Test OPERATOR ==  //////////////
  Thor thor = Thor(name: 'Thần Sét', sexual: 'Male');
  Thor thorFake = Thor(name: 'Thần Sét Fake', sexual: 'bede');
  thor.showInfo();
  thorFake.showInfo();
  print("Thor can't be fake: ${thor == thorFake}");

  /////////////// Test fetch http ///////////////
  // Thor thor = Thor(name: 'Thần Sét', sexual: 'Male');
  // dynamic a = await thor.fetchMjolnir();
  // print(a["Gadget"]);
}
