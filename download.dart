import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:http/http.dart';

void main(List<String> arguments) async {
  final casts = loadYaml(File('casts.yaml').readAsStringSync());
  for (final cat in casts) {
    for (final cast in cat['casts']) {
      //
    }
  }
}
