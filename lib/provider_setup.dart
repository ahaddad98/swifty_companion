import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderSetup {
  static void setup() {
    Provider.debugCheckInvalidValueType = null;
    Provider.value(value: CounterProvider());
    // your providers here
  }
}

class CounterProvider {
  bool _count = false;

  bool get count => _count;

  void increment() {
    _count = !_count;
  }

}