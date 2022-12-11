import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesModel extends Model {
  static PreferencesModel of(BuildContext context) => ScopedModel.of<PreferencesModel>(context);

  static const biometricRequiredOnBootKey = "_asdgnj123a";

  late bool _biometricRequiredOnBoot = _sharedPreferences.getBool(biometricRequiredOnBootKey) ?? false;
  bool get biometricRequiredOnBoot => _biometricRequiredOnBoot;

  final SharedPreferences _sharedPreferences;

  PreferencesModel(this._sharedPreferences);

  void setBiometricRequired(bool newValue) {
    _biometricRequiredOnBoot = newValue;
    _sharedPreferences.setBool(biometricRequiredOnBootKey, _biometricRequiredOnBoot);
  }

  void forceRefresh() {
    notifyListeners();
  }
}
