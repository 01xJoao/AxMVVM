part of axmvvm.services;

/// Localization service to be used by viewmodels.
class LocalizationService extends BindableBase implements ILocalizationService {
  String _pathToJson;
  Location _currentLocation;
  List<Locale> _supportedLocales;

  static PropertyInfo localeProperty = PropertyInfo(Constants.locate, Locale, null);
  String get locale => getValue(localeProperty);
  set _locale(Locale locale) => setValue(localeProperty, locale);

  static PropertyInfo localizationReadyProperty = PropertyInfo(Constants.localizationReady, bool, false);
  bool get localization => getValue(localizationReadyProperty);
  set _localization(bool ready) => setValue(localizationReadyProperty, ready);

  /// Initialize the service with the path to the directory where the json translation files are located.
  /// 
  /// Also set all the supported languages by the app.
  @override
  void initialize(String pathToJson, List<Locale> supportedLocales){
    _pathToJson = pathToJson;
    _supportedLocales = supportedLocales;
  } 

  /// Get the current language used by the app.
  @override
  String getCurrentLanguage() => _currentLocation?.locale?.languageCode;

  /// Get the localized word with a given [key].
  @override
  String localize(String key) => _currentLocation?.locate(key);

  /// Get the localized word with a given [key].
  @override
  void setLanguage(String language) {
    try {
      for (Locale supportedLocale in _supportedLocales) {
        if (supportedLocale.languageCode == language){
          _locale = supportedLocale;
          break;
        }
      }
    } catch (e) {
      throw ArgumentError(e.toString());
    }
  }

  /// Loads the app location.
  @override
  Future<Location> load(Locale locale) async {
    try {
      _currentLocation = Location(locale);
      await _currentLocation.loadLocalizedValues(_pathToJson);
      return _currentLocation;
    } catch (e) {
      throw ArgumentError(e.toString());
    } finally {
      _localization = true;
    }
  }

  @override
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(LocalizationsDelegate<Location> old) => true;

  @override
  Type get type => null;
}