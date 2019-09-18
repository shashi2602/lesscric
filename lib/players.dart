import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lesscrick/playerdart.dart';

import 'package:lesscrick/scorepalyer.dart';
import 'package:firebase_admob/firebase_admob.dart';
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['sports','cricket','icc','dream11','shopping','camera'],

  childDirected: false,// or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-3550458721470380/1664935341',
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-3550458721470380/6534118643',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class Player extends StatefulWidget {
  final String id;
  Player(this.id);
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  String team1;
  String team2;
  List players;
  @override
  void initState() {
    super.initState();
    this.getdata();
    this.getteaamdata();
    myInterstitial
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        
        anchorType: AnchorType.bottom,
      );
  }

  Future<Pl> getdata() async {
    var conv =
        await http.get("http://mapps.cricbuzz.com/cbzios/match/${widget.id}");
    print(conv);
    if (conv.statusCode == 200) {
      return plFromJson(conv.body);
    } else {
      Exception("error");
    }
    return getdata();
  }

  Future<String> getteaamdata() async {
    var tconv = await http.get(
        Uri.encodeFull("http://mapps.cricbuzz.com/cbzios/match/${widget.id}"));
    print(tconv);
    setState(() {
      var jsons = json.decode(tconv.body);
      team1 = jsons["team1"]['name'];
      team2 = jsons["team2"]['name'];
      players = jsons['players'];
    });
    return 'ss';
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-3550458721470380~7675153389");
        myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        //anchorOffset: 60.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
       // backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Players',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text(
                  team1 == null ? "" : team1,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                  child: Text(team2 == null ? "" : team2,
                      style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FutureBuilder<Pl>(
              future: getdata(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: <Widget>[
                      for (int i = 0; i < 15; i++)
                        //for(int j=0;i<snapshot.data.team1.squad.length;j++)
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          child: Container(
                            color: Colors.black87,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Image.network(
                                    "https://www.cricbuzz.com/stats/img/faceImages/${snapshot.data.players[i].id}.jpg"),
                              ),
                              title: snapshot.data.players[i].role.toString() ==
                                      "null"
                                  ? Text(
                                      snapshot.data.players[i].fName,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : Text(
                                      "${snapshot.data.players[i].fName} ${snapshot.data.players[i].role}",
                                      style: TextStyle(color: Colors.white)),
                              subtitle: Text(
                                  "${snapshot.data.players[i].batStyle} ${snapshot.data.players[i].speciality}",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return ListView(
                    children: <Widget>[
                      for (int i = 0; i < 14; i++)
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.network(
                                "https://www.cricbuzz.com/stats/img/faceImages/${players[i]['id']}.jpg"),
                          ),
                          title: players[i]['role'].toString() == "null"
                              ? Text(players[i]['f_name'])
                              : Text(
                                  "${players[i]['f_name']} ${players[i]['role']}"),
                          subtitle: Text(
                              "${players[i]['bat_style']} ${players[i]['speciality']}"),
                        )
                    ],
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
            FutureBuilder(
                future: getdata(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: <Widget>[
                        for (int i = 15; i < snapshot.data.players.length; i++)
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.network(
                                  "https://www.cricbuzz.com/stats/img/faceImages/${snapshot.data.players[i].id}.jpg"),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => Weburl(
                                      players[i]['f_name'],
                                      "https://m.cricbuzz.com/profiles/${snapshot.data.players[i].id}")));
                            },
                            title: snapshot.data.players[i].role.toString() ==
                                    "null"
                                ? Text(snapshot.data.players[i].fName)
                                : Text(
                                    "${snapshot.data.players[i].fName} ${snapshot.data.players[i].role}"),
                            subtitle: Text(
                                "${snapshot.data.players[i].batStyle} ${snapshot.data.players[i].speciality}"),
                          )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return ListView(
                      children: <Widget>[
                        for (int i = 14; i < players.length; i++)
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.network(
                                  "https://www.cricbuzz.com/stats/img/faceImages/${players[i]['id']}.jpg"),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => Weburl(
                                      players[i]['f_name'],
                                      "https://m.cricbuzz.com/profiles/${snapshot.data.players[i].id}")));
                            },
                            title: players[i]['role'].toString() == "null"
                                ? Text(players[i]['f_name'])
                                : Text(
                                    "${players[i]['f_name']} ${players[i]['role']}"),
                            subtitle: Text(
                                "${players[i]['bat_style']} ${players[i]['speciality']}"),
                          )
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
