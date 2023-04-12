import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../models/User.dart';

part 'appData.g.dart';

class AppData = _AppData with _$AppData;

abstract class _AppData with Store {
  @observable
  bool isDark = false;

    @observable
  UserData? user;

  @observable
  ThemeMode mode = ThemeMode.light;

  @action
  void toggle() {
    if (isDark) {
      isDark = false;
      mode = ThemeMode.light;
    } else {
      isDark = true;
      mode = ThemeMode.dark;
    }
  }

  @action
  void setUser(UserData userData) {
    user = userData;
  }
}
