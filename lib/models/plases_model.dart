import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesModel {
  final int id;
  final String name;
  final LatLng latLng;

  const PlacesModel({
    required this.id,
    required this.name,
    required this.latLng,
  });
}

List<PlacesModel> places = [
  const PlacesModel(
    id: 0,
    name: 'فيلا وهدان',
    latLng: LatLng(30.53104023290044, 31.045708508527312),
  ),
  const PlacesModel(
    id: 1,
    name: 'مخذن كرتون',
    latLng: LatLng(30.52598971662556, 31.046379060790965),
  ),
  const PlacesModel(
    id: 2,
    name: 'المدرسه القديمه ',
    latLng: LatLng(30.524709717929795, 31.046545357746442),
  ),
  const PlacesModel(
    id: 3,
    name: 'عاصم كافيه',
    latLng: LatLng(30.524085885748633, 31.046400518460253),
  ),
  const PlacesModel(
    id: 4,
    name: 'بيتي',
    latLng: LatLng(30.52802347051582, 31.0457970214283),
  ),
  const PlacesModel(
    id: 5,
    name: 'الشركه اللي مقدم فيها',
    latLng: LatLng(30.420854726535744, 31.03646947583555),
  ),
];
