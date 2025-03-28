import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionCheker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionCheker {
  InternetConnection internetConnection;
  ConnectionCheckerImpl({required this.internetConnection});
  @override
  Future<bool> get isConnected async {
    return await internetConnection.hasInternetAccess;
  }
}
