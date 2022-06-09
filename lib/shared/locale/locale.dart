import 'dart:convert';

class LocaleModel {
  final String lang;
  final String flutterDemoHomePage;
  final String world;

  LocaleModel({
    required this.lang,
    required this.flutterDemoHomePage,
    required this.world,
  });

  factory LocaleModel.fromJson(localeFile) {
    Map<String, dynamic> json = jsonDecode(localeFile);

    return LocaleModel(
      lang: json['lang'],
      flutterDemoHomePage: json['flutterDemoHomePage'],
      world: json['world'],
    );
  }
}
