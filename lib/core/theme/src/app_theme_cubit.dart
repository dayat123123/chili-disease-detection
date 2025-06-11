part of '../theme.dart';

class AppThemeCubit extends Cubit<AppThemeModel> {
  bool _isDarkTheme;
  static final bool _defaultChoiceDarkMode = false;
  static final AppThemeModel _defaultThemeChoice = lightAppThemeModel;
  static final String _key = LocalStorageKeys.isDarkMode;
  final LocalStorage _localStorage;

  AppThemeCubit(this._localStorage)
    : _isDarkTheme = _defaultChoiceDarkMode,
      super(_defaultThemeChoice) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      _isDarkTheme =
          await _localStorage.getData(_key) ?? _defaultChoiceDarkMode;
      _emitCurrentTheme();
    } catch (e) {
      print("Error load theme: ${e.toString()}");
      _emitCurrentTheme();
    }
  }

  Future<void> switchTheme() async {
    try {
      _isDarkTheme = !_isDarkTheme;
      await _localStorage.setData(_key, _isDarkTheme);
      _emitCurrentTheme();
    } catch (e) {
      print("Error switch theme: ${e.toString()}");
      _emitCurrentTheme();
    }
  }

  void _emitCurrentTheme() {
    emit(_isDarkTheme ? darkAppThemeModel : lightAppThemeModel);
  }

  bool get isDarkMode => _isDarkTheme;
  String get currentTheme => state.label;
}
