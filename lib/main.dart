import 'package:cafe_manager_app/common/blocs/supervisor_bloc.dart';
import 'package:cafe_manager_app/common/injector/injector.dart';
import 'package:cafe_manager_app/features/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:flutter_translate/localized_app.dart';

Future<void> main() async{
  //init kiwi
  Injector.setup();
  Bloc.observer = SupervisorBloc();

  // set up multiple languages
  final delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['vi', 'en'],
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(LocalizedApp(delegate, App()));
}
