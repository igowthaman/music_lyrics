import 'dart:async';
import 'dart:convert';

import '../model.dart';
import 'package:http/http.dart' as http;

enum TrackAction { Fetch }

class TrackListBloc {
  final _stateStreamController = StreamController<List<Track>>();
  StreamSink<List<Track>> get _tracklistSink => _stateStreamController.sink;
  Stream<List<Track>> get tracklistStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<TrackAction>();
  StreamSink<TrackAction> get eventSink => _eventStreamController.sink;
  Stream<TrackAction> get _eventStream => _eventStreamController.stream;

  TrackListBloc() {
    _eventStream.listen((event) async {
      if (event == TrackAction.Fetch) {
        try {
          var tracks = await getTracks();
          _tracklistSink.add(tracks.track);
        } on Exception catch (e) {
          _tracklistSink.addError("Internal Error");
        }
      }
    });
  }
  Future<TrackList> getTracks() async {
    var client = http.Client();
    var trackList;
    var url = Uri.https("api.musixmatch.com", "/ws/1.1/chart.tracks.get",
        {"apikey": "456f2e2d26b236e4edb341f76b2a9503"});

    try {
      var response = await client.get(url);
      print(response);
      print("\n\n\n\n\n123456789\n\n\n\n\n\n\n\n");
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        trackList = TrackList.fromJson(jsonMap);
      }
    } on Exception {
      return trackList;
    }

    return trackList;
  }

  void dispose() {
    _eventStreamController.close();
    _stateStreamController.close();
  }
}
