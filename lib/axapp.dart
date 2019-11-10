part of axmvvm;

/// Class to use for the main application in an axapp.
abstract class AxApp extends StatelessWidget {
  @mustCallSuper
  AxApp() {
    registerComponents(AxCore.container);
  }

  /// Called by the constructor to register any components to be resolved.
  ///
  /// Used for inversion of control.
  void registerComponents(AxContainer container){}

  /// Set the title of the default app.
  String getTitle();

  /// Set the localization of the app,
  ///
  /// Don't call super if you override this method.
  LocalizationHelper getLocalization() => null;

  /// Set the color of the loading view while Localization Service is setting up
  ///
  /// For a better seamless experience set the same color as the App Launch Screen color
  Color getLoadingViewColor() => Colors.white;

  /// Set the navigation observers of the app 
  ///
  /// Don't call super if you override this method.
  List<NavigatorObserver> getNavigatorObservers() => null;

  /// The theme to use for the app.
  ///
  /// By default it uses a blue colored theme.
  ThemeData getTheme() => ThemeData(primarySwatch: Colors.blue);

  /// The dark theme to use for the app.
  ///
  /// By default it uses a yellow colored theme.
  ThemeData getDarkTheme() => ThemeData(primarySwatch: Colors.yellow);

  /// Set the initial view.
  Widget getInitialView(INavigationService navigationService);

  /// Returns a list of routes for the application.
  Route<dynamic> getRoutes(RouteSettings settings);

  /// Override this method if you want to customize your build.
  /// 
  /// Must call appSetup().
  @override
  Widget build(BuildContext context) {
    return appSetup();
  }

  Widget appSetup() {
    final List<NavigatorObserver> navigatorObserver = getNavigatorObservers();
    if(getLocalization != null) {
      final LocalizationHelper localizationModel = getLocalization();
      final LocalizationService l10nService = AxCore.container.getInstance<LocalizationService>();
      l10nService.initialize(localizationModel.root, localizationModel.supportedLocales);
      return FractionallySizedBox(
        widthFactor: 1, 
        heightFactor: 1, 
        child: Container(
          color: getLoadingViewColor(),
          child: BindingWidget<LocalizationService>(
            bindings: <Bind>[
              Bind(Constants.locate, l10nService, LocalizationService.localeProperty),
              Bind(Constants.localizationReady, l10nService, LocalizationService.localizationReadyProperty)
            ],
            builder: (BuildContext context) { 
              return MaterialApp(
                navigatorObservers: navigatorObserver,
                locale: BindingWidget.ofType<LocalizationService>(context).getValue(Constants.locate),
                title: getTitle(),
                theme: getTheme(),
                darkTheme: getDarkTheme(),
                home: BindingWidget.ofType<LocalizationService>(context).getValue(Constants.localizationReady) 
                  ? getInitialView(AxCore.container.getInstance<INavigationService>()) 
                  : const SizedBox(),
                onGenerateRoute: getRoutes,
                supportedLocales: localizationModel.supportedLocales,
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
                  return localizationModel.defaultLocale ??= supportedLocales.first;
                });
              })
            ));
    } else {
      return MaterialApp(
        navigatorObservers: navigatorObserver,
        title: getTitle(),
        theme: getTheme(),
        darkTheme: getDarkTheme(),
        home: getInitialView(AxCore.container.getInstance<INavigationService>()),
        onGenerateRoute: getRoutes
      );
    }
  }

  /// Creates a route.
  ///
  /// This method is usually called within [getRoutes]
  CupertinoPageRoute<R> buildRoute<R extends Object>(RouteSettings settings, Widget builder, [bool isModal = false]) {
    return CupertinoPageRoute<R>(
      settings: settings,
      fullscreenDialog: isModal,
      builder: (BuildContext context) => builder
    );
  }
}