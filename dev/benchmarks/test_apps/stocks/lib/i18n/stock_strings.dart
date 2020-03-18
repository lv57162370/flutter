// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: unused_import
import 'package:intl/intl.dart' as intl;

// ignore_for_file: unnecessary_brace_in_string_interps

/// Callers can lookup localized strings with an instance of StockStrings returned
/// by `StockStrings.of(context)`.
///
/// Applications need to include `StockStrings.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'i18n/stock_strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: StockStrings.localizationsDelegates,
///   supportedLocales: StockStrings.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: 0.16.0
///   intl_translation: 0.17.7
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the StockStrings.supportedLocales
/// property.
abstract class StockStrings {
  StockStrings(String locale) : assert(locale != null), _localeName = intl.Intl.canonicalizedLocale(locale.toString());

  // ignore: unused_field
  final String _localeName;

  static StockStrings of(BuildContext context) {
    return Localizations.of<StockStrings>(context, StockStrings);
  }

  static const LocalizationsDelegate<StockStrings> delegate = _StockStringsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('en, US'),
    Locale('es')
  ];

  // Title for the Stocks application
  String get title;

  // Label for the Market tab
  String get market;

  // Label for the Portfolio tab
  String get portfolio;
}

class _StockStringsDelegate extends LocalizationsDelegate<StockStrings> {
  const _StockStringsDelegate();

  @override
  Future<StockStrings> load(Locale locale) {
    return SynchronousFuture<StockStrings>(_lookupStockStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_StockStringsDelegate old) => false;
}

/// The translations for English (`en`).
class StockStringsEn extends StockStrings {
  StockStringsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Stocks';

  @override
  String get market => 'MARKET';

  @override
  String get portfolio => 'PORTFOLIO';
}

/// The translations for English, as used in the United States (`en_US`).
class StockStringsEnUs extends StockStringsEn {
  StockStringsEnUs([String locale = 'en_US']) : super(locale);

  @override
  String get title => 'Stocks';

  @override
  String get market => 'MARKET';

  @override
  String get portfolio => 'PORTFOLIO';
}

/// The translations for Spanish Castilian (`es`).
class StockStringsEs extends StockStrings {
  StockStringsEs([String locale = 'es']) : super(locale);

  @override
  String get title => 'Acciones';

  @override
  String get market => 'MERCADO';

  @override
  String get portfolio => 'CARTERA';
}

StockStrings _lookupStockStrings(Locale locale) {
  switch(locale.languageCode) {
    case 'en': {
      switch (locale.countryCode) {
        case 'US': return StockStringsEnUs();
      }
      return StockStringsEn();
    }
    case 'es': return StockStringsEs();
  }
  assert(false, 'StockStrings.delegate failed to load unsupported locale "$locale"');
  return null;
}