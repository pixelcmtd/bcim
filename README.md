# bcim

bcim is a project trying to cultivate and improve the BisaCast.

## Usage

- Make sure you have Dart and an FFmpeg with libfdk-aac support installed
  (`brew install homebrew-ffmpeg/ffmpeg/ffmpeg --with-fdk-aac` on macOS)
- `dart pub get`
- `dart run download.dart | xe -vj3 sh -c` to download all episodes into the `raw` directory.
- `dart run process_audio.dart | xe -vj0 sh -c` to convert all audio episodes into WebM Opus
  (`out/webm-opus`), Ogg Opus (`out/ogg-opus`) and M4A AAC (`out/m4a-aac`).
