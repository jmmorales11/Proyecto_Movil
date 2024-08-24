import 'dart:convert';
import 'package:http/http.dart' as http;

class MapboxService {
  final String _accessToken = 'sk.eyJ1IjoiZXByYW1pcmV6MiIsImEiOiJjbTA1dm9uemYwbXlqMmpwd2NpenY1eWt2In0.ZHQ14IrAeojcL6PjrBfFnw';

  Future<Map<String, dynamic>> getPlaceDetails(String placeName) async {
    final searchUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$placeName.json?access_token=$_accessToken';

    final response = await http.get(Uri.parse(searchUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final place = data['features'].isNotEmpty ? data['features'][0] : {};

      return {
        'name': place['text'] ?? 'No name available',
        'place_name': place['place_name'] ?? 'No place name available',
        'coordinates': place['geometry']['coordinates'] ?? [],
        'address': place['properties']?['address'] ?? 'No address available'
      };
    } else {
      throw Exception('Failed to load place details');
    }
  }
}
