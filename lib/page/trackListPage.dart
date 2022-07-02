import 'dart:ui';

import 'package:flutter/material.dart';

import '../page/trackPage.dart';
import '../bloc/TrackListBloc.dart';
import '../model.dart';

class TrackListPage extends StatefulWidget {
  const TrackListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrackListPageState();
}

class _TrackListPageState extends State<TrackListPage> {
  final _trackListBloc = TrackListBloc();

  @override
  void initState() {
    _trackListBloc.eventSink.add(TrackAction.Fetch);
    super.initState();
  }

  @override
  void dispose() {
    _trackListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<List<Track>>(
          stream: _trackListBloc.tracklistStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var track = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrackPage(id: track.id)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black))),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 70,
                                child: Icon(Icons.library_music_rounded),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 190,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        track.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        track.album,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 70,
                                  child: Text(
                                    track.artist,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
