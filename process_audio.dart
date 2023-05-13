import 'lib.dart';

void main(List<String> arguments) {
  getAllCommands(
          'ffmpeg -i \'%in\' -map_metadata -1 -fflags +bitexact -flags:a +bitexact -vn -ac 1 -ar 16000 -c:a libopus -b:a 64k -vbr on -compression_level 10 -frame_duration 60 -application voip %metadata \'%out\'',
          'out/webm-opus',
          '.webm')
      .forEach(print);
  getAllCommands(
          'ffmpeg -i \'%in\' -map_metadata -1 -fflags +bitexact -flags:a +bitexact -vn -ac 1 -ar 16000 -c:a libopus -b:a 64k -vbr on -compression_level 10 -frame_duration 60 -application voip %metadata \'%out\'',
          'out/ogg-opus',
          '.opus')
      .forEach(print);
  getAllCommands(
          'ffmpeg -i \'%in\' -map_metadata -1 -fflags +bitexact -flags:a +bitexact -vn -ac 1 -ar 16000 -c:a libfdk_aac -vbr 4 %metadata \'%out\'',
          'out/m4a-aac',
          '.m4a')
      .forEach(print);
  print(
      '\n\n\n\n\n# if you\'re reading this, you probably forgot to pipe to a command runner like sh(1) or xe(1)');
}
