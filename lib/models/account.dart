import 'dart:convert';
import 'package:http/http.dart' as http;

class Account {
  String user, pass, fullName, type, message;

  Account({this.user, this.pass, this.fullName, this.type, this.message});

  factory Account.createAccount(Map<String, dynamic> obj) {
    return Account(
      user: obj['username'],
      pass: obj['password'],
      fullName: obj['fullname'],
      type: obj['type'],
      message: obj['message'],
    );
  }

  static Future<Account> getAccount(user, pass) async {
    String apiURL = 'http://192.168.73.105/spp/accounts.php?';
    var apiResult = await http.post(apiURL, body: {
      'user': user,
      'pass': pass,
    });
    var jsonObj = json.decode(apiResult.body);
    return Account.createAccount(jsonObj);
  }
}
