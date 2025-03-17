/*import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Instancia singleton de SharedPreferencesHelper
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._internal();
  factory SharedPreferencesHelper() => _instance;
  SharedPreferencesHelper._internal();

  static SharedPreferences? _prefs;

  // Inicializa SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Guardar un valor String
  Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Obtener un valor String
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Guardar un valor int
  Future<void> saveInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  // Obtener un valor int
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  // Guardar un valor bool
  Future<void> saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  // Obtener un valor bool
  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Guardar un valor double
  Future<void> saveDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  // Obtener un valor double
  double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  // Eliminar un valor
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Borrar todos los datos
  Future<void> clear() async {
    await _prefs?.clear();
  }
}*/