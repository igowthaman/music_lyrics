import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class TrackLyricsBloc {
  final _stateStreamController = StreamController<String>();
  StreamSink<String> get _trackLyricsSink => _stateStreamController.sink;
  Stream<String> get trackLyricsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<int>();
  StreamSink<int> get eventSink => _eventStreamController.sink;
  Stream<int> get _eventStream => _eventStreamController.stream;

  TrackLyricsBloc() {
    _eventStream.listen((id) async {
      try {
        var lyrics = await getLyrics(id);
        _trackLyricsSink.add(lyrics);
      } on Exception catch (e) {
        _trackLyricsSink.addError("Internal Error");
      }
    });
  }
  Future<String> getLyrics(id) async {
    var client = http.Client();
    var lyrics;
    var url = Uri.https("api.musixmatch.com", "/ws/1.1/track.lyrics.get", {
      "apikey": "456f2e2d26b236e4edb341f76b2a9503",
      "track_id": id.toString()
    });

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsondata = json.decode(jsonString);
        print(1233);
        lyrics = jsondata["message"]["body"]["lyrics"]["lyrics_body"];
      }
    } on Exception {
      return lyrics;
    }

    return lyrics;
  }

  void dispose() {
    _eventStreamController.close();
    _stateStreamController.close();
  }
}
