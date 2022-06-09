part of 'translation_bloc.dart';

abstract class TranslationEvent extends Equatable {
  const TranslationEvent();
}

class LoadLangJsonEvent extends TranslationEvent {
  final String langJson;

  const LoadLangJsonEvent(this.langJson);

  @override
  List<Object> get props => [langJson];
}

class LoadTranslationFileEv extends TranslationEvent {
  final String fileName;

  const LoadTranslationFileEv(this.fileName);

  @override
  List<Object> get props => [fileName];
}

class ChangeLanguageEv extends TranslationEvent {
  const ChangeLanguageEv();

  @override
  List<Object> get props => [];
}

class ChangeDirectionEv extends TranslationEvent {
  final String locale;
  const ChangeDirectionEv({required this.locale});

  @override
  List<Object> get props => [locale];
}
