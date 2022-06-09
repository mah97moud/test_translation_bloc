import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_translation_bloc/shared/di.dart';
import 'package:test_translation_bloc/shared/locale/locale.dart';

part 'translation_event.dart';
part 'translation_state.dart';

Future<String> getLocaleFile({required lanCode}) async {
  return await rootBundle.loadString('assets/locale/${lanCode ?? 'en'}.json');
}

String? appCode;
String? appDir;

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  TranslationBloc() : super(const TranslationState.initial()) {
    on<LoadLangJsonEvent>(_onLoadLangJsonEvent);
    on<LoadTranslationFileEv>(_onLoadTranslationFileEv);
    on<ChangeLanguageEv>(_onChangeLanguageEv);
    on<ChangeDirectionEv>(_onChangeDirectionEv);
  }

  FutureOr<void> _onLoadLangJsonEvent(
    LoadLangJsonEvent event,
    Emitter<TranslationState> emit,
  ) {
    final LocaleModel? localeModel = LocaleModel.fromJson(event.langJson);
    emit(state.copyWith(locale: localeModel, langCode: appCode));
  }

  Future<FutureOr<void>> _onLoadTranslationFileEv(
    LoadTranslationFileEv event,
    Emitter<TranslationState> emit,
  ) async {
    String localeFile = await getLocaleFile(lanCode: state.langCode);
    saveLangCode(code: state.langCode);
    appCode = await getLangCode;

    add(LoadLangJsonEvent(localeFile));
  }

  FutureOr<void> _onChangeLanguageEv(
    ChangeLanguageEv event,
    Emitter<TranslationState> emit,
  ) {
    add(LoadTranslationFileEv(state.langCode == 'en' ? 'ar' : 'en'));
    emit(state.copyWith(langCode: state.langCode == 'en' ? 'ar' : 'en'));
    add(ChangeDirectionEv(locale: state.langCode));
    log(state.langCode);
  }

  FutureOr<void> _onChangeDirectionEv(
    ChangeDirectionEv event,
    Emitter<TranslationState> emit,
  ) async {
    emit(
      state.copyWith(
        textDirection:
            event.locale == 'en' ? TextDirection.ltr : TextDirection.rtl,
      ),
    );
  }
}
