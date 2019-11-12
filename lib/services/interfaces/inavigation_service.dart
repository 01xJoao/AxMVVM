part of axmvvm.services;

/// Interface for a navigation service for use by viewmodels.
///
/// An implementation of this class is the basis for viewmodel first navigation.
abstract class INavigationService {
  ///Global key for the app navigation.
  GlobalKey<NavigatorState> get navigator;

  /// Navigates to a new viewmodel of the type specified by the generic.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's init method.
  void navigate<V extends ViewModel>({Object parameter});

  /// Navigates to a new viewmodel of the type specified by the generic.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's init method.
  /// 
  /// Awaits for the new view to close.
  Future<void> navigateAsync<V extends ViewModel>({Object parameter});

  /// Navigates to a new viewmodel of the type specified by the generic.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's init method. 
  /// 
  /// It is expected that the viewmodel being navigated to will return an object when popped off.
  Future<T> navigateForResultAsync<T extends Object, V extends ViewModel>({Object parameter});

  /// Pops the current view / viewmodel off the stack and goes to the previous one.
  Future<void> navigateBackAsync();

  /// Navigation logic method, don't override this.
  Future<void> navigatingBack({ViewModel closedViewModel});

  /// Pops the current view / viewmodel off the stack and goes to the previous one.
  ///
  /// The [paramter] is the result to send back to the calling viewmodel.
  /// 
  /// This should be used in conjunction with navigateAsyncForResult.
  Future<void> navigateBackWithResultAsync<T extends Object>(T parameter);

  /// Will close all views and viewmodels async until it finds the viewmodel type   
  Future<void> navigateBackUntilAsync<V extends ViewModel>();

  /// Navigates to a new viewmodel and removes the calling viewmodel from the stack.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's init method.
  /// 
  /// The [animateToBackFirst] will navigate to the previous view before pushing the new one.
  Future<void> navigateAndRemoveCurrentAsync<V extends ViewModel>({Object parameter, bool animateToBackFirst});

  /// Navigates to a new viewmodel and removes all viewmodels on the stack
  /// 
  /// The [parameter] is a value that will be passed to the new viewmodel's init method.
  Future<void> navigateAndRemoveAllAsync<V extends ViewModel>({Object parameter});

  /// This method is usefule for creating a viewmodel to pass to the application starting view.
  /// 
  /// Viewmodel's method initializeAsync are not called automatically.
  ViewModel createViewModelForInitialView<V extends ViewModel>({Object parameter});

  /// Creates a viewmodel for the bottom navigation of a specified type.
  /// 
  /// Viewmodel's methods initialize and initializeAsync are not called automatically
  /// 
  /// To call initialize(null) method set the view as a bottomnavigationview. 
  ViewModel createViewModelForBottomNavigation<V extends ViewModel>();
}
