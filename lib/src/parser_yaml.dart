import 'dart:io';

import 'package:fast_i18n/src/model/build_config.dart';
import 'package:fast_i18n/src/model/i18n_config.dart';
import 'package:fast_i18n/src/model/i18n_locale.dart';
import 'package:fast_i18n/src/model/yaml_parse_result.dart';
import "package:yaml/yaml.dart";

/// parses the yaml string according to build.yaml
YamlParseResult parseBuildYaml(String yamlContent) {
  YamlMap configEntry;
  bool parsed = true;
  if (yamlContent != null) {
    final map = loadYaml(yamlContent);
    configEntry = _findConfigEntry(map);
  }

  if (configEntry == null) {
    parsed = false;
    configEntry = YamlMap();
  }

  final bool nullSafety =
      configEntry['null_safety'] ?? BuildConfig.defaultNullSafety;
  final baseLocale = I18nLocale.fromString(
      configEntry['base_locale'] ?? BuildConfig.defaultBaseLocale);
  final inputDirectory = ((configEntry['input_directory'] as String) ??
          BuildConfig.defaultInputDirectory)
      ?.normalizePath();
  final inputFilePattern =
      configEntry['input_file_pattern'] ?? BuildConfig.defaultInputFilePattern;
  final outputDirectory = ((configEntry['output_directory'] as String) ??
          BuildConfig.defaultOutputDirectory)
      ?.normalizePath();
  final outputFilePattern = configEntry['output_file_pattern'] ??
      BuildConfig.defaultOutputFilePattern;
  final translateVar =
      configEntry['translate_var'] ?? BuildConfig.defaultTranslateVar;
  final enumName = configEntry['enum_name'] ?? BuildConfig.defaultEnumName;
  final translationClassVisibility =
      (configEntry['translation_class_visibility'] as String)
              ?.toTranslationClassVisibility() ??
          BuildConfig.defaultTranslationClassVisibility;
  final keyCase = (configEntry['key_case'] as String)?.toKeyCase() ??
      BuildConfig.defaultKeyCase;
  final stringInterpolation = (configEntry['string_interpolation'] as String)
          ?.toStringInterpolation() ??
      BuildConfig.defaultStringInterpolation;
  final maps = configEntry['maps']?.cast<String>() ?? BuildConfig.defaultMaps;
  final pluralCardinal =
      (configEntry['pluralization'] ?? {})['cardinal']?.cast<String>() ??
          BuildConfig.defaultCardinal;
  final pluralOrdinal =
      (configEntry['pluralization'] ?? {})['ordinal']?.cast<String>() ??
          BuildConfig.defaultOrdinal;

  final buildConfig = BuildConfig(
      nullSafety: nullSafety,
      baseLocale: baseLocale,
      inputDirectory: inputDirectory,
      inputFilePattern: inputFilePattern,
      outputDirectory: outputDirectory,
      outputFilePattern: outputFilePattern,
      translateVar: translateVar,
      enumName: enumName,
      translationClassVisibility: translationClassVisibility,
      keyCase: keyCase,
      stringInterpolation: stringInterpolation,
      maps: maps,
      pluralCardinal: pluralCardinal,
      pluralOrdinal: pluralOrdinal);

  return YamlParseResult(parsed: parsed, config: buildConfig);
}

YamlMap _findConfigEntry(YamlMap parent) {
  for (final entry in parent.entries) {
    if (entry.key == 'fast_i18n:i18nBuilder' && entry.value is YamlMap) {
      final options = entry.value['options'];
      if (options != null) return options; // found
    }

    if (entry.value is YamlMap) {
      final result = _findConfigEntry(entry.value);
      if (result != null) {
        return result; // found
      }
    }
  }
}

extension on String {
  String normalizePath() {
    String result = this
        .replaceAll('/', Platform.pathSeparator)
        .replaceAll('\\', Platform.pathSeparator);

    if (result.startsWith(Platform.pathSeparator))
      result = result.substring(Platform.pathSeparator.length);

    if (result.endsWith(Platform.pathSeparator))
      result =
          result.substring(0, result.length - Platform.pathSeparator.length);

    return Directory.current.path + Platform.pathSeparator + result;
  }
}
