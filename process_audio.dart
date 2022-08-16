import 'lib.dart';

void main(List<String> arguments) => Future.wait([
      processAudio(
          'ffmpeg -i \'%in\' -map_metadata -1 -fflags +bitexact -flags:a +bitexact -vn -ac 1 -ar 16000 -b:a 80k -metadata artist=BisaCast -metadata \'album=%album\' -metadata \'title=%title\' %nummeta -metadata genre=Podcast \'%out\'',
          'out',
          '.opus'),
      processAudio(
          'ffmpeg -i \'%in\' -map_metadata -1 -fflags +bitexact -flags:a +bitexact -vn -ac 1 -ar 16000 -b:a 96k -metadata artist=BisaCast -metadata \'album=%album\' -metadata \'title=%title\' %nummeta -metadata genre=Podcast \'%out\'',
          'apple',
          '.m4a'),
    ]);
