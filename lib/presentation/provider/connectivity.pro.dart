import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_app_gallery/application/services/connection.s.dart';
import 'package:demo_app_gallery/application/services/store_data.s.dart';
import 'package:demo_app_gallery/domain/contant/storage_key.const.dart';
import 'package:demo_app_gallery/index.dart';

class ConnectivityProvider with ChangeNotifier {
  
  bool isInit = false;

  ConnectivityResult? connectivityResult;

  String content = '';

  void initState() async {

    await InternetChecker.initConnection();
    
    connectivityResult = InternetChecker.connectivityResult;

    await SecureStorage.secureStorage.storeData(StorageConstant.connectivityResult, json.encode(connectivityResult!.index));

    connectionListener();

  }

  void connectionListener() async {

    InternetChecker.connectInstance.onConnectivityChanged.listen((event) {

      connectivityResult = event;

      if (connectivityResult == ConnectivityResult.mobile) {
        content = "Mobile connection";
        // I am connected to a mobile network.
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        content = "Wifi connection";
      }
      // //  else if (connectivityResult == ConnectivityResult.ethernet) {
      // //   // I am connected to a ethernet network.
      // // }
      // //  else if (connectivityResult == ConnectivityResult.vpn) {
      // //   // I am connected to a vpn network.
      // //   // Note for iOS and macOS:
      // //   // There is no separate network interface type for [vpn].
      // //   // It returns [other] on any device (also simulator)
      // // } else if (connectivityResult == ConnectivityResult.bluetooth) {
      // //   // I am connected to a bluetooth.
      // // } else if (connectivityResult == ConnectivityResult.other) {
      // //   // I am connected to a network which is not in the above mentioned networks.
      // // } 
      else if (connectivityResult == ConnectivityResult.none) {
        // I am not connected to any network.
        content = "No connection";
        
      }

      notifyListeners();
    });
  }


      
      // ScaffoldMessenger.of(_context!).showSnackBar(
      //   SnackBar(content: Text(content))
      // );
  
}
