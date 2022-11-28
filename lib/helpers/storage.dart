// ignore_for_file: prefer_const_constructors

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = FlutterSecureStorage();
  Future writeData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future getData(String key) async {
    var data = await storage.read(key: key);
    if (data == null) {
      return 'null';
    }
    return data.toString();
  }
}
