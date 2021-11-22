import 'package:fastwheeler/utils/models.dart';
import 'package:flutter/material.dart';

class MapsCounter with ChangeNotifier {
  Address _pickup = Address();
  Address _destination = Address();
  String _vehicle = "";
  double _distance = 0;
  int _totalAmount = 0;
  int _driverAmount = 0;
  int _helperAmount = 0;
  int _gstAmount = 0;
  bool _helper = false;
  String _waitingtime = "";
  int _drihelperAmount = 0;
  bool _drihelper = false;

  Address get pickup => _pickup;
  Address get destination => _destination;
  String get vehicle => _vehicle;
  double get distance => _distance;
  int get amount => _totalAmount;
  int get driveramt => _driverAmount;
  int get helperamt => _helperAmount;
  int get gstamt => _gstAmount;
  bool get helper => _helper;
  String get waitingtime => _waitingtime;
  int get drihelperamt => _drihelperAmount;
  bool get drihelper => _drihelper;

  void setData(String vehicle) {
    _vehicle = vehicle;
  }

  void setPickUp(Address text) {
    _pickup = text;
    notifyListeners();
  }

  void setDestination(Address text) {
    _destination = text;
    notifyListeners();
  }

  void setDistance(double data) {
    _distance = data;
    notifyListeners();
  }

  void clearValues() {
    _pickup = Address();
    _destination = Address();
    _vehicle = "";
    _distance = 0;
    _totalAmount = 0;
    _driverAmount = 0;
    _helperAmount = 0;
    _gstAmount = 0;
    _helper = false;
    _waitingtime = "";
  }
}
