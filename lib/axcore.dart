part of axmvvm;

/// Core class that instanciates the IoC container and registers basic services.
class AxCore {
  static final AxContainer _container = AxContainer();
  
  AxCore() {
    _container.registerSingleton<INavigationService>(NavigationService());
    _container.registerSingleton<IMessageService>(MessageService());
    _container.registerSingleton<ILocalizationService>(LocalizationService());
  }

  /// A global reference to the registered object for dependency injection/IoC.
  static AxContainer get container => _container;
}