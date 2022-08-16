// usage: dart run get_downloads.dart | stdbuf -o0 -i0 uniq | tee monkaẞ
import 'lib.dart';
import 'package:html_search/html_search.dart';
import 'package:http/http.dart';
import 'package:where_not_null/where_not_null.dart';

void main(List<String> arguments) async {
  for (final cat in casts) {
    for (final cast in cat['casts']) {
      if (!cast.containsKey('download') && !cast.containsKey('youtube')) {
        print(cast['site']);
        htmlParse((await get(Uri.parse(cast['site']))).body)
            .map((e) =>
                e.getElementsByTagName('a').map((e) => e.attributes['href']))
            .reduce((x, y) => [...x, ...y])
            .whereNotNull()
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
