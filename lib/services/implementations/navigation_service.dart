part of axmvvm.services;

class NavigationService implements INavigationService {
  @override
  ViewModel createViewModelForBottomNavigationView<T extends ViewModel>({Object parameter}) {
    // TODO: implement createViewModelForBottomNavigationView
    return null;
  }

  @override
  ViewModel createViewModelForInitialView<T extends ViewModel>() {
    // TODO: implement createViewModelForInitialView
    return null;
  }

  @override
  void initialize() {
    // TODO: implement initialize
  }

  @override
  Future<void> navigate<V extends ViewModel>({Object parameter}) {
    // TODO: implement navigate
    return null;
  }

  @override
  Future<void> navigateAndRemoveAll<V extends ViewModel>({Object parameter}) {
    // TODO: implement navigateAndRemoveAll
    return null;
  }

  @override
  Future<void> navigateAndRemoveCurrent<V extends ViewModel>({Object parameter, bool animateToBackFirst}) {
    // TODO: implement navigateAndRemoveCurrent
    return null;
  }

  @override
  Future<void> navigateBack() {
    // TODO: implement navigateBack
    return null;
  }

  @override
  void navigateBackUntil<V extends ViewModel>() {
    // TODO: implement navigateBackUntil
  }

  @override
  Future<void> navigateBackWithResult<O extends Object>({O parameter}) {
    // TODO: implement navigateBackWithResult
    return null;
  }

  @override
  Future<R> navigateForResult<R extends Object, V extends ViewModel>({Object parameter}) {
    // TODO: implement navigateForResult
    return null;
  }
  
}