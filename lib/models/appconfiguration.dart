part of axmvvm.models;

class AppConfiguration {
  final String _title;
  LocalizationHelper _localization;
  Color _loadingViewColor;
  List<NavigatorObserver> _navigatorObservers;
  ThemeData _theme;
  ThemeData _darkTheme;

  /// App properties to help setting up the app.
  /// 
  /// Set the [title], all supported [localization], the [loadingViewColor] (Used when Localization Service is loading).
  /// 
  /// Also add navigation observers (For example, to be used on a dialog service), and set the themes for the application.
  AppConfiguration(this._title, {LocalizationHelper localization, Color loadingViewColor, List<NavigatorObserver> navigatorObservers, ThemeData theme, ThemeData darkTheme}){
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