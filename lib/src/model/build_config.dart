import 'package:fast_i18n/src/model/i18n_config.dart';
import 'package:fast_i18n/src/model/i18n_locale.dart';

/// represents a build.yaml
class BuildConfig {
  static const bool defaultNullSafety = true;
  static const String defaultBaseLocale = 'en';
  static const String defaultInputDirectory = null;
  static const String defaultInputFilePattern = '.i18n.json';
  static const String defaultOutputDirectory = null;
  static const String defaultOutputFilePattern = '.g.dart';
  static const String defaultTranslateVar = 't';
  static const String defaultEnumName = 'AppLocale';
  static const TranslationClassVisibility defaultTranslationClassVisibility =
      TranslationClassVisibility.private;
  static const KeyCase defaultKeyCase = null;
  static const List<String> defaultMaps = <String>[];
  static const List<String> defaultCardinal = <String>[];
  static const List<String> defaultOrdinal = <String>[];

  final bool nullSafety;
  final I18nLocale baseLocale;
  final String inputDirectory;
  final String inputFilePattern;
  final String outputDirectory;
  final String outputFilePattern;
  final String translateVar;
  final String enumName;
  final TranslationClassVisibility translationClassVisibility;
  final KeyCase keyCase;
  final List<String> maps;
  final List<String> pluralCardinal;
  final List<String> pluralOrdinal;

  BuildConfig(
      {this.nullSafety,
      this.baseLocale,
      this.inputDirectory,
      this.inputFilePattern,
      this.outputDirectory,
      this.outputFilePattern,
      this.translateVar,
      this.enumName,
      this.translationClassVisibility,
      this.keyCase,
      this.maps,
      this.pluralCardinal,
      this.pluralOrdinal});
}
