import 'origin_location.dart';

class Origin{ 
  late int id;
  late String name;
  late OriginLocation location;

  Origin(int _id, String _name, OriginLocation _location){
    id = _id;
    name = _name;
    location = _location;
  }

  static getOrigin(int origin) {}
}