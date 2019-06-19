import 'Gadget.dart';
abstract class Avenger {
  String _name;
  String _sexual;
  Gadget _gadget;
  Avenger({String name = "Avenger", String sexual = "Unkown", Gadget gadget = null}) {
    this._name = name;
    this._sexual = sexual;
    this._gadget = gadget;
  }
  void showInfo() {
    print('========= Basic info ==========');
    print('Name: $_name');
    print('Sexual: $_sexual');
    if(_gadget != null){      
      print('Bảo bối: ${_gadget.getName()}');
    }
  }
  String get name => _name;
  void set name(String name) => _name = name;

  String get sexual => _sexual;
  void set sexual(String sexual) => _sexual = sexual;

  Gadget get gadget => _gadget;
  void set gadget(gadget) => _gadget = gadget;

  bool hasGadget() => _gadget != null;

  void doSkill();

  bool operator ==(avenger){
    return _name == avenger.name && _sexual == avenger.sexual;
  }
}
