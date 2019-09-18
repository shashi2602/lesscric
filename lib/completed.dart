import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'fullview.dart';
import 'package:firebase_admob/firebase_admob.dart';

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>[
    'sports',
    'cricket',
    'icc',
    'dream11',
    'shopping',
    'camera'
  ],

  childDirected: false, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-3550458721470380/6781530656',
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
  adUnitId: 'ca-app-pub-3550458721470380/4488633135',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class Completed extends StatefulWidget {
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  void initState() {
    super.initState();
    this.getcricdata();
    myInterstitial
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        
        anchorType: AnchorType.bottom,
      );
  }

  final String cricurl = "http://mapps.cricbuzz.com/cbzios/match/livematches";
  List cricdata;

  Future<String> getcricdata() async {
    var response = await http.get(
      Uri.encodeFull(cricurl),
    );
    setState(() {
      var converteddata = json.decode(response.body);
      cricdata = converteddata['matches'];
    });

    return "success";
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
          title: Text("Completed",
              style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: 'Cabin')),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  getcricdata();
                });
              },
            )
          ],
        ),
        body: RefreshIndicator(
            onRefresh: getcricdata,
            child: FutureBuilder(
              future: getcricdata(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage("https://i.ibb.co/swbfDs9/Cricket-Poster-Cards-India-Online-Sportwalk-4.jpg"))

                          ),
                          child:  Container(
                            color: Colors.black54,
                            padding: EdgeInsets.all(8),
                            height: 100,
                            width: double.infinity,
                            child: Center(child: Text("Completed",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:30,fontFamily: 'Cabin')))),
                        ),
                        
                      ),
                      Column(
                        children: <Widget>[
                          for (int i = 0; i < cricdata.length; i++)
                            if (cricdata[i]['header']['state'] == "mom" ||
                                cricdata[i]['header']['state_title'] ==
                                    "complete")
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Fullview(
                                                  "${cricdata[i]['team1']['name']} vs ${cricdata[i]['team2']['name']} ",
                                                  cricdata[i]['match_id'],
                                                  cricdata[i]['match_id'])));
                                    },
                                    child: Material(
                                      borderRadius: BorderRadius.circular(5),
                                      elevation: 6,
                                      child: Container(
                                        //height: 175,
                                        //width: 300,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: <Widget>[
                                              Center(
                                                  child: Text(
                                                      cricdata[i]['header'][
                                                                  'state_title'] ==
                                                              'In Progress'
                                                          ? "Live"
                                                          : cricdata[i]
                                                                  ['header']
                                                              ['state'],
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ))),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          
                                                           color: Colors.black,
                                      borderRadius: BorderRadius.circular(5),
                                                            image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                    "https://www.cricbuzz.com/stats/flags/web/official_flags/team_${cricdata[i]['bat_team']['id']}.png"))),
                                                      ),
                                                      cricdata[i]["bat_team"]
                                                                  ['id'] ==
                                                              cricdata[i]
                                                                      ['team1']
                                                                  ['id']
                                                          ? Text(
                                                              cricdata[i]
                                                                      ['team1']
                                                                  ['name'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          : Text(
                                                              cricdata[i]
                                                                      ['team2']
                                                                  ['name'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      cricdata[i]['bat_team'][
                                                                      'innings']
                                                                  .toString() ==
                                                              "[]"
                                                          ? Text("yet to bat ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black))
                                                          : Text(
                                                              "${cricdata[i]['bat_team']['innings'][0]['score']}/${cricdata[i]['bat_team']['innings'][0]['wkts']}(${cricdata[i]['bat_team']['innings'][0]['overs']})",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                    child: Text(
                                                      "vs",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                      borderRadius: BorderRadius.circular(5),
                                                               
                                                            image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                    "https://www.cricbuzz.com/stats/flags/web/official_flags/team_${cricdata[i]['bow_team']['id']}.png"))),
                                                      ),
                                                      cricdata[i]["bow_team"]
                                                                  ['id'] ==
                                                              cricdata[i]['team1']
                                                                  ['id']
                                                          ? Text(
                                                              cricdata[i]
                                                                      ['team1']
                                                                  ['name'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black))
                                                          : Text(
                                                              cricdata[i]
                                                                      ['team2']
                                                                  ['name'],
                                                              style: TextStyle(
                                                                  color: Colors.black)),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      cricdata[i]['bow_team'][
                                                                      'innings']
                                                                  .toString() ==
                                                              "[]"
                                                          ? Text("yet to bat ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))
                                                          : Text(
                                                              "${cricdata[i]['bow_team']['innings'][0]['score']}/${cricdata[i]['bow_team']['innings'][0]['wkts']}(${cricdata[i]['bow_team']['innings'][0]['overs']})",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                              Text(cricdata[i]['header']
                                                  ['status']),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    cricdata[i]['header']
                                                        ['match_desc'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    cricdata[i]['header']
                                                        ['type'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                        ],
                      ),
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
            )));
  }
}
