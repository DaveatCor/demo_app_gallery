
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  SecureStorage._privateConstuctor();

  static final SecureStorage _storage = SecureStorage._privateConstuctor();

  static SecureStorage get secureStorage => _storage;

  Future<void> storeData(String key, String value) async {

    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getData(String key) async {
    return await _secureStorage.read(key: key);
  }

}