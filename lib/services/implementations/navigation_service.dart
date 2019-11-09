part of axmvvm.services;

/// Implementation of the axmvvm NavigationService interface.
class NavigationService implements INavigationService {
  BuildContext _viewContext;
  final List<ViewModel> _viewModelRepository = <ViewModel>[];

  /// Creates a subscription for the context of the view.
  ///
  /// This is called once when axmvvm is initialized.
  @override
  void initialize() {
    final Subscription subscription = Subscription(Constants.buildContext, (Object context) {
      _viewContext = context;
    });

    AxCore.container.getInstance<IMessageService>().subscribe(subscription);
  }

  /// Creates a view model for the initial view
  ///
  /// viewmodel's initializeAsync method is not called here.
  @override
  ViewModel createViewModelForInitialView<T extends ViewModel>() {
    final ViewModel viewModel = AxCore.container.getInstance<T>();
    viewModel.initialize();
    _viewModelRepository.add(viewModel);
    return _viewModelRepository.last;
  }

  /// Creates a view model for bottom navigation
  ///
  /// viewmodel's initialize and initializeAsync methods is not called here.
  @override
  ViewModel createViewModelForBottomNavigation<T extends ViewModel>({Object parameter}) {
    final ViewModel viewModel = AxCore.container.getInstance<T>();
    _viewModelRepository.add(viewModel);
    return _viewModelRepository.last;
  }

  /// Navigates to a new viewmodel of the type specified by the generic.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's init method.
  @override
  Future<void> navigateAsync<V extends ViewModel>({Object parameter}) async {
    await _createViewModel<V>(parameter);
      
    Navigator.of(_viewContext).pushNamed(
      Utilities.getViewFromViewModelType<V>(), arguments: _viewModelRepository.last);
  }

  /// Navigates to a new viewmodel of the type specified by the generic.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's init method. 
  /// 
  /// It is expected that the viewmodel being navigated to will return an object when it is popped off.
  @override
  Future<O> navigateForResultAsync<O extends Object, V extends ViewModel>({Object parameter}) async {
    await _createViewModel<V>(parameter);

    return await Navigator.of(_viewContext).pushNamed<O>(
      Utilities.getViewFromViewModelType<V>(), arguments: _viewModelRepository.last);
  }

  /// Navigates to a new viewmodel and removes the calling viewmodel from the stack.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's init method.
  /// 
  /// The [animateToBackFirst] will navigate to the previous view before pushing the new one.
  @override
  Future<void> navigateAndRemoveCurrentAsync<V extends ViewModel>({Object parameter, bool animateToBackFirst = false}) async {
    await _createViewModel<V>(parameter);
      
    if(animateToBackFirst){
      Navigator.of(_viewContext).popAndPushNamed(
        Utilities.getViewFromViewModelType<V>(), arguments: _viewModelRepository.last);
    } else {
      Navigator.of(_viewContext).pushReplacementNamed(
        Utilities.getViewFromViewModelType<V>(), arguments: _viewModelRepository.last);
    }

    _viewModelRepository.removeAt(_viewModelRepository.length-2)?.dispose();
  }

  /// Navigates to a new viewmodel and removes all viewmodels on the stack
  /// 
  /// The [parameter] is a value that will be passed to the new viewmodel's init method.
  @override
  Future<void> navigateAndRemoveAllAsync<V extends ViewModel>({Object parameter}) async {
    await _createViewModel<V>(parameter);

    Navigator.of(_viewContext).pushNamedAndRemoveUntil(
      Utilities.getViewFromViewModelType<V>(), 
      (Route<dynamic> route) => false, 
      arguments: _viewModelRepository.last
    );
    
    _clearViewModelStack(_viewModelRepository.last);
  }

  /// Pops the current view / viewmodel off the stack and goes to the previous one.
  @override
  Future<void> navigateBackAsync() async {
    if(Navigator.canPop(_viewContext)) {
      Navigator.of(_viewContext).pop();

      _viewModelRepository.last.closing();
      await _viewModelRepository.last.closingAsync();
      _viewModelRepository.removeLast().dispose();
    }
  }

  /// Pops the current view / viewmodel off the stack and goes to the previous one.
  ///
  /// The [paramter] is the result to send back to the calling viewmodel.
  /// 
  /// This should be used in conjunction with navigateAsyncForResult.
  @override
  Future<void> navigateBackWithResultAsync<O extends Object>({O parameter}) async {
    if(Navigator.canPop(_viewContext)){
      Navigator.of(_viewContext).pop(parameter);

      _viewModelRepository.last.closing();
      await _viewModelRepository.last.closingAsync();
      _viewModelRepository.removeLast().dispose();
    }
  }

  /// Will close all views and viewmodels async until it finds the viewmodel type 
  @override
  Future<void> navigateBackUntilAsync<V extends ViewModel>() async {
    if(_viewModelRepository.any((ViewModel v) => v.runtimeType == V)){
      final int index = _viewModelRepository.indexWhere((ViewModel v) => v.runtimeType == V);
      
      for(int i = _viewModelRepository.length-1; i > index; i--){
        Navigator.of(_viewContext).pop();
        _viewModelRepository.last.closing();
        await _viewModelRepository.last.closingAsync();
        _viewModelRepository.removeAt(i)?.dispose();
      }
    }
  }

  /// Creates a viewmodel of a specified type.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's init method.
  Future<void> _createViewModel<V extends ViewModel>(Object parameter) async {
    final ViewModel viewModel = AxCore.container.getInstance<V>();
    viewModel.initialize(parameter: parameter);
    await viewModel.initializeAsync(parameter: parameter);
    _viewModelRepository.add(viewModel);
  }

  /// Clears all view models in the stack except the current viewmodel
  void _clearViewModelStack(ViewModel exceptVM) {
    for(int i = 0; i < _viewModelRepository.length-1; i++)
      _viewModelRepository[i].dispose();

    _viewModelRepository.clear();
    _viewModelRepository.add(exceptVM);
  }
}