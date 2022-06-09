import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheHelper {
  Future<dynamic> getString(String key);
  Future<bool?> has(String key);
  Future<bool?> put(String key, dynamic value);
  Future<bool?> clear(String key);
}

class CacheImpl extends CacheHelper {
  final SharedPreferences sharedPreferences;

  CacheImpl(this.sharedPreferences);

  @override
  Future<dynamic> getString(String key) async {
    final f = await _basicErrorHandling(() async {
      if (await has(key) != null) {
        return await jsonDecode(sharedPreferences.getString(key) as String);
      }
      return null;
    });
    return f;
  }

  @override
  Future<bool?> has(String key) async {
    final bool? f = await _basicErrorHandling(() async {
      return sharedPreferences.containsKey(key) &&
          sharedPreferences.getString(key)!.isNotEmpty;
    });
    return f;
  }

  @override
  Future<bool?> put(String key, dynamic value) async {
    final bool? f = await _basicErrorHandling(() async {
      return await sharedPreferences.setString(key, jsonEncode(value ?? ''));
    });

    return f;
  }

  @override
  Future<bool?> clear(String key) async {
    final bool? f = await _basicErrorHandling(() async {
      return await sharedPreferences.remove(key);
    });
    return f;
  }
}

extension on CacheHelper {
  Future<T?> _basicErrorHandling<T>(Future<T> Function() onSuccess) async {
    try {
      final f = await onSuccess();
      return f;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
