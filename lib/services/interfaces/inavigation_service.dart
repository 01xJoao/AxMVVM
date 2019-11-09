part of axmvvm.services;

/// Interface for a navigation service for use by view models.
///
/// Since a view model should no nothing about the presentation layer, no context is used here.
/// An implementation of this class is the basis for viewmodel to viewmodel navigation.
abstract class INavigationService {
  /// Navigates to a new viewmodel of the type specified by the generic.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's
  /// init method. The Future will be resolved with the ViewModel that is navigated to is
  /// popped from the stack.
  Future<void> navigate<V extends ViewModel>({Object parameter});

  /// Navigates to a new viewmodel of the type specified by the generic.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's
  /// init method. It is expexted that the ViewModel being navigated to will
  /// return an instance of type R when it is popped off the stack.
  Future<R> navigateForResult<R extends Object, V extends ViewModel>(
      {Object parameter});

  /// Pops the current view / viewmodel off the stack and goes to the previous one.
  Future<void> navigateBack();

  /// Pops the current view / viewmodel off the stack and goes to the previous one.
  ///
  /// The [paramter] is the result to send back to the calling view model.
  /// This should be used in conjunction with navigateForResult.
  Future<void> navigateBackWithResult<O extends Object>({O parameter});

  /// Will close all views and view models until it finds the view model type   
  void navigateBackUntil<V extends ViewModel>();

  /// Navigates to a new view modeland removed the calling viewmodel from the stack.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's
  /// init method. The Future will be resolved with the ViewModel that is navigated to is
  /// popped from the stack.
  Future<void> navigateAndRemoveCurrent<V extends ViewModel>({Object parameter, bool animateToBackFirst});

  Future<void> navigateAndRemoveAll<V extends ViewModel>({Object parameter});

  /// Creates a view model of a specified type.
  ///
  /// The [parameter] is a value that will be passed to the new viewmodel's
  /// init method.
  /// This method is usefule for creating a view model to pass to an apps
  /// starting widget.
  ViewModel createViewModelForInitialView<T extends ViewModel>();

  /// Creates a view model of a specified type.
  ViewModel createViewModelForBottomNavigationView<T extends ViewModel>({Object parameter});

  /// Any initiliazation needed to be done by the messenger service.
  ///
  /// This is called once when fmvvm is initialized. fmvvm uses a single
  /// instance of the navigaiton service throughout the app.
  void initialize();
}
