import 'dart:developer';

import 'package:linkedin_clone/parameters.dart';

void printLogs(message) {
  if (isDev) {
  log(message.toString());
  }
}
