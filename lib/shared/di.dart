import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_translation_bloc/bloc/translation_bloc.dart';
import 'package:test_translation_bloc/shared/cache_helper.dart';

GetIt di = GetIt.I..allowReassignment = true;

Future init() async {
  final sp = await SharedPreferences.getInstance();

  di.registerLazySingleton<SharedPreferences>(() => sp);

  di.registerLazySingleton<CacheHelper>(
    () => CacheImpl(di<SharedPreferences>()),
  );

  appCode ??= await getLangCode;

  if (appCode == null) {
    saveAppDirection(direction: 'ltr');
    appDir ??= await getAppDirection;
    appCode = 'en';
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<bool?> saveAppDirection({required String? direction}) async {
  return await di<CacheHelper>().put('direction', direction);
}

Future<String?> get getAppDirection async {
  return await di<CacheHelper>().getString('direction');
}

Future<bool?> saveLangCode({required String? code}) async {
  return await di<CacheHelper>().put('code', code);
}

Future<String?> get getLangCode async {
  return await di<CacheHelper>().getString('code');
}
