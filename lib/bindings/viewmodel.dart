part of axmvvm.bindings;

/// Base object to be used to create ViewModels.
/// 
/// Comes with navigation service and localization service.
/// 
/// Also with isBusyProperty and some methods to help with viewmodel logic.
abstract class ViewModel extends BindableBase {
  static INavigationService _navigationService;
  @protected
  static INavigationService navigationService = _navigationService ?? (_navigationService = AxCore.container.getInstance<INavigationService>());

  static ILocalizationService _localizationService;
  @protected
  static ILocalizationService localizationService = _localizationService ?? (_localizationService = AxCore.container.getInstance<ILocalizationService>());

  /// State of the view model
  static PropertyInfo isBusyProperty = PropertyInfo('IsBusy', bool, false);

  @protected
  bool get isBusy => getValue(isBusyProperty);

  @protected
  set isBusy(bool value) => setValue(isBusyProperty, value);

  /// Called after the constructer to initialize the viewmodel.
  ///
  /// Any information passed to be viewmodel is set via the [parameter].
  void initialize(Object parameter) {}
  
  /// Called asynchronously after the constructer to initialize the viewmodel.
  ///
  /// Any information passed to be viewmodel is set via the [parameter].
  /// 
  /// BottomNavigationViews don't have access to this method.
  Future<void> initializeAsync(Object parameter) async {}

  /// Called after view is ready, only available on stateful views
  void appeared() {}

  /// Called before the viewmodel is disposed.
  void closing() {}

  /// Called asynchronously before the viewmodel is disposed.
  Future<void> closingAsync() async {}

  /// Called to close the view
  Future<void> close() async {
    await _navigationService.navigateBackAsync();
  }
}
