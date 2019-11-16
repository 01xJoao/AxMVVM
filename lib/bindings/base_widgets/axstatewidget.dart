part of axmvvm.bindings;

/// State object to be used with binding for StatefulWidgets.
///
/// This class must be exended whenever data binding is desired for a StatelfulWidget.
/// 
/// Intended to be used in conjenction with the AxStatefulWidget class.
abstract class AxStateWidget<T extends StatefulWidget, B extends BindableBase>
    extends State<T> implements BindableModelHolder<B> {

  final B _bindableModel;
  LayoutInformation _layoutInformation;
  bool _widgetDidLoad = false;
  
  @mustCallSuper
  AxStateWidget(this._bindableModel) {
    if (_bindableModel is! BindableBase) {
      throw ArgumentError('AxWidgetState Objects must be of type BindableBase');
    }
  }
  @override
  B get bindableModel => _bindableModel;
  LayoutInformation get layoutInformation => _layoutInformation;

  /// This method is only called once when the view is built for the first time.
  /// 
  /// Context of the view is available.
  void widgetDidLoad(){
    _widgetDidLoad = true;
  } 

  /// Creates viewDidLoad functionality.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _layoutInformation = LayoutInformation(context);
    if(!_widgetDidLoad)
      widgetDidLoad();
  }
}
