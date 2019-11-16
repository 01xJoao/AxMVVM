part of axmvvm.bindings;

/// State object to be used with binding for StatefulWidgets.
///
/// This class must be exended whenever data binding is desired for a StatelfulWidget.
/// 
/// Intended to be used in conjenction with the AxStatefulWidget class.
abstract class AxStateWidget<T extends StatefulWidget, B extends BindableBase>
    extends State<T> implements BindableModelHolder<B> {

  final B _bindableModel;
  bool _isDeviceInPortrait;
  MediaQueryData _mediaQueryData;
  double _deviceWidth;
  double _deviceHeight;
  bool _widgetDidLoad = false;
  
  @mustCallSuper
  AxStateWidget(this._bindableModel) {
    if (_bindableModel is! BindableBase) {
      throw ArgumentError('AxWidgetState Objects must be of type BindableBase');
    }
  }
  @override
  B get bindableModel => _bindableModel;
  bool get isDeviceInPortrait => _isDeviceInPortrait;
  bool get isDeviceApple => Platform.isIOS || Platform.isMacOS;
  bool get isDeviceSmartPhone => SmartphoneDetector.isSmartPhone(_mediaQueryData);
  String get deviceOS => Platform.operatingSystem;
  double get deviceWidth => _deviceWidth;
  double get deviceHeight => _deviceHeight;
  MediaQueryData get deviceDataQuery => _mediaQueryData;

  /// This method is only called once when the view is built for the first time.
  /// 
  /// Context of the view is available.
  void widgetDidLoad(){
    _mediaQueryData = MediaQuery.of(context);
    _isDeviceInPortrait = _mediaQueryData.orientation == Orientation.portrait;
    _deviceWidth = _mediaQueryData.size.width;
    _deviceHeight = _mediaQueryData.size.height;
    _widgetDidLoad = true;
  } 

  /// Creates viewDidLoad functionality.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!_widgetDidLoad)
      widgetDidLoad();
  }
}
