import 'package:axmvvm/bindables/axviewmodel.dart';

class Utilities {
  /// Returns a type object for a generic.
  static Type typeOf<T>() => T;

  /// Returns a string view name based on a viewmodel type.
  String getViewFromViewModelType<T extends AxViewModel>() {
    final String typeName = Utilities.typeOf<T>().toString();
    return typeName.replaceAll('ViewModel', 'View');
  }
}

enum Lifestyle { transientRegistration, singletonRegistration }
