import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  static Future<bool> get isConnected async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
