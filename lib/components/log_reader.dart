import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

LogReader log = new LogReader();



class LogReader {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

//  Future<File> writer(log) async {
//    final path = await _localPath;
//    // declare variable with file path
//
//    // declare variable with File instance
//    final file = File("$path/log.txt");
//    // Return
//    return file.writeAsString('$log\n', mode: FileMode.append);
//  }

    Future<File> writer(log) async {
    final path = await _localPath;
    // declare variable with file path

    // declare variable with File instance
    final file = File("$path/log.json");
    // Return
    return file.writeAsString('{"name": "Chris"},\n', mode: FileMode.append);
  }

//   writer(log) {
//
//    final file = File('../../assets/load_json/test.json');
//    return file.writeAsString('{"name": "Chris"}');
//  }

  clearLog() async {
    final path = await _localPath;
    final file = File("$path/log.json");

    file.writeAsString('');
  }

  Future<int> reader() async {
    final path = await _localPath;
    final file = File('$path/log.json');
    var inputStream = file.openRead();

    inputStream.transform(utf8.decoder).transform(LineSplitter()).listen(
            (String line) {
          // Process results.
          var parsedJson = jsonDecode(line);
          print(parsedJson);

        }, onDone: () {
      print('File is now closed.');
    }, onError: (e) {
      print(e.toString());
    });
    return 0;
  }

}