// To parse this JSON data, do
//
//     final pl = plFromJson(jsonString);

import 'dart:convert';

Pl plFromJson(String str) => Pl.fromJson(json.decode(str));

String plToJson(Pl data) => json.encode(data.toJson());

class Pl {
    Url url;
    String matchId;
    String seriesId;
    String seriesName;
    String dataPath;
    Header header;
    String alerts;
    Venue venue;
    Official official;
    Toss toss;
    List<dynamic> audio;
    Team team1;
    Team team2;
    List<Player> players;
    Apis apis;
    List<dynamic> ads;

    Pl({
        this.url,
        this.matchId,
        this.seriesId,
        this.seriesName,
        this.dataPath,
        this.header,
        this.alerts,
        this.venue,
        this.official,
        this.toss,
        this.audio,
        this.team1,
        this.team2,
        this.players,
        this.apis,
        this.ads,
    });

    factory Pl.fromJson(Map<String, dynamic> json) => new Pl(
        url: Url.fromJson(json["url"]),
        matchId: json["match_id"],
        seriesId: json["series_id"],
        seriesName: json["series_name"],
        dataPath: json["data_path"],
        header: Header.fromJson(json["header"]),
        alerts: json["alerts"],
        venue: Venue.fromJson(json["venue"]),
        official: Official.fromJson(json["official"]),
        toss: Toss.fromJson(json["toss"]),
        audio: new List<dynamic>.from(json["audio"].map((x) => x)),
        team1: Team.fromJson(json["team1"]),
        team2: Team.fromJson(json["team2"]),
        players: new List<Player>.from(json["players"].map((x) => Player.fromJson(x))),
        apis: Apis.fromJson(json["apis"]),
        ads: new List<dynamic>.from(json["ads"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "url": url.toJson(),
        "match_id": matchId,
        "series_id": seriesId,
        "series_name": seriesName,
        "data_path": dataPath,
        "header": header.toJson(),
        "alerts": alerts,
        "venue": venue.toJson(),
        "official": official.toJson(),
        "toss": toss.toJson(),
        "audio": new List<dynamic>.from(audio.map((x) => x)),
        "team1": team1.toJson(),
        "team2": team2.toJson(),
        "players": new List<dynamic>.from(players.map((x) => x.toJson())),
        "apis": apis.toJson(),
        "ads": new List<dynamic>.from(ads.map((x) => x)),
    };
}

class Apis {
    String pointsTable;
    String commentary;
    String twitterTimeline;
    String matchTimeline;
    String scorecard;
    String mini;
    String overCommentary;
    String highlights;
    String miniHighlights;
    String graphs;
    String leanback;
    String matchfacts;
    String country;
    String matchVideos;
    String expert;

    Apis({
        this.pointsTable,
        this.commentary,
        this.twitterTimeline,
        this.matchTimeline,
        this.scorecard,
        this.mini,
        this.overCommentary,
        this.highlights,
        this.miniHighlights,
        this.graphs,
        this.leanback,
        this.matchfacts,
        this.country,
        this.matchVideos,
        this.expert,
    });

    factory Apis.fromJson(Map<String, dynamic> json) => new Apis(
        pointsTable: json["points_table"],
        commentary: json["commentary"],
        twitterTimeline: json["twitter_timeline"],
        matchTimeline: json["match_timeline"],
        scorecard: json["scorecard"],
        mini: json["mini"],
        overCommentary: json["over_commentary"],
        highlights: json["highlights"],
        miniHighlights: json["mini_highlights"],
        graphs: json["graphs"],
        leanback: json["leanback"],
        matchfacts: json["matchfacts"],
        country: json["country"],
        matchVideos: json["match_videos"],
        expert: json["expert"],
    );

    Map<String, dynamic> toJson() => {
        "points_table": pointsTable,
        "commentary": commentary,
        "twitter_timeline": twitterTimeline,
        "match_timeline": matchTimeline,
        "scorecard": scorecard,
        "mini": mini,
        "over_commentary": overCommentary,
        "highlights": highlights,
        "mini_highlights": miniHighlights,
        "graphs": graphs,
        "leanback": leanback,
        "matchfacts": matchfacts,
        "country": country,
        "match_videos": matchVideos,
        "expert": expert,
    };
}

class Header {
    String startTime;
    String endTime;
    String state;
    int winningTeamId;
    String matchDesc;
    List<int> mom;
    List<String> momNames;
    String type;
    String stateTitle;
    String toss;
    String status;

    Header({
        this.startTime,
        this.endTime,
        this.state,
        this.winningTeamId,
        this.matchDesc,
        this.mom,
        this.momNames,
        this.type,
        this.stateTitle,
        this.toss,
        this.status,
    });

    factory Header.fromJson(Map<String, dynamic> json) => new Header(
        startTime: json["start_time"],
        endTime: json["end_time"],
        state: json["state"],
        winningTeamId: json["winning_team_id"],
        matchDesc: json["match_desc"],
        mom: new List<int>.from(json["mom"].map((x) => x)),
        momNames: new List<String>.from(json["momNames"].map((x) => x)),
        type: json["type"],
        stateTitle: json["state_title"],
        toss: json["toss"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "start_time": startTime,
        "end_time": endTime,
        "state": state,
        "winning_team_id": winningTeamId,
        "match_desc": matchDesc,
        "mom": new List<dynamic>.from(mom.map((x) => x)),
        "momNames": new List<dynamic>.from(momNames.map((x) => x)),
        "type": type,
        "state_title": stateTitle,
        "toss": toss,
        "status": status,
    };
}

class Official {
    Referee umpire1;
    Referee umpire2;
    Referee umpire3;
    Referee referee;

    Official({
        this.umpire1,
        this.umpire2,
        this.umpire3,
        this.referee,
    });

    factory Official.fromJson(Map<String, dynamic> json) => new Official(
        umpire1: Referee.fromJson(json["umpire1"]),
        umpire2: Referee.fromJson(json["umpire2"]),
        umpire3: Referee.fromJson(json["umpire3"]),
        referee: Referee.fromJson(json["referee"]),
    );

    Map<String, dynamic> toJson() => {
        "umpire1": umpire1.toJson(),
        "umpire2": umpire2.toJson(),
        "umpire3": umpire3.toJson(),
        "referee": referee.toJson(),
    };
}

class Referee {
    String id;
    String name;
    String country;

    Referee({
        this.id,
        this.name,
        this.country,
    });

    factory Referee.fromJson(Map<String, dynamic> json) => new Referee(
        id: json["id"],
        name: json["name"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
    };
}

class Player {
    String id;
    String fName;
    String name;
    BatStyle batStyle;
    String bowlStyle;
    Speciality speciality;
    String role;
    String image;

    Player({
        this.id,
        this.fName,
        this.name,
        this.batStyle,
        this.bowlStyle,
        this.speciality,
        this.role,
        this.image,
    });

    factory Player.fromJson(Map<String, dynamic> json) => new Player(
        id: json["id"],
        fName: json["f_name"],
        name: json["name"],
        batStyle: batStyleValues.map[json["bat_style"]],
        bowlStyle: json["bowl_style"] == null ? null : json["bowl_style"],
        speciality: specialityValues.map[json["speciality"]],
        role: json["role"] == null ? null : json["role"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "name": name,
        "bat_style": batStyleValues.reverse[batStyle],
        "bowl_style": bowlStyle == null ? null : bowlStyle,
        "speciality": specialityValues.reverse[speciality],
        "role": role == null ? null : role,
        "image": image,
    };
}

enum BatStyle { LEFT, RIGHT }

final batStyleValues = new EnumValues({
    "LEFT": BatStyle.LEFT,
    "RIGHT": BatStyle.RIGHT
});

enum Speciality { BATSMAN, WK_BATSMAN, BATTING_ALLROUNDER, BOWLING_ALLROUNDER, BOWLER }

final specialityValues = new EnumValues({
    "Batsman": Speciality.BATSMAN,
    "Batting Allrounder": Speciality.BATTING_ALLROUNDER,
    "Bowler": Speciality.BOWLER,
    "Bowling Allrounder": Speciality.BOWLING_ALLROUNDER,
    "WK-Batsman": Speciality.WK_BATSMAN
});

class Team {
    String id;
    String name;
    String sName;
    String flag;
    List<int> squad;
    List<int> squadBench;

    Team({
        this.id,
        this.name,
        this.sName,
        this.flag,
        this.squad,
        this.squadBench,
    });

    factory Team.fromJson(Map<String, dynamic> json) => new Team(
        id: json["id"],
        name: json["name"],
        sName: json["s_name"],
        flag: json["flag"],
        squad: new List<int>.from(json["squad"].map((x) => x)),
        squadBench: new List<int>.from(json["squad_bench"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "s_name": sName,
        "flag": flag,
        "squad": new List<dynamic>.from(squad.map((x) => x)),
        "squad_bench": new List<dynamic>.from(squadBench.map((x) => x)),
    };
}

class Toss {
    String winner;
    String decision;

    Toss({
        this.winner,
        this.decision,
    });

    factory Toss.fromJson(Map<String, dynamic> json) => new Toss(
        winner: json["winner"],
        decision: json["decision"],
    );

    Map<String, dynamic> toJson() => {
        "winner": winner,
        "decision": decision,
    };
}

class Url {
    String match;

    Url({
        this.match,
    });

    factory Url.fromJson(Map<String, dynamic> json) => new Url(
        match: json["match"],
    );

    Map<String, dynamic> toJson() => {
        "match": match,
    };
}

class Venue {
    String name;
    String location;
    String timezone;
    String lat;
    String long;

    Venue({
        this.name,
        this.location,
        this.timezone,
        this.lat,
        this.long,
    });

    factory Venue.fromJson(Map<String, dynamic> json) => new Venue(
        name: json["name"],
        location: json["location"],
        timezone: json["timezone"],
        lat: json["lat"],
        long: json["long"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "timezone": timezone,
        "lat": lat,
        "long": long,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
