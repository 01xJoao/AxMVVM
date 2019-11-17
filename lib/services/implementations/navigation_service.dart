part of axmvvm.services;

/// Implementation of the Navigation Service.
class NavigationService implements INavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final List<ViewModel> _viewModelRepository = <ViewModel>[];

  /// Global key for the app navigation.
  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  
  /// This method is useful to create a viewmodel for the application starting view.
  /// 
  /// Viewmodel's method [initializeAsync()] is not called.
  @override
  ViewModel createViewModelForInitialView<V extends ViewModel>({Object parameter}) {
    final ViewModel viewModel = AxCore.container.getInstance<V>();
    viewModel.initialize(parameter);
    _viewModelRepository.add(viewModel);
    return _viewModelRepository.last;
  }

  /// Creates a viewmodel for the bottom navigation of a specified type.
  /// 
  /// Viewmodel's initialize methods are not called.
  /// 
  /// To call [initialize()] method set the view as a bottomNavigationView. 
  @override
  ViewModel createViewModelForBottomNavigation<V extends ViewModel>() {
    final ViewModel viewModel = AxCore.container.getInstance<V>();
    _viewModelRepository.add(viewModel);
    return _viewModelRepository.last;
  }

  /// Navigates to a new viewmodel of the specified type.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's initialize methods.
  @override
  Future<void> navigate<V extends ViewModel>({Object parameter}) async {
    await _createViewModel<V>(parameter);
      
    _navigatorKey.currentState.pushNamed(
      Utilities.getViewFromViewModelType<V>(), arguments: _viewModelRepository.last);
  }

  /// Navigates to a new viewmodel of the specified type.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's initialize methods.
  /// 
  /// Awaits for the called viewmodel to close.
  @override
  Future<void> navigateAsync<V extends ViewModel>({Object parameter}) async {
    await _createViewModel<V>(parameter);
      
    await _navigatorKey.currentState.pushNamed(
      Utilities.getViewFromViewModelType<V>(), arguments: _viewModelRepository.last);
  }

  /// Navigates to a new viewmodel of the specified type.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's initialize methods. 
  /// 
  /// It is expected that the viewmodel being navigated to will return an object when it is popped off.
  @override
  Future<T> navigateForResultAsync<T extends Object, V extends ViewModel>({Object parameter}) async {
    await _createViewModel<V>(parameter);

    return await _navigatorKey.currentState.pushNamed<dynamic>(
      Utilities.getViewFromViewModelType<V>(), arguments: _viewModelRepository.last);
  }

  /// Navigates to a new viewmodel and removes the calling viewmodel from the stack.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's initialize methods.
  /// 
  /// The [animateToBackFirst] will navigate to the previous view before pushing the new one.
  @override
  Future<void> navigateAndRemoveCurrentAsync<V extends ViewModel>({Object parameter, bool animateToBackFirst = false}) async {
    await _createViewModel<V>(parameter);
      
    if(animateToBackFirst){
      _navigatorKey.currentState.popAndPushNamed(
        Utilities.getViewFromViewModelType<V>(), arguments: _viewModelRepository.last);
    } else {
      _navigatorKey.currentState.pushReplacementNamed(
        Utilities.getViewFromViewModelType<V>(), arguments: _viewModelRepository.last);
    }

    _viewModelRepository.removeAt(_viewModelRepository.length-2).dispose();
  }

  /// Navigates to a new viewmodel and removes all viewmodels on the stack
  /// 
  /// The [parameter] is a value that will be passed to the new viewmodel's initialize methods.
  @override
  Future<void> navigateAndRemoveAllAsync<V extends ViewModel>({Object parameter}) async {
    await _createViewModel<V>(parameter);

    _navigatorKey.currentState.pushNamedAndRemoveUntil(
      Utilities.getViewFromViewModelType<V>(), 
      (Route<dynamic> route) => false, 
      arguments: _viewModelRepository.last
    );
    
    _clearViewModelStack(_viewModelRepository.last);
  }

  /// Pops the current viewmodel off the stack and goes to the previous one.
  @override
  Future<void> navigateBackAsync() async {
    if(_navigatorKey.currentState.canPop()){
      _navigatorKey.currentState.pop();
      await navigatingBack();
    }
  }

  /// Pops the current viewmodel off the stack and goes to the previous one.
  ///
  /// The [paramter] is the result to send back to the calling viewmodel.
  /// 
  /// This should be used in conjunction with navigateAsyncForResult.
  @override
  Future<void> navigateBackWithResultAsync<T extends Object>(T parameter) async {
    if(_navigatorKey.currentState.canPop()){
        _navigatorKey.currentState.pop(parameter);
        await navigatingBack();
      }
  }

  /// Will close all viewmodels async until it finds the viewmodel of a specified type.
  @override
  Future<void> navigateBackUntilAsync<V extends ViewModel>() async {
    if(_viewModelRepository.any((ViewModel v) => v.runtimeType == V)){
      final int viewModelIndex = _viewModelRepository.indexWhere((ViewModel v) => v.runtimeType == V);
      
      for(int i = _viewModelRepository.length-1; i > viewModelIndex; i--){
        _navigatorKey.currentState.pop();

        _viewModelRepository.last.closing();
        await _viewModelRepository.last.closingAsync();

        _viewModelRepository.removeAt(i).dispose();
      }
    }
  }

  /// Navigation method to be used internally, DON'T use this.
  @override
  Future<void> navigatingBack({ViewModel closedViewModel}) async {
    if(closedViewModel != null && closedViewModel != _viewModelRepository.last)
      return;

    _viewModelRepository.last.closing();
    await _viewModelRepository.last.closingAsync();
    _viewModelRepository.removeLast().dispose();
  }

  /// Creates a viewmodel of a specified type.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's initialize methods.
  Future<void> _createViewModel<V extends ViewModel>(Object parameter) async {
    final ViewModel viewModel = AxCore.container.getInstance<V>();
    viewModel.initialize(parameter);
    await viewModel.initializeAsync(parameter);
    _viewModelRepository.add(viewModel);
  }

  /// Clears all viewmodels in the stack except the current viewmodel.
  void _clearViewModelStack(ViewModel exceptViewModel) {
    for(int i = 0; i < _viewModelRepository.length-1; i++)
      _viewModelRepository[i].dispose();

    _viewModelRepository.clear();
    _viewModelRepository.add(exceptViewModel);
  }
}