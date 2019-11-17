part of axmvvm.services;

/// Interface for the localization service to be used by viewmodels.
///
/// An implementation of this class is the basis to globalize the app.
abstract class ILocalizationService extends LocalizationsDelegate<Location> {
  /// Initialize the service with the path to the directory where the json translation files are located.
  /// 
  /// Also set all the supported languages by the app.
  void initialize(String pathToJson, List<Locale> supportedLocales);

  /// Set a different language of the system prefferred language.
  void setLanguage(String language);

  /// Get the current language used by the app.
  String getCurrentLanguage();

  /// Get the localized word with a given [key].
  String localize(String key);
}