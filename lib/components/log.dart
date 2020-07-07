import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Log {

  // Retrieve logs file.
  Future<File> _getLogFile() async  {
    final directory = await getApplicationDocumentsDirectory();
    var path = directory.path;
    return File('$path/logs.txt');

  }

  // Return log list as parsed JSON object
  Future<List> getLogsFromFile() async {
    final file = await _getLogFile();
    print(file);
    print("from getlogsfromfile");
    if (file.existsSync()) {
      final logList = json.decode(file.readAsStringSync());
      return logList;
    }


  }

  // Write / append new object to logs.json
  // ignore: missing_return
  Future<List> writeLogsToFile(newLog) async {

      final file = await _getLogFile();
      final logsList = await getLogsFromFile();

      print(file);
      logsList.add(newLog);

      final encodedJsonList = json.encode(logsList); // covert to json string

      print("from write log after encoded");
      file.writeAsStringSync(encodedJsonList);
      return logsList;


  }

  // Clear / overwrite log files, replace with empty array
  void clearLogs() async {
    final file = await  _getLogFile();
    file.writeAsStringSync('[]');
  }
}