part of axmvvm;

/// Main class for AxMVVM framework
class AxCore {
  static final Container _container = Container();
  
  AxCore() {
    _container.registerSingleton<INavigationService>(NavigationService());
    _container.registerSingleton<IMessageService>(MessageService());
    _container.registerSingleton<ILocalizationService>(LocalizationService());

    _container.getInstance<INavigationService>().initialize();
  }

  /// A global reference to the registered object for dependency injection/IoC.
  static Container get container => _container;
}