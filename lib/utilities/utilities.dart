library axmvvm.utilities;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:axmvvm/bindings/bindings.dart';

part 'location.dart';

class Utilities {
  /// Returns a type object for a generic.
  static Type typeOf<T>() => T;

  /// Returns a string view name based on a viewmodel type.
  String getViewFromViewModelType<T extends ViewModel>() {
    final String typeName = Utilities.typeOf<T>().toString();
    return typeName.replaceAll('ViewModel', 'View');
  }
}

enum Lifestyle { transientRegistration, singletonRegistration }
