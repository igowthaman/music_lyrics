import 'package:flutter/material.dart';

import '../bloc/TrackLyricsBloc.dart';
import '../bloc/TrackDetailsBloc.dart';
import '../model.dart';

class TrackPage extends StatefulWidget {
  TrackPage({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  State<StatefulWidget> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  final _trackDetailsBloc = TrackDetailsBloc();
  final _trackLyricsBloc = TrackLyricsBloc();

  @override
  void initState() {
    _trackDetailsBloc.eventSink.add(widget.id);
    _trackLyricsBloc.eventSink.add(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Track Details"),
        ),
        body: StreamBuilder<Track>(
          stream: _trackDetailsBloc.trackdetailsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListView(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          snapshot.data!.name,
                          style: const TextStyle(fontSize: 22),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Text(
                        "Artist",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          snapshot.data!.artist,
                          style: const TextStyle(fontSize: 22),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Text(
                        "Album",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          snapshot.data!.album,
                          style: const TextStyle(fontSize: 22),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Text(
                        "Explicit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          (() {
                            if (snapshot.data!.explicit == 1) {
                              return "True";
                            }
                            return "False";
                          })(),
                          style: const TextStyle(fontSize: 22),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Text(
                        "Rating",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          snapshot.data!.rating.toString(),
                          style: const TextStyle(fontSize: 22),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      StreamBuilder(
                        stream: _trackLyricsBloc.trackLyricsStream,
                        builder: (context, snapshot1) {
                          if (snapshot1.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Lyrics",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Text(
                                    snapshot1.data.toString(),
                                    style: const TextStyle(fontSize: 22),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ]),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
