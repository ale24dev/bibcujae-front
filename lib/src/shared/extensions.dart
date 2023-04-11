import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  /// Accessing easily to flutter translations
  AppLocalizations get loc => AppLocalizations.of(this)!;

  /// Accessing easily to current language.
  String get currentLanguage {
    return Localizations.localeOf(this).toLanguageTag();
  }

  /// Accessing easily to the app theme
  ThemeData get theme => Theme.of(this);

  ///Accessing easily to the TextTheme of the app
  TextTheme get textTheme => theme.textTheme;
}
