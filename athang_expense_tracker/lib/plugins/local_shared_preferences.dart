
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getTokenFromLocalStorage() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = await prefs.getString('_TOKEN');
  return token ?? '';
  // return token != null ? token : '';
}

Future<void> setTokenToLocalStorage(String token) async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('_TOKEN', token);
}

Future<void> setTokenToBlank() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('_TOKEN', '');
}

class LocalStorage {

  Future<SharedPreferences>? futureShared;
  static SharedPreferences? _prefs;

  late SharedPreferences prefs;
  LocalStorage() {
    futureShared = SharedPreferences.getInstance();
    futureShared?.then((SharedPreferences shared) {
      prefs = shared;
    });
  }

  Future<void> setTokenToLocalStorage(String token) async{
    await prefs?.setString('_TOKEN', token);
  }


  Future<void> setTokenToBlank() async{
    await prefs?.setString('_TOKEN', '');
  }
}