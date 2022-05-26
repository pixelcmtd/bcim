import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:schttp/schttp.dart';

void main(List<String> arguments) async {
  final casts = loadYaml(File('casts.yaml').readAsStringSync());
  final http = ScHttpClient();
  for (final cat in casts) {
    for (final cast in cat['casts']) {
      //
    }
  }
}
