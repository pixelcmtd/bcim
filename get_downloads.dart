// usage: dart run get_downloads.dart | stdbuf -o0 -i0 uniq | tee monkaẞ
import 'dart:io';

import 'package:html_search/html_search.dart';
import 'package:yaml/yaml.dart';
import 'package:schttp/schttp.dart';

void main(List<String> arguments) async {
  final casts = loadYaml(File('casts.yaml').readAsStringSync());
  for (final cat in casts) {
    for (final cast in cat['casts']) {
      if (!cast.containsKey('download') && !cast.containsKey('youtube')) {
        print(cast['site']);
        parse(await ScHttpClient().get(cast['site']))
            .map((e) =>
                e.getElementsByTagName('a').map((e) => e.attributes['href']))
            .reduce((x, y) => [...x, ...y])
            .where((x) => x != null)
            .map<String>((x) => x!)
            .where((x) =>
                (x.contains('bisacast') &&
                    x.contains('mp3') &&
                    !x.contains('#comment')) ||
                x.contains('youtube'))
            .map((x) =>
                (x.contains('youtube')
                    ? '      youtube: '
                    : '      download: ') +
                x)
            .forEach(print);
      }
    }
  }
}