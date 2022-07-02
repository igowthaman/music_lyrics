class TrackList {
  TrackList({
    required this.track,
  });
  List<Track> track;

  factory TrackList.fromJson(Map<String, dynamic> json) => TrackList(
        track: List<Track>.from(json["message"]["body"]["track_list"]
            .map((x) => Track.fromJson(x))),
      );
}

class Track {
  Track(
      {required this.id,
      required this.name,
      required this.albumId,
      required this.album,
      required this.artistId,
      required this.artist,
      required this.rating,
      required this.explicit,});
  int id;
  String name;
  int albumId;
  String album;
  int artistId;
  String artist;
  int rating;
  int explicit;
  factory Track.fromJson(Map<String, dynamic> json) => Track(
      id: json["track"]["track_id"],
      name: json["track"]["track_name"],
      albumId: json["track"]["album_id"],
      album: json["track"]["album_name"],
      artistId: json["track"]["artist_id"],
      artist: json["track"]["artist_name"],
      rating: json["track"]["track_rating"],
      explicit: json["track"]["explicit"]);
}

