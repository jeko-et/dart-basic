import 'Thanos.dart';
import 'Avenger.dart';
import 'CaptainAmerica.dart';
import 'Thor.dart';

const List<String> urlAvengers = [
  'https://blogspotscraping.herokuapp.com/avengers/Thor.json',
  'https://blogspotscraping.herokuapp.com/avengers/Thanos.json',
  'https://blogspotscraping.herokuapp.com/avengers/CaptainAmerica.json',
];

void createAvengers() async {
  var thor = await Avengers.fetchAvenger(
      'https://blogspotscraping.herokuapp.com/avengers/Thor.json');
  var thnos = await Avengers.fetchAvenger(
      'https://blogspotscraping.herokuapp.com/avengers/Thanos.json');
  var captain = await Avengers.fetchAvenger(
      'https://blogspotscraping.herokuapp.com/avengers/CaptainAmerica.json');
  Thor thorHomeMade =
      Avenger(type: Avengers.Thor, name: "Thor Handmade", sexual: "Male");
  thorHomeMade.showInfo(thor);
  Thanos thanos =
      Avenger(type: Avengers.Thanos, name: "Thanos Fake", sexual: "Male");
  thanos.showInfo(thnos);
  CaptainAmerica ca = Avenger(
      type: Avengers.CaptainAmerica,
      name: "CaptainAmerica Handmade",
      sexual: "Female");
  ca.showInfo(captain);
}

void main() async {
  print(
      '============ L11.2 - Call Default Factory Constructor Orderly ============');
  await createAvengers();
  print('============ L11.1 - Named factory constructor ============');
  var captainAmerica = await Avengers.fetchAvenger(
      'https://blogspotscraping.herokuapp.com/avengers/CaptainAmerica.json');
  CaptainAmerica captaint = Avenger.fromURL(
      'https://blogspotscraping.herokuapp.com/avengers/CaptainAmerica.json');
  captaint.showInfo(captainAmerica);
}
