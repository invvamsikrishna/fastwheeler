import 'package:fastwheeler/components/common_widget.dart';
import 'package:fastwheeler/constants.dart';
import 'package:fastwheeler/utils/maps_counter.dart';
import 'package:fastwheeler/utils/models.dart';
import 'package:fastwheeler/utils/request_assitance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _visible = false, _progress = false;
  List<SearchAddress> _locations = [];

  void findPlaces(String placeName) async {
    if (placeName.length >= 3) {
      setState(() {
        _locations.clear();
        _visible = false;
        _progress = true;
      });
      String url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&components=country:BH&key=$mapKey";
      var response = await RequestAssistance.getRequest(url);
      // print(url);
      if (response != "failed" && response["predictions"].length > 0) {
        List<SearchAddress> _loc = [];
        for (int i = 0; i < response["predictions"].length; i++) {
          String id = response["predictions"][i]["place_id"];
          String name =
              response["predictions"][i]["structured_formatting"]["main_text"];
          String des = response["predictions"][i]["structured_formatting"]
              ["secondary_text"];
          _loc.add(SearchAddress(
            placeId: id,
            placeName: name,
            placeDescription: des,
          ));
        }
        setState(() {
          _locations = _loc;
          _progress = false;
        });
      } else {
        setState(() {
          _progress = false;
        });
      }
    } else {
      setState(() {
        _locations.clear();
        _visible = true;
      });
    }
  }

  void _setLocation(int index) async {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String id = _locations[index].placeId;

    IsLoading(context);
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=$mapKey";
    var response = await RequestAssistance.getRequest(url);
    Navigator.pop(context);
    if (response != "failed" && response["status"] == "OK") {
      Address address = Address();
      address.placeFormattedAddress = response["result"]["formatted_address"];
      address.placeName = response["result"]["name"];
      address.placeId = id;
      address.latitute = response["result"]["geometry"]["location"]["lat"];
      address.longitude = response["result"]["geometry"]["location"]["lng"];

      MapsCounter _counter = context.read<MapsCounter>();

      if (arg["flag"]) {
        _counter.setPickUp(address);
      } else {
        _counter.setDestination(address);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
        title: TextField(
          autofocus: true,
          decoration: InputDecoration.collapsed(hintText: "Search location"),
          onChanged: findPlaces,
        ),
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _progress,
              child: LinearProgressIndicator(
                color: kPrimaryColor,
                backgroundColor: Colors.green[50],
              ),
            ),
            Visibility(
              visible: _visible,
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("Please enter min 3 letters to search"),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              itemCount: _locations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(Icons.location_on_sharp),
                  title: Text(
                    _locations[index].placeName,
                    style: TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    _locations[index].placeDescription,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => _setLocation(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
