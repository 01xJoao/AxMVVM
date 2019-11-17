part of axmvvm;

/// Class to be inherited by the App starting class.
abstract class AxApp extends StatelessWidget {
  @mustCallSuper
  AxApp() {
    AxCore();
    registerDependencies(AxCore.container);
  }

  /// Setup the basic app configuration properties.
  AppConfiguration appConfiguraton();

  /// Called by the constructor to register any dependency to be resolved.
  void registerDependencies(AxContainer container);

  /// Set the initial view.
  Widget initialView(INavigationService navigationService);

  /// Create and manage the routes to be used by the navigation service.
  Route<dynamic> routePlanner(RouteSettings settings);

  /// Creates a route for the view.
  CupertinoPageRoute<R> createRoute<R extends Object>(RouteSettings settings, Widget builder, [bool isModal = false]) {
    return CupertinoPageRoute<R>(
      settings: settings,
      fullscreenDialog: isModal,
      builder: (BuildContext context) => builder
    );
  }

  /// Override this method to customize the build.
  /// 
  /// Must call [initializeApp()].
  @override
  Widget build(BuildContext context) => initializeApp();

  Widget initializeApp() {
    final AppConfiguration appConfig = appConfiguraton();
    if(appConfig.localization != null) {
      final LocalizationService l10nService = AxCore.container.getInstance<ILocalizationService>();
      l10nService.initialize(appConfig.localization.pathToJson, appConfig.localization.supportedLocales);
      return FractionallySizedBox(
        widthFactor: 1, 
        heightFactor: 1, 
        child: Container(
          color: appConfig.loadingViewColor,
          child: AxBindWidget<LocalizationService>(
            bindings: <Bind>[
              Bind(Constants.locate, l10nService, LocalizationService.localeProperty),
              Bind(Constants.localizationReady, l10nService, LocalizationService.localizationReadyProperty)
            ],
            builder: (BuildContext context) { 
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: AxCore.container.getInstance<INavigationService>().navigatorKey,
                navigatorObservers: appConfig.navigatorObservers,
                locale: AxBindWidget.ofType<LocalizationService>(context).getValue(Constants.locate),
                title: appConfig.title,
                theme: appConfig.theme,
                darkTheme: appConfig.darkTheme,
                home: AxBindWidget.ofType<LocalizationService>(context).getValue(Constants.localizationReady) 
                  ? initialView(AxCore.container.getInstance<INavigationService>()) 
                  : const SizedBox(),
                onGenerateRoute: routePlanner,
                supportedLocales: appConfig.localization.supportedLocales,
                localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                  l10nService,
                  GlobalMaterialLocalizations.delegate, 
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
                  for (Locale supportedLocale in supportedLocales) {
                    if (supportedLocale == locale)
                      return supportedLocale;
                  }
                  for (Locale supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode 
                      || supportedLocale.countryCode == locale?.countryCode)
                        return supportedLocale;
                  }
                  return appConfig.localization.defaultLocale ??= supportedLocales.first;
                });
              })
            ));
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: AxCore.container.getInstance<INavigationService>().navigatorKey,
        navigatorObservers: appConfig.navigatorObservers,
        title: appConfig.title,
        theme: appConfig.theme,
        darkTheme: appConfig.darkTheme,
        home: initialView(AxCore.container.getInstance<INavigationService>()),
        onGenerateRoute: routePlanner
      );
    }
  }
}