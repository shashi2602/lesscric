import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lesscrick/dartcode.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
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
  adUnitId: 'ca-app-pub-3550458721470380/3746397103',
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
  adUnitId: 'ca-app-pub-3550458721470380/4680204822',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class Prevmtch extends StatefulWidget {
  final String api;
  final String cricname;
  final String prevt1id;
  final String prevt2id;
  final String prevt1name;
  final String prevt2name;
  Prevmtch(this.cricname, this.api, this.prevt1id, this.prevt2id,
      this.prevt1name, this.prevt2name);
  @override
  _PrevmtchState createState() => _PrevmtchState();
}

class _PrevmtchState extends State<Prevmtch> {
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
  String prevt1id;
  String prevt2id;
  String prevt1name;
  String prevt2name;

  List players;
  @override
  void initState() {
    super.initState();
    this.getscorecard();
    this.getdata();
    //this.getmom();
    this.getplayerss();
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

  

  Future<String> getplayerss() async {
    var momcovs = await http.get(Uri.encodeFull(
        "http://mapps.cricbuzz.com/cbzios/match/${widget.api}/leanback.json"));
    setState(() {
      var momjsons = json.decode(momcovs.body);
      serisname = momjsons['series_name'].toString();
      type = momjsons['header']['type'].toString();
      matchdec = momjsons['header']['match_desc'];
      status = momjsons['header']['status'].toString();
      venu = momjsons['venue']['name'].toString();
      venulocation = momjsons['venue']['location'].toString();
      t1sor = momjsons['bat_team']['innings'][0]['score'].toString();
      t1wkt = momjsons['bat_team']['innings'][0]['wkts'].toString();
      t1over = momjsons['bat_team']['innings'][0]['overs'].toString();
      t2sor = momjsons['bow_team']['innings'][0]['score'].toString();
      t2wkt = momjsons['bow_team']['innings'][0]['wkts'].toString();
      t2over = momjsons['bow_team']['innings'][0]['overs'].toString();
      preover = momjsons['Prevmtch_overs'].toString();
    });
    return "success";
  }

  Future<String> getscorecard() async {
    var scov = await http.get(Uri.encodeFull(
        "http://mapps.cricbuzz.com/cbzios/match/${widget.api}/commentary"));
    setState(() {
      var sjson = json.decode(scov.body);
      data = sjson['comm_lines'];
      //listdata = sjson['Innings'][0]['batsmen'];
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
                  elevation: 5,
                  borderRadius: BorderRadius.circular(5),
                    
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("https://i.ibb.co/68N5xD8/Design-3.png")),
                        borderRadius: BorderRadius.circular(5),
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
                            child: Text("Venue: $venu,$venulocation",
                                style: TextStyle(
                                    color:Colors.white,
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
                      fontWeight: FontWeight.w500, ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Material(
                elevation: 5,
                 borderRadius: BorderRadius.circular(5),
              
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("https://i.ibb.co/VWTbYhc/Design4.png")),
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
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
                                  'https://www.cricbuzz.com/stats/flags/web/official_flags/team_${widget.prevt1id}.png',
                                  scale: 1,fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  //"t1",
                                  widget.prevt1name.toString(),
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "VS",
                            style: TextStyle(
                              color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                                  'https://www.cricbuzz.com/stats/flags/web/official_flags/team_${widget.prevt2id}.png',
                                  scale: 1,fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(

                                    widget.prevt2name.toString(),
                                     style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Commentry",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      )),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: getscorecard(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          for (int i = 0; i < data.length; i++)
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Html(
                                
                                data: data[i]['comm'].toString(),
                              ),
                            )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ))
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
          color: Colors.black87, borderRadius: BorderRadius.circular(5)),
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
