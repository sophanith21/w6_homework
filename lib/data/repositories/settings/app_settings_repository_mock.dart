import 'package:w6_homework/data/repositories/settings/app_settings_repository.dart';
import 'package:w6_homework/model/settings/app_settings.dart';

class AppSettingsRepositoryMock implements AppSettingsRepository {
  AppSettings appSettings = AppSettings(themeColor: ThemeColor.blue);
  @override
  Future<AppSettings> load() async {
    return appSettings;
  }

  @override
  Future<void> save(AppSettings settings) async {
    appSettings = settings;
  }
}
