import 'dart:convert';
import 'dart:io' as io;
import "dart:math";
import 'package:path/path.dart' as path;

const fileName = "trello_ids.json";
const domain = "https://api.trello.com/1";

void main() async {
  final content = await io.File(
          "${path.absolute(io.Platform.environment['HOME']!)}/$fileName")
      .readAsString();
  final cred = json.decode(content);
  final url =
      "$domain/lists/${cred['list_id']}/cards?key=${cred['key']}&token=${cred['token']}&fields=name";

  final client = io.HttpClient();
  final request = await client.getUrl(Uri.parse(url));
  final response = await request.close();
  final contentAsString = await utf8.decodeStream(response);
  final map = json.decode(contentAsString);
  client.close();
  final _random = new Random();
  var element = map[_random.nextInt(map.length)];
  print(element);
}
