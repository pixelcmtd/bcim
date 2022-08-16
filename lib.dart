import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

final casts = loadYaml(File('casts.yaml').readAsStringSync());
File file(Directory dir, cast, [String? ext]) => File((cast.containsKey('num')
        ? '${dir.path}/${cast['num'].toString().padLeft(2, '0')} ${cast['title']}'
        : '${dir.path}/${cast['title']}') +
    (ext ?? (cast['download'].endsWith('.m4a') ? '.m4a' : '.mp3')));

Future processAudio(String cmd, String outname, [String ext = '.opus']) =>
    Future.wait(casts.map<Future>((cat) {
      final indir = Directory('raw/${cat['name']}');
      return Directory('$outname/${cat['name']}')
          .create(recursive: true)
          .then((outdir) async {
        for (final f in cat['casts']
            .where((cast) =>
                !cast.containsKey('youtube') &&
                !file(outdir, cast, ext).existsSync())
            .map((cast) =>
                // TODO: use list
                cmd
                    .replaceAll('%in', file(indir, cast).path)
                    .replaceAll('%album', cat['name'])
                    .replaceAll('%title', cast['title'])
                    .replaceAll(
                        '%nummeta',
                        cast['num'] != null
                            ? '-metadata \'track=${cast['num']}\''
                            : '')
                    .replaceAll('%out', file(outdir, cast, ext).path))
            .map<Future<Process>>((cmd) {
          print(cmd);
          return Process.start('sh', ['-c', cmd]);
        })) {
          final p = await f;
          final ec = await p.exitCode;
          p.stderr.transform(utf8.decoder).forEach(print);
          p.stdout.transform(utf8.decoder).forEach(print);
          if (ec != 0) return;
        }
      });
    }));
