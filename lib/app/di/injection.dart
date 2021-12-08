import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/app/database/database.dart';
import 'package:todo_list/domain/entity/task_entity.dart';
import 'package:todo_list/domain/gateway/task_gateway.dart';
import 'package:todo_list/gateway/storage/task_dao.dart';

GetIt injection = GetIt.I;

Future setInjections() async {
  /// dio
  Dio dio = Dio();
  dio.options.headers.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json');
  // dio.options.baseUrl = ApiConstants.baseUrl;
  // dio.options.connectTimeout = AppConst.timeoutDurationInMilliseconds;
  // dio.options.receiveTimeout = AppConst.timeoutDurationInMilliseconds;
  // dio.interceptors.add(AppConst.alice.getDioInterceptor());
  injection.registerLazySingleton<Dio>(() => dio);

  final Database database = await initBase();

  injection.registerLazySingleton<Database>(() => database);
  injection.registerLazySingleton<TaskGateway<TaskEntity>>(() => TaskDao(database: database));
}
