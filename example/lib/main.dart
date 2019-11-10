import 'package:flutter/material.dart';

import 'package:axmvvm/axmvvm.dart';
import 'package:axmvvm/services/services.dart';
import 'package:axmvvm/bindings/bindings.dart';

void main() => runApp(MyApp());

class MyApp extends AxApp {
  @override
  void registerDependencies(AxContainer container) {
    container.registerTransient<MainViewModel>(() => MainViewModel());
  }

  @override
  String getTitle() => 'AxMVVM';

  @override
  Widget getInitialView(INavigationService navigationService) {
    return MainView(navigationService.createViewModelForInitialView<MainViewModel>());
  }

  @override
  Route<dynamic> getRoutes(RouteSettings settings) {
    return null;
  }
}

class MainView extends AxStatelessView<MainViewModel> {
  MainView(ViewModel viewModel) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AxMVVM'),
        ),
        body: Center(
          child: const Text('Hello!'),
        ),
      ),
    );
  }
}

class MainViewModel extends ViewModel {

}
