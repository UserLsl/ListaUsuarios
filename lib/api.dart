import 'package:http/http.dart' as http;

const baseURL = "https://jsonplaceholder.typicode.com";

class API {
  static Future getUsers() async {
    var url = Uri.parse("$baseURL/users");
    return await http.get(url);
  }
}