part of axmvvm.bindings;

/// State object to be used with binding for StatefulViews.
///
/// This class must be exended whenever data binding is desired for a StatelfulView.
/// 
/// Intended to be used in conjenction with the AxStatefulView class.
abstract class AxStateView<T extends StatefulWidget, V extends ViewModel>
    extends State<T> with WidgetsBindingObserver implements ViewModelHolder<V> {

  final V _viewModel;
  final bool _isBottomNavigationView;
  LayoutInformation _layoutInformation;
  bool _viewDidLoad = false;

  @mustCallSuper
  AxStateView(this._viewModel, [this._isBottomNavigationView]) {
    if (_viewModel is! ViewModel)
      throw ArgumentError('AxStateView Objects must be of type ViewModel');
  }

  /// The class's viewmodel reference.
  @override
  V get viewModel => _viewModel;
  LayoutInformation get layoutInformation => _layoutInformation;

  /// This method is only called once when the view is built for the first time.
  /// 
  /// Context of the view is available.
  @mustCallSuper
  void viewDidLoad() {
    _viewModel.appeared();
    _viewDidLoad = true;
  }

  /// The application is visible and responding to user input.
  @mustCallSuper
  void viewDidEnterForeground(){
    _viewModel.resumed();
  }

  /// The application is not currently visible to the user, not responding to user input, and running in the background.
  @mustCallSuper
  void viewDidEnterBackground(){
    _viewModel.paused();
  }

  void viewDidDisappear(){}

  /// Call this method on top of the widget tree to call viewmodel's close method when pressing back button.
  /// 
  /// This will remove the swipe back gesture
  Widget handleBackButton({Widget view}){
    return WillPopScope(
      onWillPop: () async { 
        _viewModel.close();
        return false;
      },
      child: view ?? const SizedBox(),
    );
  } 

  @override
  @mustCallSuper
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if(_isBottomNavigationView ?? false)
      _viewModel.initialize(null);
  }
    
  /// Creates method viewDidLoad.
  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();
    _layoutInformation = LayoutInformation(context);
    if(!_viewDidLoad)
      viewDidLoad();
  }

  /// Creates methods viewEnterBackground and viewEnterForeground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused)
      viewDidEnterBackground();
    if (state == AppLifecycleState.resumed)
      viewDidEnterForeground();
  }

  /// Creates method viewDidDisapear and makes sure the viewmodel will be disposed.
  @override
  @mustCallSuper
  void dispose() {
    viewDidDisappear();
    if(_viewModel != null)
      AxCore.container.getInstance<INavigationService>().navigatingBack(closedViewModel: _viewModel);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
