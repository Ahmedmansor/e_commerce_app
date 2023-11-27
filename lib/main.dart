import 'package:e_commerce_app/repos/const.dart';
import 'package:e_commerce_app/repos/dio_helper.dart';
import 'package:e_commerce_app/repos/shared_pref_helper.dart';
import 'package:e_commerce_app/root/app_root.dart';
import 'package:flutter/material.dart';

import 'utils/app_setting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppSettings.init;
  await DioHelper.init();
  await CachMemory.cachMemoryInit();
  token = CachMemory.getFromCachMemory(key: 'token');
  runApp(const AppRoot());
}
