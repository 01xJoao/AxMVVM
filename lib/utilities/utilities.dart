library axmvvm.utilities;

class Utilities {
  /// Returns a type object for a generic.
  static Type typeOf<T>() => T;
}

enum Lifestyle { transientRegistration, singletonRegistration }
