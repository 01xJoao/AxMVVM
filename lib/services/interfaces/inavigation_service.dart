part of axmvvm.services;

/// Interface for a navigation service for use by viewmodels.
///
/// An implementation of this class is the basis for viewmodel first navigation.
abstract class INavigationService {
  /// Any initiliazation needed to be done by the messenger service.
  ///
  /// This is called once when axmvvm is initialized.
  void initialize();

  /// Navigates to a new viewmodel of the type specified by the generic.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's init method. 
  Future<void> navigateAsync<V extends ViewModel>({Object parameter});

  /// Navigates to a new viewmodel of the type specified by the generic.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's init method. 
  /// 
  /// It is expected that the viewmodel being navigated to will return an object when popped off.
  Future<O> navigateForResultAsync<O extends Object, V extends ViewModel>({Object parameter});

  /// Pops the current view / viewmodel off the stack and goes to the previous one.
  Future<void> navigateBackAsync();

  /// Pops the current view / viewmodel off the stack and goes to the previous one.
  ///
  /// The [paramter] is the result to send back to the calling viewmodel.
  /// 
  /// This should be used in conjunction with navigateAsyncForResult.
  Future<void> navigateBackWithResultAsync<O extends Object>({O parameter});

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

  /// Creates a view model of a specified type.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's init method.
  /// 
  /// This method is usefule for creating a viewmodel to pass to the application starting view.
  ViewModel createViewModelForInitialView<T extends ViewModel>();

  /// Creates a viewmodel for the bottom navigation of a specified type.
  /// 
  /// The [parameter] is a value that will be passed to the new viewmodel's init method.
  /// 
  /// This won't call viewmodel's methods initialize or initializeAsync.
  ViewModel createViewModelForBottomNavigation<T extends ViewModel>({Object parameter});
}
