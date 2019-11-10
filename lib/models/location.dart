part of axmvvm.models;

/// Helper class for translation.
class Location {
  final Locale locale;

  Location(this.locale);

  static Location of(BuildContext context) {
    return Localizations.of<Location>(context, Location);
  }

  Map<String, String> _localizedValues;

  Future<void> loadLocalizedValues(String root) async {
    final String data = await rootBundle.loadString('$root${locale.languageCode}.json');
    final dynamic jsonString = json.decode(data);
    _localizedValues = <String, String>{};

    jsonString.forEach((String key, dynamic value) {
      _localizedValues[key] = value.toString();
    });
  }

  String locate(String key) {
    return _localizedValues[key];
  }
}
