// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter tools sample`
  String get app_name {
    return Intl.message(
      'Flutter tools sample',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Calculator`
  String get app_version {
    return Intl.message(
      'Calculator',
      name: 'app_version',
      desc: '',
      args: [],
    );
  }

  /// `START`
  String get common_start {
    return Intl.message(
      'START',
      name: 'common_start',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get common_yes {
    return Intl.message(
      'YES',
      name: 'common_yes',
      desc: '',
      args: [],
    );
  }

  /// `NO`
  String get common_no {
    return Intl.message(
      'NO',
      name: 'common_no',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get common_ok {
    return Intl.message(
      'OK',
      name: 'common_ok',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL`
  String get common_cancel {
    return Intl.message(
      'CANCEL',
      name: 'common_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Tools list`
  String get tools_list_title {
    return Intl.message(
      'Tools list',
      name: 'tools_list_title',
      desc: '',
      args: [],
    );
  }

  /// `This App provides sample implementation of tools using with Flutter. If you want to see the implementation of this app source, please access the following URL link.`
  String get main_explain_message {
    return Intl.message(
      'This App provides sample implementation of tools using with Flutter. If you want to see the implementation of this app source, please access the following URL link.',
      name: 'main_explain_message',
      desc: '',
      args: [],
    );
  }

  /// `Tap the start button to see a list of tools.`
  String get main_start_button_message {
    return Intl.message(
      'Tap the start button to see a list of tools.',
      name: 'main_start_button_message',
      desc: '',
      args: [],
    );
  }

  /// `Calculator`
  String get tools_my_calculator {
    return Intl.message(
      'Calculator',
      name: 'tools_my_calculator',
      desc: '',
      args: [],
    );
  }

  /// `My Bookmarks`
  String get tools_my_bookmarks {
    return Intl.message(
      'My Bookmarks',
      name: 'tools_my_bookmarks',
      desc: '',
      args: [],
    );
  }

  /// `Flutter tools sample, testing flutter code.`
  String get about_description {
    return Intl.message(
      'Flutter tools sample, testing flutter code.',
      name: 'about_description',
      desc: '',
      args: [],
    );
  }

  /// `String number is $number`
  String get string_arguments {
    return Intl.message(
      'String number is \$number',
      name: 'string_arguments',
      desc: '',
      args: [],
    );
  }

  /// `Android Layout List`
  String get android_layout_list_title {
    return Intl.message(
      'Android Layout List',
      name: 'android_layout_list_title',
      desc: '',
      args: [],
    );
  }

  /// `Show zoom character`
  String get show_zoom_character {
    return Intl.message(
      'Show zoom character',
      name: 'show_zoom_character',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}