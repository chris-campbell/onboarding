import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LogReader {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> writer(log) async {
    final path = await _localPath;
    // declare variable with file path

    // declare variable with File instance
    final file = File("$path/log.txt");
    // Return
    return file.writeAsString('$log\n', mode: FileMode.append);
  }

  Future<int> reader() async {
    final path = await _localPath;
    final file = File('$path/log.txt');
    var inputStream = file.openRead();

    inputStream.transform(utf8.decoder).transform(LineSplitter()).listen(
            (String line) {
          // Process results.
          print('$line: ${line.length} bytes');

        }, onDone: () {
      print('File is now closed.');
    }, onError: (e) {
      print(e.toString());
    });
    return 0;
  }

}