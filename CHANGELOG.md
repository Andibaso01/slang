## 5.12.5

In parallel with a new federated package structure, we have rebranded this library to [slang](https://pub.dev/packages/slang).

It is recommended to migrate to [slang](https://pub.dev/packages/slang) as new features are only implemented there.

fast_i18n will only receive bug fixes.

You can read the migration guide [here](https://github.com/Tienisto/slang/blob/master/slang/MIGRATION.md).

- docs: add slang notice

## 5.12.4

- fix: Flutter 3.0.0 compatibility

## 5.12.3

- fix: resolve some linting errors in generated file

## 5.12.2

- fix: handle csv files with 1st level lists

Add plural support: Swedish (thanks to [Johannes Löhnn](https://github.com/lohnn))

## 5.12.1

- fix: handle empty lists in combination with interfaces
- fix: migrate ARB files with plurals/selects correctly

## 5.12.0

- feat: add comments feature for json and csv files
- feat: new command `flutter pub run fast_i18n:migrate arb en.arb en.json` to migrate ARB files

## 5.11.0

- feat: new command `flutter pub run fast_i18n stats` to get number of words, characters, etc.
- fix: create missing directories instead of throwing an error

## 5.10.0

- feat: add option `locale_handling: false` to not generate `t` and `LocaleSettings` (suitable for dependency injection)

## 5.9.0

**Dependency Injection (optional)**

Plural resolvers are now part of the translation class.

Meaning, you can now build your own instance without relying on `LocaleSettings` or any other side effects.

This is entirely optional! You can still use the included `LocaleSettings` solution.

```dart
// riverpod example
final english = AppLocale.en.build(cardinalResolver: myEnResolver);
final german = AppLocale.de.build(cardinalResolver: myDeResolver);
final translationProvider = StateProvider<StringsEn>((ref) => german);

// access the current instance
final t = ref.watch(translationProvider);
String a = t.welcome.title;
```

For more information, checkout the [full article](https://github.com/Tienisto/flutter-fast-i18n/blob/master/documentation/dependency_injection.md).

## 5.8.0

- feat: allow custom parameter names in plurals or contexts (`count` and `context` were hardcoded previously)
- feat: add path comment to every generated class

## 5.7.0

- feat: add option `timestamp` to disable timestamp generation
- feat: add option `output_format` to split output file
- perf: flat translation map now declared separately for each locale

## 5.6.0

- feat: add CSV support
- feat: improve generic type detection for lists (e.g. `List<List<String>>`,`List<Map<String, String>>`)
- feat: make optional class members (from interfaces) non-nullable when possible

## 5.5.0

**Namespaces**

Split your translations into different files. Each file represents a namespace:

```text
i18n/
  widgets/
    - widgets.i18n.json
    - widgets_fr.i18n.json
  dialogs/
    - dialogs.i18n.json
    - dialogs_fr.i18n.json
```

**Interfaces**

Create common super classes for different nodes. This allows for more type safety. Instead of `List<dynamic>`, we can have `List<PageData>`

```json
{
  "pages": [
    {
      "title": "E2E encryption",
      "content": "Your data is safe!"
    },
    {
      "title": "Sync",
      "content": "Synchronize all your devices!"
    }
  ]
}
```

With the generated mixin:

```dart
mixin PageData {
  String get title;
  String get content;
}
```

See updated README for further information about those features.

## 5.4.0

- feat: add default plural resolvers for Spanish, French and Italian (Thanks to @SimoneBressan)

## 5.3.0

- feat: handle linked translations with parameters

## 5.2.0

- feat: add YAML support, you can now choose between JSON and YAML to define your translations!
- feat: different casing for map keys via `key_map_case`

New recommended setup (see README):

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: MyApp())); // Wrap your app with TranslationProvider
}
```

```dart
MaterialApp(
  locale: TranslationProvider.of(context).flutterLocale, // use provider
  supportedLocales: LocaleSettings.supportedLocales,
  localizationsDelegates: GlobalMaterialLocalizations.delegates,
)
```

## 5.1.0

- feat: add `param_case` configuration to recase parameters

## 5.0.4

- fix: always escape `$` for `braces` and `double_braces`, escape `$` for `dart` if this symbol is alone

## 5.0.3

- fix: For country code only, `india` instead of `in` will be used for enum constant (`in` is a reserved keyword)
- fix: When using country code only, the correct device locale will be selected

## 5.0.2

- fix: transform keys with multiple digits according to `key_case` correctly

## 5.0.1

- fix: Missing `PluralResolver` when pluralization is not used in project

## 5.0.0

**This release mostly focuses on simplifications of** `build.yaml`.
- **Breaking:** builder name renamed from `fast_i18n:i18nBuilder` to `fast_i18n`
- **Breaking:** plural auto detection is on by default (`auto: cardinal`)
- **Breaking:** fallback strategy option `strict` is now `none`
- **Breaking:** key paths in `build.yaml` must be cased according to `key_case` if specified
- **Breaking:** your project must be null safe
- feat: generated file follows lint guidelines
- feat: add support for linked translations, e.g. `Welcome to @:appName`

You can read the detailed migration guide [here](https://github.com/Tienisto/slang/blob/master/slang/MIGRATION.md).

## 4.11.0

- feat: simplify `${arg}` to `$arg` if possible
- feat: make internal translation class instance final

## 4.10.0

Added support for custom contexts.
Example:
```json
{
  "greet": {
    "male": "Hello Mr $name",
    "female": "Hello Ms $name"
  }
}
```
```dart
String a = t.greet(name: 'Anna', context: GenderContext.female);
```
For more information, see README.

## 4.9.2

- fix: call setLocale without WidgetsBinding
- docs: update README

## 4.9.1

- fix: generate default plural resolvers when auto pluralization is used

## 4.9.0

- feat: detect pluralization automatically, configure it via `pluralization->auto: cardinal / ordinal`

## 4.8.0

- feat: add option to turn off flat map generation via `flat_map: false`
- feat: add `fallback_strategy` configuration, possible values `strict` (default), `base_locale`
- feat: auto rebuild `flutter pub run fast_i18n watch` (experimental)
- fix: escape parameters with backslash correctly

## 4.7.2

- fix: handle string interpolation at the beginning (for `braces` and `double_braces`)

## 4.7.1

- fix: `build_runner` generation error

## 4.7.0

- feat: new `string_interpolation` configuration. Possible values: `dart` (default), `braces` and `double_braces`

## 4.6.3

- fix: restore non-nullsafety compatibility 

## 4.6.2

- fix: handle text nodes at root level, i.e. `t['someKey']`

## 4.6.1

- fix: missing key parameter

## 4.6.0

- feat: add flat translation map, accessible via `t['someKey.anotherKey']`

## 4.5.0

- feat: remove hint when overriding plural resolvers (were too verbose)
- feat: generated plural resolvers fallback to default quantity if null
- feat: add `zero` quantity to `cs`, `de`, `en` and `vi` (not breaking)
- docs: it is now recommended to put this library into `dev_dependencies`

## 4.4.1

- fix: `@` for `required` missing (Flutter 1.x.x)
- fix: `null_safety` is `true` by default (as intended in 4.4.0)

## 4.4.0

- feat: add Flutter 1.x.x support, build_runner detects this automatically, otherwise set `null_safety: false` in `build.yaml`
- feat: `flutter pub run fast_i18n` ignores `build.yaml` files without fast_i18n entry
- fix: add type hint for `_renderedResolvers`

## 4.3.0

- feat: plural resolvers can now be overwritten
- fix: make params distinct
- fix: sort locales correctly (base first, then alphabetically)

## 4.2.0

- feat: add pluralization support
- feat: `AppLocale` has a new property called `flutterLocale`
- feat: new command `flutter pub run fast_i18n` which is much faster than `flutter pub run build_runner build --delete-conflicting-outputs`

## 4.1.1

- fix: `LocaleSettings.setLocaleRaw` for locales encoded with underscore `_`
- docs: update README

## 4.1.0

A rebuild is needed: `flutter pub run build_runner build`.

- feat: the generated file is now self-contained, it works even if you remove this library!
- feat: add stats and timestamp to the generated file
- fix: parse files with underscore only (e.g. `strings_en_US`)
- fix: parse files with script tag (e.g. `strings_zh-Hant-TW`)
- perf: generate `LocaleSettings.supportedLocales` statically without library call
- perf: remove switch call in `Translations.of(context)`.
- docs: updates in generated file
- docs: update README

## 4.0.0

**The typed version is now first class.**
- **Breaking:** `setLocale` -> `setLocaleRaw`, `setLocaleTyped` -> `setLocale`
- **Breaking:** `locales` -> `supportedLocalesRaw`
- **Breaking:** `AppLocale.toLanguageTag` -> `AppLocale.languageTag`
- **Breaking:** translation classes are now private by default, you can configure it via `translation_class_visibility` in `build.yaml` (in most cases just keep it private!)
- plain strings are now implemented via getters, `edit json -> rebuild i18n -> hot reload` works now for faster development

## 3.0.4

- fix `LocaleSettings.useDeviceLocale()` causing compilation error (Flutter Web)

## 3.0.3

- docs: add hint for `.i18n.json` extension
- docs: update code examples
- docs: update image

## 3.0.2

- new optional case transformation: `pascal`
- remove recase dependency
- code changes in generated .g.dart file

## 3.0.1

- add real project example
- update FAQ in README
- depend on null-safety version of recase package

## 3.0.0

- null safety support
- add type-safe functions `LocaleSettings.setLocaleTyped` and `LocaleSettings.currentLocaleTyped`
- **Breaking:** `output_translate_var` renamed to `translate_var` in `build.yaml`

## 2.3.1

- Make locales case sensitive to comply with `MaterialApp`'s `supportedLocales`.

## 2.3.0

- Add `supportedLocales` property that can be used to fill `MaterialApp`'s `supportedLocales` argument.

## 2.2.1

- Fix compilation error occurring when non-standard name (not 'strings.i18n.json') is used for json files.

## 2.2.0

- new config: `output_translate_var`, renames default `t` variable
- internal: device locale now fetched via `Platform.localeName`

## 2.1.0

A rebuild is needed: `flutter pub run build_runner build`.

- API change: LocaleSettings.useDeviceLocale() is no longer asynchronous and now returns the new locale (was `Future<void>`)
- API change: LocaleSettings.setLocale(locale) now also returns the new locale (was `void`)

Just in case you use internal API:
FastI18n.findDeviceLocale has been renamed to FastI18n.getDeviceLocale

## 2.0.0

Thanks to @DenchikBY ([https://github.com/DenchikBY](https://github.com/DenchikBY)).

- Now it's possible to set in and out directories for files.
- You can set the pattern by which to search for files.
- Generated keys can be switched to another case in generated classes.
- Removed dependency on devicelocale.
- Configs with baseLocale and maps moved from config.i18n.json to build.yaml
- Generators replaced with fields for keys with static values.
- Arguments now can be wrapped with braces like ${key}.
- Removed deprecated `#map` mode (deprecated in 1.5.0)

Example of new config in build.yaml:
```yaml
targets:
  $default:
    builders:
      fast_i18n:i18nBuilder:
        options:
          base_locale: en
          input_directory: lib/i18n
          input_file_pattern: .i18n.json
          output_directory: lib/i18n
          output_file_pattern: .g.dart
          key_case: snake
          maps:
            - a
            - b
            - c.d
```

## 1.8.2

- Hotfix: possible NPE when calling Translations.of(context)

## 1.8.1

- Hotfix: possible NPE error when calling LocaleSettings.useDeviceLocale or LocaleSettings.setLocale

## 1.8.0

- New advanced mode: final t = Translations.of(context)

## 1.7.0

- Prefer language code over region code.

## 1.6.1

- Add more unit tests.
- Code Polishing.

## 1.6.0

- Generates `List<String>` or `Map<String, String>` instead of `List<dynamic>` or `Map<String, dynamic>` if the children are only strings.
- You will experience a better autocompletion like `.substring`, `.indexOf`, etc. because of that.

## 1.5.0

- Define additional metadata in the `config.i18n.json` file.
- Maps defined with `#map` are now deprecated. Use `config.i18n.json` for that.
- Add `LocaleSettings.locales` to get the supported locales.

## 1.4.0

- Add support for country codes. Use e.g. `strings_en_US.i18n.json` or `strings_en-US.i18n.json`.
- Add fallback for `LocaleSettings.setLocale` if locale is not supported.

## 1.3.0

- Add support for lists.
- Add support for maps. Use `{ "#map": "" }` to enable map inlining.

## 1.2.0

- Only one single `.g.dart` will be generated

## 1.1.2

- Fix iOS bug in `LocaleSettings.useDeviceLocale`

## 1.1.1

- Fix for `LocaleSettings.useDeviceLocale`

## 1.1.0

- Add `LocaleSettings.useDeviceLocale()`

## 1.0.0

- Initial Release
- basic json support (no arrays)
