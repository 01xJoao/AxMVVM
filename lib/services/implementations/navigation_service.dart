part of axmvvm.services;

class NavigationService implements INavigationService {
  @override
  ViewModel createViewModelForBottomNavigationView<T extends ViewModel>({Object parameter}) {
    return null;
  }

  @override
  ViewModel createViewModelForInitialView<T extends ViewModel>() {
    return null;
  }

  @override
  void initialize() {
  }

  @override
  Future<void> navigateAndRemoveAllAsync<V extends ViewModel>({Object parameter}) {
    return null;
  }

  @override
  Future<void> navigateAndRemoveCurrentAsync<V extends ViewModel>({Object parameter, bool animateToBackFirst}) {
    return null;
  }

  @override
  Future<void> navigateAsync<V extends ViewModel>({Object parameter}) {
    return null;
  }

  @override
  Future<void> navigateBackAsync() {
    return null;
  }

  @override
  Future<void> navigateBackUntilAsync<V extends ViewModel>() {
    return null;
  }

  @override
  Future<void> navigateBackWithResultAsync<O extends Object>({O parameter}) {
    return null;
  }

  @override
  Future<O> navigateForResultAsync<O extends Object, V extends ViewModel>({Object parameter}) {
    return null;
  }
  
}