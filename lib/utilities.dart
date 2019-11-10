part of axmvvm;

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

/// Interface for valueConverters that change data from one format to another and back.
///
/// This is typically used by data binding to convert the value from a bindableBase
/// into a format that is expected by a widget and back again.
abstract class IValueConverter {
  /// Converts data from a BindableBase property into a format usable by a widget.
  Object convert(Object source, Object value, {Object parameter});

  /// Takes data from a widget and converts it into a format that is expected by a BindableBase property.
  Object convertBack(Object source, Object value, {Object parameter});
}

/// Used to tell if a Binding object's original value was ever set.
class OriginalValueNeverSet {}

/// What type of binding to create.
enum Lifestyle { transientRegistration, singletonRegistration }

/// What type of binding to create.
enum BindDirection { OneTime, TwoWay }


class SmartphoneDetector {
  static bool isSmartPhone(MediaQueryData query) {
    final Size size = query.size;
    final double diagonal = sqrt((size.width * size.width) + (size.height * size.height));
    return diagonal < 1100;
  }

  // iPhone 6S 
  // |_ [portrait]
  //    |_ size: 375.0x667.0, pixelRatio: 2.0, pixels: 750.0x1334.0
  //       |_ diagonal: 765.1888655750291
  // |_ [horizontal]
  //    |_ size: 667.0x375.0, pixelRatio: 2.0, pixels: 1334.0x750.0
  //       |_ diagonal: 765.1888655750291

  // iPhone X 
  // |_ [portrait]
  //    |_ size: 375.0x812.0, pixelRatio: 3.0, pixels: 1125.0x2436.0
  //       |_ diagonal: 894.4098613052072
  // |_ [horizontal]
  //    |_ size: 812.0x375.0, pixelRatio: 3.0, pixels: 2436.0x1125.0
  //       |_ diagonal: 894.4098613052072

  // iPhone XS Max 
  // |_ [portrait]
  //    |_ size: 414.0x896.0, pixelRatio: 3.0, pixels: 1242.0x2688.0
  //       |_ diagonal: 987.0217829409845
  // |_ [horizontal]
  //    |_ size: 896.0x414.0, pixelRatio: 3.0, pixels: 2688.0x1242.0
  //       |_ diagonal: 987.0217829409845

  // iPad Pro (9.7-inch) 
  // |_ [portrait]
  //    |_ size: 768.0x1024.0, pixelRatio: 2.0, pixels: 1536.0x2048.0
  //       |_ diagonal: 1280.0
  // |_ [horizontal]
  //    |_ size: 1024.0x768.0, pixelRatio: 2.0, pixels: 2048.0x1536.0
  //       |_ diagonal: 1280.0

  // iPad Pro (10.5-inch) 
  // |_ [portrait]
  //    |_ size: 834.0x1112.0, pixelRatio: 2.0, pixels: 1668.0x2224.0
  //       |_ diagonal: 1390.0
  // |_ [horizontal]
  //    |_ size: 1112.0x834.0, pixelRatio: 2.0, pixels: 2224.0x1668.0
  //       |_ diagonal: 1390.0

  // iPad Pro (12.9-inch) 
  // |_ [portrait]
  //    |_ size: 1024.0x1366.0, pixelRatio: 2.0, pixels: 2048.0x2732.0
  //       |_ diagonal: 1707.2000468603555
  // |_ [horizontal]
  //    |_ size: 1366.0x1024.0, pixelRatio: 2.0, pixels: 2732.0x2048.0
  //       |_ diagonal: 1707.2000468603555
}