// To parse this JSON data, do
//
//     final jason = jasonFromJson(jsonString);

import 'dart:convert';

Jason jasonFromJson(String str) => Jason.fromJson(json.decode(str));

String jasonToJson(Jason data) => json.encode(data.toJson());

class Jason {
    String matchId;
    String seriesId;
    String seriesName;
    String dataPath;
    Header header;
    String alerts;
    Venue venue;
    OverSummary overSummary;
    Team batTeam;
    Team bowTeam;
    List<Batsman> batsman;
    List<Bowler> bowler;
    String rrr;
    String crr;
    String target;
    String prtshp;
    String lastWkt;
    String lastWktName;
    String lastWktScore;
    List<CommLine> commLines;
    String range;
    int pulltoRefreshStopRate;
    int burstCacheId;
    bool burstCache;
    int burstCacheTime;
    Ads ads;

    Jason({
        this.matchId,
        this.seriesId,
        this.seriesName,
        this.dataPath,
        this.header,
        this.alerts,
        this.venue,
        this.overSummary,
        this.batTeam,
        this.bowTeam,
        this.batsman,
        this.bowler,
        this.rrr,
        this.crr,
        this.target,
        this.prtshp,
        this.lastWkt,
        this.lastWktName,
        this.lastWktScore,
        this.commLines,
        this.range,
        this.pulltoRefreshStopRate,
        this.burstCacheId,
        this.burstCache,
        this.burstCacheTime,
        this.ads,
    });

    factory Jason.fromJson(Map<String, dynamic> json) => new Jason(
        matchId: json["match_id"],
        seriesId: json["series_id"],
        seriesName: json["series_name"],
        dataPath: json["data_path"],
        header: Header.fromJson(json["header"]),
        alerts: json["alerts"],
        venue: Venue.fromJson(json["venue"]),
        overSummary: OverSummary.fromJson(json["over_summary"]),
        batTeam: Team.fromJson(json["bat_team"]),
        bowTeam: Team.fromJson(json["bow_team"]),
        batsman: new List<Batsman>.from(json["batsman"].map((x) => Batsman.fromJson(x))),
        bowler: new List<Bowler>.from(json["bowler"].map((x) => Bowler.fromJson(x))),
        rrr: json["rrr"],
        crr: json["crr"],
        target: json["target"],
        prtshp: json["prtshp"],
        lastWkt: json["last_wkt"],
        lastWktName: json["last_wkt_name"],
        lastWktScore: json["last_wkt_score"],
        commLines: new List<CommLine>.from(json["comm_lines"].map((x) => CommLine.fromJson(x))),
        range: json["range"],
        pulltoRefreshStopRate: json["pulltoRefreshStopRate"],
        burstCacheId: json["burst_cache_id"],
        burstCache: json["burst_cache"],
        burstCacheTime: json["burst_cache_time"],
        ads: Ads.fromJson(json["ads"]),
    );

    Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "series_id": seriesId,
        "series_name": seriesName,
        "data_path": dataPath,
        "header": header.toJson(),
        "alerts": alerts,
        "venue": venue.toJson(),
        "over_summary": overSummary.toJson(),
        "bat_team": batTeam.toJson(),
        "bow_team": bowTeam.toJson(),
        "batsman": new List<dynamic>.from(batsman.map((x) => x.toJson())),
        "bowler": new List<dynamic>.from(bowler.map((x) => x.toJson())),
        "rrr": rrr,
        "crr": crr,
        "target": target,
        "prtshp": prtshp,
        "last_wkt": lastWkt,
        "last_wkt_name": lastWktName,
        "last_wkt_score": lastWktScore,
        "comm_lines": new List<dynamic>.from(commLines.map((x) => x.toJson())),
        "range": range,
        "pulltoRefreshStopRate": pulltoRefreshStopRate,
        "burst_cache_id": burstCacheId,
        "burst_cache": burstCache,
        "burst_cache_time": burstCacheTime,
        "ads": ads.toJson(),
    };
}

class Ads {
    Ads();

    factory Ads.fromJson(Map<String, dynamic> json) => new Ads(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Team {
    String id;
    String name;
    List<Inning> innings;

    Team({
        this.id,
        this.name,
        this.innings,
    });

    factory Team.fromJson(Map<String, dynamic> json) => new Team(
        id: json["id"],
        name: json["name"],
        innings: new List<Inning>.from(json["innings"].map((x) => Inning.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "innings": new List<dynamic>.from(innings.map((x) => x.toJson())),
    };
}

class Inning {
    String id;
    String score;
    String wkts;
    String overs;

    Inning({
        this.id,
        this.score,
        this.wkts,
        this.overs,
    });

    factory Inning.fromJson(Map<String, dynamic> json) => new Inning(
        id: json["id"],
        score: json["score"],
        wkts: json["wkts"],
        overs: json["overs"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "score": score,
        "wkts": wkts,
        "overs": overs,
    };
}

class Batsman {
    String id;
    String name;
    String strike;
    String r;
    String b;
    String the4S;
    String the6S;

    Batsman({
        this.id,
        this.name,
        this.strike,
        this.r,
        this.b,
        this.the4S,
        this.the6S,
    });

    factory Batsman.fromJson(Map<String, dynamic> json) => new Batsman(
        id: json["id"],
        name: json["name"],
        strike: json["strike"],
        r: json["r"],
        b: json["b"],
        the4S: json["4s"],
        the6S: json["6s"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "strike": strike,
        "r": r,
        "b": b,
        "4s": the4S,
        "6s": the6S,
    };
}

class Bowler {
    String id;
    String name;
    String o;
    String m;
    String r;
    String w;

    Bowler({
        this.id,
        this.name,
        this.o,
        this.m,
        this.r,
        this.w,
    });

    factory Bowler.fromJson(Map<String, dynamic> json) => new Bowler(
        id: json["id"],
        name: json["name"],
        o: json["o"],
        m: json["m"],
        r: json["r"],
        w: json["w"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "o": o,
        "m": m,
        "r": r,
        "w": w,
    };
}

class CommLine {
    String score;
    String wkts;
    String oNo;
    String iId;
    String oSummary;
    String runs;
    String batSName;
    String batSRuns;
    String batSBalls;
    String batNsName;
    String batNsRuns;
    String batNsBalls;
    String bowlName;
    String bowlOvers;
    String bowlMaidens;
    String bowlRuns;
    String bowlWickets;
    String timestamp;
    String evt;
    String comm;

    CommLine({
        this.score,
        this.wkts,
        this.oNo,
        this.iId,
        this.oSummary,
        this.runs,
        this.batSName,
        this.batSRuns,
        this.batSBalls,
        this.batNsName,
        this.batNsRuns,
        this.batNsBalls,
        this.bowlName,
        this.bowlOvers,
        this.bowlMaidens,
        this.bowlRuns,
        this.bowlWickets,
        this.timestamp,
        this.evt,
        this.comm,
    });

    factory CommLine.fromJson(Map<String, dynamic> json) => new CommLine(
        score: json["score"] == null ? null : json["score"],
        wkts: json["wkts"] == null ? null : json["wkts"],
        oNo: json["o_no"] == null ? null : json["o_no"],
        iId: json["i_id"] == null ? null : json["i_id"],
        oSummary: json["o_summary"] == null ? null : json["o_summary"],
        runs: json["runs"] == null ? null : json["runs"],
        batSName: json["bat_s_name"] == null ? null : json["bat_s_name"],
        batSRuns: json["bat_s_runs"] == null ? null : json["bat_s_runs"],
        batSBalls: json["bat_s_balls"] == null ? null : json["bat_s_balls"],
        batNsName: json["bat_ns_name"] == null ? null : json["bat_ns_name"],
        batNsRuns: json["bat_ns_runs"] == null ? null : json["bat_ns_runs"],
        batNsBalls: json["bat_ns_balls"] == null ? null : json["bat_ns_balls"],
        bowlName: json["bowl_name"] == null ? null : json["bowl_name"],
        bowlOvers: json["bowl_overs"] == null ? null : json["bowl_overs"],
        bowlMaidens: json["bowl_maidens"] == null ? null : json["bowl_maidens"],
        bowlRuns: json["bowl_runs"] == null ? null : json["bowl_runs"],
        bowlWickets: json["bowl_wickets"] == null ? null : json["bowl_wickets"],
        timestamp: json["timestamp"],
        evt: json["evt"] == null ? null : json["evt"],
        comm: json["comm"] == null ? null : json["comm"],
    );

    Map<String, dynamic> toJson() => {
        "score": score == null ? null : score,
        "wkts": wkts == null ? null : wkts,
        "o_no": oNo == null ? null : oNo,
        "i_id": iId == null ? null : iId,
        "o_summary": oSummary == null ? null : oSummary,
        "runs": runs == null ? null : runs,
        "bat_s_name": batSName == null ? null : batSName,
        "bat_s_runs": batSRuns == null ? null : batSRuns,
        "bat_s_balls": batSBalls == null ? null : batSBalls,
        "bat_ns_name": batNsName == null ? null : batNsName,
        "bat_ns_runs": batNsRuns == null ? null : batNsRuns,
        "bat_ns_balls": batNsBalls == null ? null : batNsBalls,
        "bowl_name": bowlName == null ? null : bowlName,
        "bowl_overs": bowlOvers == null ? null : bowlOvers,
        "bowl_maidens": bowlMaidens == null ? null : bowlMaidens,
        "bowl_runs": bowlRuns == null ? null : bowlRuns,
        "bowl_wickets": bowlWickets == null ? null : bowlWickets,
        "timestamp": timestamp,
        "evt": evt == null ? null : evt,
        "comm": comm == null ? null : comm,
    };
}

class Header {
    String startTime;
    String endTime;
    String state;
    String matchDesc;
    String type;
    String stateTitle;
    String toss;
    String status;

    Header({
        this.startTime,
        this.endTime,
        this.state,
        this.matchDesc,
        this.type,
        this.stateTitle,
        this.toss,
        this.status,
    });

    factory Header.fromJson(Map<String, dynamic> json) => new Header(
        startTime: json["start_time"],
        endTime: json["end_time"],
        state: json["state"],
        matchDesc: json["match_desc"],
        type: json["type"],
        stateTitle: json["state_title"],
        toss: json["toss"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "start_time": startTime,
        "end_time": endTime,
        "state": state,
        "match_desc": matchDesc,
        "type": type,
        "state_title": stateTitle,
        "toss": toss,
        "status": status,
    };
}

class OverSummary {
    String over;
    String ballDef;
    String remOver;
    String runs;
    String wickets;
    String fours;
    String sixes;

    OverSummary({
        this.over,
        this.ballDef,
        this.remOver,
        this.runs,
        this.wickets,
        this.fours,
        this.sixes,
    });

    factory OverSummary.fromJson(Map<String, dynamic> json) => new OverSummary(
        over: json["over"],
        ballDef: json["ball_def"],
        remOver: json["rem_over"],
        runs: json["runs"],
        wickets: json["wickets"],
        fours: json["fours"],
        sixes: json["sixes"],
    );

    Map<String, dynamic> toJson() => {
        "over": over,
        "ball_def": ballDef,
        "rem_over": remOver,
        "runs": runs,
        "wickets": wickets,
        "fours": fours,
        "sixes": sixes,
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
