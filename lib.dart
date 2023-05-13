import 'dart:io';

import 'package:yaml/yaml.dart';

final casts = loadYaml(File('casts.yaml').readAsStringSync());
File file(Directory dir, cast, [String? ext]) => File((cast.containsKey('num')
        ? '${dir.path}/${cast['num'].toString().padLeft(2, '0')} ${cast['title']}'
        : '${dir.path}/${cast['title']}') +
    (ext ?? ('.${cast['download'].split('.').last}')));

Iterable<
    String> _getCommands(cat, String cmd, String outname, String ext) => cat[
        'casts']
    .where((cast) => !cast.containsKey('youtube'))
    .map((cast) => cmd
        .replaceAll('%in', file(Directory('raw/${cat['name']}'), cast).path)
        .replaceAll(
            '%out', file(Directory('$outname/${cat['name']}'), cast, ext).path)
        .replaceAll(
            '%metadata',
            '-metadata artist=BisaCast '
                '-metadata \'album=${cat['name']}\' '
                '-metadata \'title=${cast['title']}\' '
                '${cast['num'] != null ? '-metadata \'track=${cast['num']}\' ' : ''}'
                '-metadata genre=Podcast -n -hide_banner'))
    .map<String>((cmd) => 'mkdir -p \'$outname/${cat['name']}\' && $cmd');

Iterable<String> getAllCommands(String cmd, String outname, String ext) => casts
    .map<Iterable<String>>((cat) => _getCommands(cat, cmd, outname, ext))
    .reduce((Iterable<String> a, Iterable<String> b) => [...a, ...b]);
