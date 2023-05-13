import 'dart:io';
import 'lib.dart';

void main(List<String> arguments) async {
  for (final cat in casts) {
    final dir = Directory('raw/${cat['name']}');
    for (final cast in cat['casts']) {
      if (cast.containsKey('youtube')) {
        print(
            'mkdir -p \'${dir.path}\' && cd \'${dir.path}\' && yt-dlp -f bv+ba youtu.be/${cast['youtube']}');
      } else {
        final f = file(dir, cast);
        if (!f.existsSync())
          print(
              'mkdir -p \'${dir.path}\' && curl -Lo \'${f.path}\' \'${cast['download']}\'');
      }
    }
  }
}
