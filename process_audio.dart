import 'lib.dart';

void main(List<String> arguments) => Future.wait([
      processAudio(
          'ffmpeg -i \'%in\' -map_metadata -1 -fflags +bitexact -flags:a +bitexact -vn -ac 1 -ar 16000 -c:a libopus -b:a 64k -vbr on -compression_level 10 -frame_duration 60 -application voip %metadata \'%out\'',
          'out/webm-opus',
          '.webm'),
      processAudio(
          'ffmpeg -i \'%in\' -map_metadata -1 -fflags +bitexact -flags:a +bitexact -vn -ac 1 -ar 16000 -c:a libopus -b:a 64k -vbr on -compression_level 10 -frame_duration 60 -application voip %metadata \'%out\'',
          'out/ogg-opus',
          '.opus'),
      processAudio(
          'ffmpeg -i \'%in\' -map_metadata -1 -fflags +bitexact -flags:a +bitexact -vn -ac 1 -ar 16000 -c:a libfdk_aac -vbr 4 %metadata \'%out\'',
          'out/m4a-aac',
          '.m4a'),
    ]);
