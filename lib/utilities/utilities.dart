library axmvvm.utilities;

import 'package:axmvvm/bindings/bindings.dart';

class Utilities {
  /// Returns a type object for a generic.
  static Type typeOf<T>() => T;

  /// Returns a string view name based on a viewmodel type.
  static String getViewFromViewModelType<T extends ViewModel>() {
    final String typeName = Utilities.typeOf<T>().toString();
    return typeName.replaceAll('ViewModel', 'View');
  }
}

/// Contains static variables for items used by axmvvm.
class Constants {
  static const String buildContext = 'BuildContext';
  static const String locate = 'Locale';
  static const String localizationReady = 'LocalizationReady';
}

enum Lifestyle { transientRegistration, singletonRegistration }
