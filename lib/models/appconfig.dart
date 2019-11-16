import 'package:axmvvm/models/models.dart';
import 'package:flutter/material.dart';

class AppConfig {
  /// Set the title of the app.
  final String _title;
  /// Set the localizations of the  app.
  LocalizationHelper _localization;
  /// Set the color of the loading view (Used when Localization Service is loading).
  Color _loadingViewColor;
  /// Set the navigation observers of the app 
  List<NavigatorObserver> _navigatorObservers;
  /// The theme to use for the app.
  ThemeData _theme;
  /// The dark theme to use for the app.
  ThemeData _darkTheme;

  // App properties to help setting up the app.
  AppConfig(this._title, {LocalizationHelper localization, Color loadingViewColor, List<NavigatorObserver> navigatorObservers, ThemeData theme, ThemeData darkTheme}){
    _localization = localization;
    _loadingViewColor = loadingViewColor ?? Colors.white;
    _navigatorObservers = navigatorObservers ?? <NavigatorObserver>[];
    _theme = theme;
    _darkTheme = darkTheme;
  }

  String get title => _title;
  LocalizationHelper get localization => _localization;
  Color get loadingViewColor => _loadingViewColor;
  List<NavigatorObserver> get navigatorObservers => _navigatorObservers;
  ThemeData get theme => _theme;
  ThemeData get darkTheme => _darkTheme;
}