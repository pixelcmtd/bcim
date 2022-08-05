import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:http/http.dart';

void main(List<String> arguments) async {
  final casts = loadYaml(File('casts.yaml').readAsStringSync());
  for (final cat in casts) {
    await Directory('raw/${cat['name']}')
        .create(recursive: true)
        .then((dir) async {
      for (final cast in cat['casts']) {
        if(cast.containsKey('youtube')) {
        print('Downloading "${cast['title']}" using yt-dlp');
          print(await Process.run('sh', ['-c', 'cd ${dir.path} && yt-dlp -f bv+ba youtu.be/${cast['youtube']}']).then((p) => p.stdout));
        } else {
        final f = File((cast.containsKey('num') ? '${dir.path}/${cast['num'].toString().padLeft(2, '0')} ${cast['title']}' : '${dir.path}/${cast['title']}') + (cast['download'].endsWith('.m4a') ? '.m4a' : '.mp3'));
        if (f.existsSync()) continue;
        print('Downloading "${cast['title']}" to "${f.path}"');
        await get(Uri.parse(cast['download'])).then((x) => f.writeAsBytes(x.bodyBytes));
        }
      }
    });
  }
}
