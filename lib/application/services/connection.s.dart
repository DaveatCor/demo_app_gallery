import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {

  static ConnectivityResult? connectivityResult;

  static final Connectivity _connectivity = Connectivity();

  InternetChecker._privateConstructor();

  // static final InternetChecker _instance = InternetChecker._privateConstructor();

  static get connectionResult => connectivityResult;

  static Connectivity get connectInstance => _connectivity;

  /// 1
  static Future<void> initConnection() async {
    
    print("initConnection");
    connectivityResult = await (_connectivity.checkConnectivity());

    print("connectivityResult ${connectivityResult!.index}");

    // connectionListener();
  }

  /// 2
  // static Future<Stream<ConnectivityResult>> connectionListener() async {

  //   print("connectionListener");

  //   return _connectivity.onConnectivityChanged;
  //   // .listen((event) {

  //   //   print(event.index);
    
  //   //   if (connectivityResult == ConnectivityResult.mobile) {
  //   //     // I am connected to a mobile network.
  //   //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //   //     // I am connected to a wifi network.
  //   //   }
  //   //   //  else if (connectivityResult == ConnectivityResult.ethernet) {
  //   //   //   // I am connected to a ethernet network.
  //   //   // }
  //   //   //  else if (connectivityResult == ConnectivityResult.vpn) {
  //   //   //   // I am connected to a vpn network.
  //   //   //   // Note for iOS and macOS:
  //   //   //   // There is no separate network interface type for [vpn].
  //   //   //   // It returns [other] on any device (also simulator)
  //   //   // } else if (connectivityResult == ConnectivityResult.bluetooth) {
  //   //   //   // I am connected to a bluetooth.
  //   //   // } else if (connectivityResult == ConnectivityResult.other) {
  //   //   //   // I am connected to a network which is not in the above mentioned networks.
  //   //   // } 
  //   //   else if (connectivityResult == ConnectivityResult.none) {
  //   //     // I am not connected to any network.
  //   //   }
      
  //   // });
  // }
  
}