import 'dart:async';
import 'dart:convert';

import '../model.dart';
import 'package:http/http.dart' as http;

class TrackDetailsBloc {
  final _stateStreamController = StreamController<Track>();
  StreamSink<Track> get _trackdetailsSink => _stateStreamController.sink;
  Stream<Track> get trackdetailsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<int>();
  StreamSink<int> get eventSink => _eventStreamController.sink;
  Stream<int> get _eventStream => _eventStreamController.stream;

  TrackDetailsBloc() {
    _eventStream.listen((id) async {
      try {
        var track = await getTrack(id);
        _trackdetailsSink.add(track);
      } on Exception catch (e) {
        _trackdetailsSink.addError("Internal Error");
      }
    });
  }
  Future<Track> getTrack(id) async {
    var client = http.Client();
    var track;
    var url = Uri.https("api.musixmatch.com", "/ws/1.1/track.get", {
      "apikey": "456f2e2d26b236e4edb341f76b2a9503",
      "track_id": id.toString()
    });

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsondata = json.decode(jsonString);
        print(1233);
        track = Track.fromJson(jsondata["message"]["body"]);
      }
    } on Exception {
      return track;
    }

    return track;
  }

  void dispose() {
    _eventStreamController.close();
    _stateStreamController.close();
  }
}
