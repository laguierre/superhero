import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> getHeroes() async {
  var url = 'https://akabab.github.io/superhero-api/api/all.json';
  var res = await http.get(Uri.parse(url));
  List decodedJson = jsonDecode(res.body);
  List superHeroList = [];
  int code = res.statusCode;
  if (code == 200) {
    superHeroList = decodedJson;
  } else {
    print("Something went wrong");
  }
  return superHeroList;
}
