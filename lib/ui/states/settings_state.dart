import 'package:flutter/widgets.dart';
import 'package:w6_homework/data/repositories/settings/app_settings_repository.dart';

import '../../model/settings/app_settings.dart';

class AppSettingsState extends ChangeNotifier {
  AppSettings? _appSettings;

  AppSettingsState(AppSettingsRepository repos) {
    init(repos);
  }

  Future<void> init(AppSettingsRepository repos) async {
    _appSettings = await repos.load();
  }

  ThemeColor get theme => _appSettings?.themeColor ?? ThemeColor.blue;

  Future<void> changeTheme(ThemeColor themeColor) async {
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(themeColor: themeColor);

    notifyListeners();
  }
}
