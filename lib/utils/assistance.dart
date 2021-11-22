import 'package:fastwheeler/utils/models.dart';
import 'package:fastwheeler/utils/request_assitance.dart';
import 'package:geolocator/geolocator.dart';
import '../constants.dart';


class AssistantMethods {
  static Future<Address> searchCoordinateAddress(Position position) async {
    Address address = Address();
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await RequestAssistance.getRequest(url);
    // print(url);
    if (response != "failed" && response["results"].length > 0) {
      // print(response["results"].length);
      // print(response["results"][0]["formatted_address"]);
      address.placeId = response["results"][0]["place_id"];
      address.placeFormattedAddress =
          response["results"][0]["formatted_address"];
      address.latitute = position.latitude;
      address.longitude = position.longitude;
    }
    return address;
  }
}
