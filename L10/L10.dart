import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'dart:math';

abstract class Avenger {
  String name;
  String sexual;

   Avenger.named({String name, String sexual}) {
    this.name = name;
    this.sexual = sexual;
  }

   factory Avenger({String type, String name, String sexual}) {
    switch (type) {
      case 'Avengers.Thor':
        return new Thor(name: name, sexual: sexual);
      case 'Avengers.Thanos':
        return new Thanos(name: name, sexual: sexual);
      case 'Avengers.CaptainAmerica':
        return new CaptainAmerica(name: name, sexual: sexual);
      default:
        return null;
    }
  }

   void showInfo() {
    print('========= Show info ==========');
    print('Name: $name');
    print('Sexual: $sexual');
  }
}

 
class CaptainAmerica extends Avenger implements Thor {
  CaptainAmerica({String name, String sexual})
      : super.named(name: name, sexual: sexual);
  @override
  void fetchMjolnir() async {
    try {
      final response =
          await http.get('https://blogspotscraping.herokuapp.com/mjolnir.json');
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        print('Fetched hammer');
        return JSON.jsonDecode((response.body));
      } else {
        // If that response was not OK, throw an error.
        print('Failed to load post');
      }
    } catch (e) {
      print(e);
    }
  }
}
class Thor extends Avenger {
  Thor({String name, String sexual}) : super.named(name: name, sexual: sexual);
  void fetchMjolnir(){}
}
class Thanos extends Avenger {
  Thanos({String name, String sexual}) : super.named(name: name, sexual: sexual);
  void fetchMjolnir(){}
}
void main() {
  Thor thorFactoryMade = Avenger(
    type: 'Avengers.Thor',
    name: 'Thor Factorymade',
    sexual: 'Male',
  );
  Thor thorHomeMade = Thor(
    name: 'Thor Homemade',
    sexual: 'Male',
  );
  thorFactoryMade.showInfo();
  thorHomeMade.showInfo();
  CaptainAmerica ca = Avenger(
    type: 'Avengers.CaptainAmerica',
    name: 'Avengers.CaptainAmerica',
    sexual: 'Male',
  );
  ca.showInfo();
  ca.fetchMjolnir();
}