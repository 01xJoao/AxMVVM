part of axmvvm.services;

/// Interface for a navigation service to be used by viewmodels.
///
/// An implementation of this class is the basis for viewmodel first navigation.
abstract class INavigationService {
  ///Global key for the app navigation.
  GlobalKey<NavigatorState> get navigatorKey;

  /// This method is useful to create a viewmodel for the application starting view.
  /// 
  /// Viewmodel's method [initializeAsync()] is not called.
  ViewModel createViewModelForInitialView<V extends ViewModel>({Object parameter});

  /// Creates a viewmodel for the bottom navigation of a specified type.
  /// 
  /// Viewmodel's initialize methods are not called.
  /// 
  /// To call [initialize()] method set the view as a bottomNavigationView. 
  ViewModel createViewModelForBottomNavigation<V extends ViewModel>();

  /// Navigates to a new viewmodel of the specified type.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's initialize methods.
  void navigate<V extends ViewModel>({Object parameter});

  /// Navigates to a new viewmodel of the specified type.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's initialize methods.
  /// 
  /// Awaits for the called viewmodel to close.
  Future<void> navigateAsync<V extends ViewModel>({Object parameter});

  /// Navigates to a new viewmodel of the specified type.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's initialize methods. 
  /// 
  /// It is expected that the viewmodel being navigated to will return an object when it is popped off.
  Future<T> navigateForResultAsync<T extends Object, V extends ViewModel>({Object parameter});

  /// Navigates to a new viewmodel and removes the calling viewmodel from the stack.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's initialize methods.
  /// 
  /// The [animateToBackFirst] will navigate to the previous view before pushing the new one.
  Future<void> navigateAndRemoveCurrentAsync<V extends ViewModel>({Object parameter, bool animateToBackFirst});

  /// Navigates to a new viewmodel and removes all viewmodels on the stack
  /// 
  /// The [parameter] is a value that will be passed to the new viewmodel's initialize methods.
  Future<void> navigateAndRemoveAllAsync<V extends ViewModel>({Object parameter});

  /// Pops the current viewmodel off the stack and goes to the previous one.
  Future<void> navigateBackAsync();

  /// Pops the current viewmodel off the stack and goes to the previous one.
  ///
  /// The [paramter] is the result to send back to the calling viewmodel.
  /// 
  /// This should be used in conjunction with navigateAsyncForResult.
  Future<void> navigateBackWithResultAsync<T extends Object>(T parameter);

  /// Will close all viewmodels async until it finds the viewmodel of a specified type.
  Future<void> navigateBackUntilAsync<V extends ViewModel>();

  /// Navigation method to be used internally, DON'T use this.
  Future<void> navigatingBack({ViewModel closedViewModel});
}
