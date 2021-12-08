import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/app/app_widget.dart';
import 'package:todo_list/app/di/injection.dart';
import 'package:todo_list/app/ui/tasks/bloc/task_bloc.dart';

import 'app/ui/navigation/photo_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setInjections();

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, trace) {
    log('error: $error\ntrace:$trace', name: 'Error in main isolate');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO List',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: BlocProvider(create: (context) => TaskBloc(taskGateway: injection()), child: const NavigationScreen()),
    );
  }
}
