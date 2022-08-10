import 'dart:io';

import 'package:yaml/yaml.dart';

final casts = loadYaml(File('casts.yaml').readAsStringSync());
File file(Directory dir, cast, [String? ext]) => File((cast.containsKey('num')
        ? '${dir.path}/${cast['num'].toString().padLeft(2, '0')} ${cast['title']}'
        : '${dir.path}/${cast['title']}') +
    (ext ?? (cast['download'].endsWith('.m4a') ? '.m4a' : '.mp3')));
