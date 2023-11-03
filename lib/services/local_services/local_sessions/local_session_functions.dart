import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSessionFunctions {
  BuildContext context;

  LocalSessionFunctions({required this.context});

  Future<SharedPreferences> _init() async {
    SharedPreferences sPrefs = await SharedPreferences.getInstance();

    return sPrefs;
  }

  Future<bool> writeKey(String key, String data) async {
    bool result = false;

    await _init().then((sPrefs) async {
      await sPrefs.setString(key, data).then((_) {
        result = true;
      });
    });

    return result;
  }

  Future<bool> writeListKey(String key, List<String> data) async {
    bool result = false;

    await _init().then((sPrefs) async {
      await sPrefs.setStringList(key, data).then((_) {
        result = true;
      });
    });

    return result;
  }

  Future<String?> readKey(String key) async {
    String? result;

    await _init().then((sPrefs) {
      result = sPrefs.getString(key);
    });

    return result;
  }

  Future<List<String>?> readListKey(String key) async {
    List<String>? result;

    await _init().then((sPrefs) {
      result = sPrefs.getStringList(key);
    });

    return result;
  }

  Future<bool> removeKey(String key) async {
    bool result = false;

    await _init().then((sPrefs) async {
      await sPrefs.remove(key).then((_) {
        result = true;
      });
    });

    return result;
  }

  Future<bool> removeAllKey() async {
    bool result = false;

    await _init().then((sPrefs) async {
      await sPrefs.clear().then((_) {
        result = true;
      });
    });

    return result;
  }
}