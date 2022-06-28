import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:qoutes/app.dart';
import 'package:qoutes/bloc_observer.dart';
import 'package:qoutes/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(
    () => runApp(const QouteApp()),
    blocObserver: QouteBlocObserver(),
  );
}
