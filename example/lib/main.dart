import 'package:flutter/material.dart';

import 'package:axmvvm/axmvvm.dart';
import 'package:axmvvm/services/services.dart';
import 'package:axmvvm/bindings/bindings.dart';

void main() => runApp(MyApp());

class MyApp extends AxApp {
  @override
  void registerDependencies(AxContainer container) {
    container.registerSingleton<IWebLoginService>(WebLoginService());
    container.registerTransient<MainViewModel>(() => MainViewModel(container.getInstance<IWebLoginService>()));
    container.registerTransient<TestViewModel>(() => TestViewModel(container.getInstance<IWebLoginService>()));
  }

  @override
  String getTitle() => 'AxMVVM';

  @override
  Widget getInitialView(INavigationService navigationService) {
    return MainView(navigationService.createViewModelForInitialView<MainViewModel>());
  }

  @override
  Route<dynamic> getRoutes(RouteSettings settings) {
    return buildRoute(settings, TestView(settings.arguments));
  }
}

class MainView extends AxStatelessView<MainViewModel> {
  MainView(ViewModel viewModel) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AxMVVM'),
      ),
      body: viewNavigatesBack(view: InkWell(
        onTap: () => viewModel.loginCommand.execute(param: 'AxMVVM'),
        child: const Text('Hello!'),
      ))
    );
  }
}

class MainViewModel extends ViewModel {
  final IWebLoginService _loginService;
  MainViewModel(this._loginService);

  AxCommand<String> _loginCommand;

  AxCommand<String> get loginCommand => _loginCommand ??= AxCommand<String>(
    actionParam: ({String param}) => verifyLogin(param), canExecute: checkLoading);

  void verifyLogin(String name){
    _loginService.login(name);
    ViewModel.navigationService.navigateAsync<TestViewModel>();
  }

  bool checkLoading() => !isBusy;
}

class TestView extends AxStatefulView<TestViewModel> {
  TestView(ViewModel viewModel) : super(viewModel);

  @override
  State<StatefulWidget> createState() => TestViewState(viewModel);

}

class TestViewState extends AxStateView<TestView, TestViewModel> {
  TestViewState(ViewModel viewModel) : super(viewModel);
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AxMVVM'),
      ),
      body: viewNavigatesBack(
        view: InkWell(
          onTap: () => viewModel.loginCommand.execute(param: 'AxMVVM'),
          child: const Text('Hello 1!'),
      ))
    );
  }
}

class TestViewModel extends ViewModel {
  final IWebLoginService _loginService;
  TestViewModel(this._loginService);

  AxCommand<String> _loginCommand;
  AxCommand<String> get loginCommand => _loginCommand ??= AxCommand<String>(
    actionParam: ({String param}) => verifyLogin(param), canExecute: checkLoading);

  void verifyLogin(String name){
    _loginService.login(name);
    ViewModel.navigationService.navigateAsync<TestViewModel>();
  }

  bool checkLoading() => !isBusy;
}

abstract class IWebLoginService {
  void login(String name);
}

class WebLoginService implements IWebLoginService{
  @override
  void login(String name) {
   print(name);
  }
}