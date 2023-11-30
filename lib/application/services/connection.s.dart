import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {

  static ConnectivityResult? connectivityResult;

  static final Connectivity _connectivity = Connectivity();

  InternetChecker._privateConstructor();

  static get connectionResult => connectivityResult;

  static Connectivity get connectInstance => _connectivity;

  /// 1
  static Future<void> initConnection() async {
    
    connectivityResult = await (_connectivity.checkConnectivity());
  }
  
}