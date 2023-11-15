import 'package:quotes/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> firstRun() async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstRun = prefs.getString(Constants.cachedUserData);
  return isFirstRun == null;
}
