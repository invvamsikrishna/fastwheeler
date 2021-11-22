class Address {
  String placeFormattedAddress;
  String placeName;
  String placeId;
  double latitute;
  double longitude;
  Address({
    this.placeFormattedAddress = "",
    this.placeName = "",
    this.placeId = "",
    this.latitute = 0,
    this.longitude = 0,
  });
}

class SearchAddress {
  String placeId;
  String placeName;
  String placeDescription;
  SearchAddress({
    this.placeId = "",
    this.placeName = "",
    this.placeDescription = "",
  });
}

class DirectionDetails {
  int distanceValue;
  int durationValue;
  String distanceText;
  String durationText;
  String encodedPoints;
  double neLat;
  double neLon;
  double swLat;
  double swLon;
  DirectionDetails({
    this.distanceValue = 0,
    this.durationValue = 0,
    this.distanceText = "",
    this.durationText = "",
    this.encodedPoints = "",
    this.neLat = 0,
    this.neLon = 0,
    this.swLat = 0,
    this.swLon = 0,
  });
}
