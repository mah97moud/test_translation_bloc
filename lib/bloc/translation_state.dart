part of 'translation_bloc.dart';

class TranslationState extends Equatable {
  final LocaleModel? locale;
  final String langCode;
  final TextDirection textDirection;

  const TranslationState({
    required this.locale,
    required this.langCode,
    required this.textDirection,
  });

  const TranslationState.initial()
      : locale = null,
        langCode = 'en',
        textDirection = TextDirection.ltr;

  //copyWith() is used to create a new instance of the state with only the properties that are different from the current state.
  TranslationState copyWith({
    LocaleModel? locale,
    String? langCode,
    TextDirection? textDirection,
  }) {
    return TranslationState(
      locale: locale ?? this.locale,
      langCode: langCode ?? this.langCode,
      textDirection: textDirection ?? this.textDirection,
    );
  }

  @override
  List<Object?> get props => [locale, langCode, textDirection];
}
