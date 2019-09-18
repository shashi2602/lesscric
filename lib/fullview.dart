import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lesscrick/dartcode.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:lesscrick/players.dart';

import 'package:lesscrick/scorepalyer.dart';
import 'package:firebase_admob/firebase_admob.dart';
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['sports','cricket','icc','dream11','shopping','camera'],

  childDirected: false,// or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  
  adUnitId: 'ca-app-pub-3550458721470380/8232437020',
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  
  adUnitId: 'ca-app-pub-3550458721470380/4704255556',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class Fullview extends StatefulWidget {
  final String api;
  final String cricname;
  final String bid;
  Fullview(this.cricname, this.api,this.bid);
  @override
  _FullviewState createState() => _FullviewState();
}

class _FullviewState extends State<Fullview> {
  List data;
  List listdata;
  String momname;
  String momid;
  String serisname;
  String type;
  String matchdec;
  String moms;
  String venu;
  String venulocation;
  String t1sor;
  String t1wkt;
  String t1over;
  String t2sor;
  String t2wkt;
  String t2over;
  String preover;
  String status;
  List players;
  List data2;
  String oversummey;
  String rem;
  String balldef;
  String runs;
  String fours;
  String sixs;
  String wekts;
  String tname;
  String tid;
  String t1;
  String t2;
  String t1name;
  String t2name;
  String preo;
  String osummery;
  List batman;
  List bolwer;
  @override
  void initState() {
    super.initState();
    this.getscorecard();
    this.getdata();
    this.getmom();
    this.getplayerss();
    this.getplayers();

    this.getcommencard();
    myInterstitial
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 60.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }

  Future<String> getmom() async {
    var momcov = await http.get(
        Uri.encodeFull("http://mapps.cricbuzz.com/cbzios/match/${widget.api}"));
    setState(() {
      var momjson = json.decode(momcov.body);
      t1=momjson['team1']['id'];
      t2=momjson['team2']['id'];
      t1name=momjson['team1']['s_name'];
      t2name=momjson['team2']['s_name'];
    });
    return "success";
  }
 Future<String> getplayers() async {
    var momcovs = await http.get(Uri.encodeFull(
        "http://mapps.cricbuzz.com/cbzios/match/${widget.api}/leanback.json"));
    setState(() {
      var lesjson=json.decode(momcovs.body);
      preo=lesjson['prev_overs'].toString();
    });
    return "success";
 }
  Future<String> getplayerss() async {
    var momcovs = await http.get(Uri.encodeFull(
        "http://mapps.cricbuzz.com/cbzios/match/${widget.api}/leanback.json"));
    setState(() {
      var momjsons = json.decode(momcovs.body);
      serisname = momjsons['series_name'].toString();
      type = momjsons['header']['type'].toString();
      matchdec = momjsons['header']['match_desc'].toString();
      status = momjsons['header']['status'].toString();
      venu = momjsons['venue']['name'].toString();
      venulocation = momjsons['venue']['location'].toString();
      t1sor = momjsons['bat_team']['innings'][0]['score'].toString();
      t1wkt = momjsons['bat_team']['innings'][0]['wkts'].toString();
      t1over = momjsons['bat_team']['innings'][0]['overs'].toString();
      t2sor = momjsons['bow_team']['innings'][0]['score'].toString();
      t2wkt = momjsons['bow_team']['innings'][0]['wkts'].toString();
      t2over = momjsons['bow_team']['innings'][0]['overs'].toString();
      preover = momjsons['prev_overs'].toString();
      
    });
    return "success";
  }

  Future<String> getscorecard() async {
    var scov = await http.get(Uri.encodeFull(
        "http://mapps.cricbuzz.com/cbzios/match/${widget.api}/scorecard.json"));
    setState(() {
      var sjson = json.decode(scov.body);
      data = sjson['Innings'];
      listdata = sjson['Innings'][0]['batsmen'];
    });
    return "success";
  }

  Future<Jason> getdata() async {
    var cov = await http
        .get("http://mapps.cricbuzz.com/cbzios/match/${widget.api}/commentary");
    if (cov.statusCode == 200) {
      return jasonFromJson(cov.body);
    } else {
      Exception("error");
    }
    return getdata();
  }
  Future<String> getcommencard() async {
    var scov = await http.get(Uri.encodeFull(
        "http://mapps.cricbuzz.com/cbzios/match/${widget.api}/commentary"));
    setState(() {
      var sjson = json.decode(scov.body);
      data2 = sjson['comm_lines'];
      oversummey=sjson['over_summary']['over'];
      rem=sjson['over_summary']['rem_over'];
      balldef=sjson['over_summary']['ball_def'];
      wekts=sjson['over_summary']['wickets'];
      fours=sjson['over_summary']['fours'];
      sixs=sjson['over_summary']['sixes'];
      tname=sjson['bat_team']['name'];
      tid=sjson['bat_team']['id'];
      batman=sjson['batsman'];
      bolwer=sjson['bowler'];
 
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-3550458721470380~7675153389");
        myBanner
      
      ..load()
      ..show(
        
        anchorType: AnchorType.bottom,
      );
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.cricname,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                getdata();
                getcommencard();
                getmom();
                getplayers();
                getscorecard();
                getplayerss();
                
              });
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: getplayerss,
        child: ListView(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 6,
                    
                      borderRadius: BorderRadius.circular(10),
                    
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("https://i.ibb.co/kgCF914/Design-1.png"))
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(serisname.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(type.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                                Text(matchdec.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Venue: ${venu.toString()},${venulocation.toString()}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          )
                        ],
                      ),
                    ))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  status.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500, 
                      //color: Colors.white
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 6,
                // decoration: BoxDecoration(
                //     color: Colors.white,
                     borderRadius: BorderRadius.circular(10),
                     //),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage("https://i.ibb.co/68N5xD8/Design-3.png"))
                      ),
                  child: FutureBuilder<Jason>(
                    future: getdata(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                    Container(
                                height:55,
                                width: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("https://via.placeholder.com/150/000000/FFFFFF/?text=No image")),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                
                                child: Image.network(
                                  'https://www.cricbuzz.com/stats/flags/web/official_flags/team_${snapshot.data.batTeam.id}.png',
                                  scale: 1,fit: BoxFit.cover,
                                ),
                              ),
                                 
                                  Text(
                                    snapshot.data.batTeam.name.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                        ),
                                  ),
                                  snapshot.data.batTeam.innings.length == 0
                                      ? Text(
                                          "yet to bat",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : Row(
                                          children: <Widget>[
                                            Text(
                                              "${t1sor.toString()}/${t1wkt.toString()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                  color: Colors.white
                                                  ),
                                            ),
                                            Text(
                                              "(${t1over.toString()})",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white
                                                  ),
                                            )
                                          ],
                                        )
                                ],
                              ),
                              Text(
                                "VS",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                    ),
                              ),
                              Column(
                                children: <Widget>[
                                   Container(
                                height:55,
                                width: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("https://via.placeholder.com/150/000000/FFFFFF/?text=No image")),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                
                                child: Image.network(
                                  'https://www.cricbuzz.com/stats/flags/web/official_flags/team_${snapshot.data.bowTeam.id}.png',
                                  scale: 1,fit: BoxFit.cover,
                                ),
                              ),
                                
                                  Text(
                                    snapshot.data.bowTeam.name.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  snapshot.data.bowTeam.innings.length == 0
                                      ? Text(
                                          "yet to bat",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : Row(
                                          children: <Widget>[
                                            Text(
                                              "${t2sor.toString()}/${t2wkt.toString()}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white
                                                  ),
                                            ),
                                            Text(
                                              "(${t2over.toString()})",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white
                                                  ),
                                            ),
                                          ],
                                        ),
                                ],
                              )
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                   Container(
                                height:55,
                                width: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("https://via.placeholder.com/150/000000/FFFFFF/?text=No image")),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                
                                child: Image.network(
                                  'https://www.cricbuzz.com/stats/flags/web/official_flags/team_$tid.png',
                                  scale: 1,fit: BoxFit.cover,
                                ),
                              ),
                                  Text(
                                  tname.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                        ),
                                  ),
                                 Row(
                                          children: <Widget>[
                                            Text(
                                              "${t1sor.toString()}/${t1wkt.toString()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                  color: Colors.white
                                                  ),
                                            ),
                                            Text(
                                              "(${t1over.toString()})",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white
                                                  ),
                                            )
                                          ],
                                        )
                                ],
                              ),
                              Text(
                                "VS",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                    ),
                              ),
                              Column(
                                children: <Widget>[
                                   Container(
                                height:55,
                                width: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("https://via.placeholder.com/150/000000/FFFFFF/?text=No image")),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                
                                child: Image.network(
                                  'https://www.cricbuzz.com/stats/flags/web/official_flags/team_${widget.bid}.png',
                                  scale: 1,fit: BoxFit.cover,
                                ),
                              ),
                                  Text(
                                   widget.bid.toString()==t1.toString()?t1name.toString():t2name.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                   Text(
                                          "Yet to bat",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      
                                ],
                              )
                            ],
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  preover.toString()=="null"?preo.toString():preover.toString(),
                  style: TextStyle(
                      //color: Colors.white,
                       fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("OverSummery",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      //color: Colors.white
                      )),
            ),
            FutureBuilder<Jason>(
                future: getdata(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: <Widget>[
                          overchip("over: ${snapshot.data.overSummary.over}"),
                          overchip(
                              "ball_def: ${snapshot.data.overSummary.ballDef}"),
                          overchip(
                              "rem_over: ${snapshot.data.overSummary.remOver}"),
                          overchip("runs: ${snapshot.data.overSummary.runs}"),
                          overchip(
                              "wickets: ${snapshot.data.overSummary.wickets}"),
                          overchip("4's: ${snapshot.data.overSummary.fours}"),
                          overchip("6's: ${snapshot.data.overSummary.sixes}"),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: <Widget>[
                          overchip("over: $oversummey"),
                          overchip(
                              "ball_def: $balldef"),
                          overchip(
                              "rem_over: $rem"),
                          overchip("runs: $runs"),
                          overchip(
                              "wickets: $wekts"),
                          overchip("4's: $fours"),
                          overchip("6's: $sixs"),
                        ],
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            FutureBuilder<Jason>(
                future: getdata(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  "${snapshot.data.batTeam.name} Batting",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      //color: Colors.white
                                      )),
                            ),
                            SizedBox(width: 100)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: 85,
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                         // color: Colors.white
                                          ),
                                    ),
                                  ),
                                  Text(
                                    "s",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                  Text(
                                    "r",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                  Text(
                                    'b',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                  Text(
                                    "4s",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                  Text(
                                    "6s",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  )
                                ],
                              ),
                              for(int i=0;i<snapshot.data.batsman.length;i++)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                        width: 80,
                                        child: Text(
                                            snapshot.data.batsman[i].name,
                                            //style: TextStyle(
                                              //  color: Colors.white)
                                              )
                                              ),
                                    Text(snapshot.data.batsman[i].strike,
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                    Text(snapshot.data.batsman[i].r,
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                    Text(snapshot.data.batsman[i].b,
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                    Text(snapshot.data.batsman[i].the4S,
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                    Text(snapshot.data.batsman[i].the6S,
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                  ],
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  "${snapshot.data.bowTeam.name} Bowling",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      //color: Colors.white
                                      )),
                            ),
                            SizedBox(
                              width: 100,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: 85,
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          //color: Colors.white
                                          ),
                                    ),
                                  ),
                                  Text(
                                    "o",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                  Text(
                                    "m",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                  Text(
                                    'r',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                  Text(
                                    "w",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                        width: 80,
                                        child: Text(
                                            snapshot.data.bowler[0].name,
                                            //style: TextStyle(
                                                //color: Colors.white)
                                                )),
                                    Text(snapshot.data.bowler[0].o,
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                    Text(snapshot.data.bowler[0].m,
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                    Text(snapshot.data.bowler[0].r,
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                    Text(snapshot.data.bowler[0].w,
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  "Batting",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      //color: Colors.white
                                      )
                                      ),
                            ),
                            SizedBox(width: 100)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: 85,
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                         // color: Colors.white
                                         ),
                                    ),
                                  ),
                                  Text(
                                    "s",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        
                                        ),
                                  ),
                                  Text(
                                    "r",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                     
                                        ),
                                  ),
                                  Text(
                                    'b',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        
                                        ),
                                  ),
                                  Text(
                                    "4s",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      
                                        ),
                                  ),
                                  Text(
                                    "6s",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  )
                                ],
                              ),
                              for(int i=0;i<batman.length;i++)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    
                                    Container(
                                        width: 80,
                                        child: Text(batman[i]['name'].toString(),
                                            //style: TextStyle(
                                               // color: Colors.white)
                                               )),
                                    Text(batman[i]['strike'].toString(),
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                    Text(batman[i]['r'].toString(),
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                    
                                    Text(batman[i]['b'].toString(),
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                    Text(batman[i]['4s'].toString(),
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                    Text(batman[i]['6s'].toString(),
                                        //style: TextStyle(color: Colors.white)
                                        ),
                                  ],
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  "Bowling",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      //color: Colors.white
                                      )
                                      ),
                            ),
                            SizedBox(
                              width: 100,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: 85,
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          //color: Colors.white
                                          ),
                                    ),
                                  ),
                                  Text(
                                    "o",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                  Text(
                                    "m",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                  Text(
                                    'r',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                  Text(
                                    "w",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        //color: Colors.white
                                        ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                        width: 80,
                                        child: Text(
                                            bolwer[0]['name'].toString(),
                                           
                                              )),
                                    Text(bolwer[0]['o'].toString(),
                                      
                                        ),
                                    Text(bolwer[0]['m'].toString(),
                                       
                                        ),
                                    Text(bolwer[0]['r'].toString(),
                                        
                                        ),
                                    Text(bolwer[0]['w'].toString(),
                                        
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Player(widget.api)));
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        
                        
                        width: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          child: Container(
                            
                        width: 150,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("Players",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),)),
                                ),
                          )
                          ),
                    )
                        ),

                  GestureDetector(
                    onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Weburl("Scorecard", "https://www.cricbuzz.com/live-cricket-scorecard/${widget.api}")));
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        
                        
                        width: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          child: Container(
                            
                        width: 150,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("Scorecard",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),)),
                                ),
                          )
                          ),
                    )
                        ),    
              ],
            ),


            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Commentry",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      
                      )
                      ),
            ),

 FutureBuilder<Jason>(
                future: getdata(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        for (int i = 0; i < snapshot.data.commLines.length; i++)
                    if (snapshot.data.commLines[i].comm.toString() == 'null')
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: <Widget>[
                               overchip("summary:${snapshot.data.commLines[i].oSummary}"),
                              overchip("score:${snapshot.data.commLines[i].score}"),
                              overchip("o_no:${snapshot.data.commLines[i].oNo}"),
                              overchip("wkts:${snapshot.data.commLines[i].wkts}"),
                              overchip("runs:${snapshot.data.commLines[i].runs}")
                            ],
                          )
                          )
                    else
                      ListTile(
                        leading: snapshot.data.commLines[i].oNo.toString() ==
                                'null'
                            ? Text("")
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data.commLines[i].oNo.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                        title: Html(
                
                          data: snapshot.data.commLines[i].comm.toString(),
                        ),
                      ),
                      ],
                    );
                  }else if (snapshot.hasError) {
                    return Column(
                        children: <Widget>[
                          for (int i = 0; i < data2.length; i++)

                           if (data2[i]['comm'].toString() == 'null')
                      Padding(
                          padding: EdgeInsets.all(10),
                          child:  Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              overchip("summary:${data2[i]['o_summary']}"),
                              overchip("score:${data2[i]['score']}"),
                              overchip("o_no:${data2[i]['o_no']}"),
                              overchip("wkts:${data2[i]['wkts']}"),
                              overchip("runs:${data2[i]['runs']}")



                            ],
                          )
                      )
                    else
                      ListTile(
                        leading: data2[i]['o_no'].toString() ==
                                'null'
                            ? Text("")
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data2[i]['o_no'].toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                        title: Html(
                          
                          data: data2[i]['comm'].toString(),
                        ),
                      ),
                           
                        ],
                      );
                  }
                  return Center(child: CircularProgressIndicator());
                  }
                  
                  )

          ],
        ),
        
      ),
    );
  }
}

Widget overchip(String text) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(6)),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
