class OriginLocation{
  late String point;
  late List<double> coordinates = [0,0];

  static var values;

  OriginLocation(String _point, List<double> _coordinates){
    point = _point;
    coordinates = [
      double.parse(_coordinates[0].toStringAsFixed(6)),
      double.parse(_coordinates[1].toStringAsFixed(6))
    ];
  }
}