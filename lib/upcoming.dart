import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lesscrick/prev.dart';
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
  adUnitId: 'ca-app-pub-3550458721470380/2431222100',
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
  adUnitId: 'ca-app-pub-3550458721470380/2048078727',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class Upcoming extends StatefulWidget {
  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
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
        title:
            Text("Upcoming", style: TextStyle(fontSize: 20, color: Colors.white)),
        elevation: 0,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
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


      body:     RefreshIndicator(
            onRefresh: getcricdata,
            child:FutureBuilder(
              future: getcricdata(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return  ListView(
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
                              image: NetworkImage("https://i.ibb.co/PxGV03K/Cricket-Poster-Cards-India-Online-Sportwalk-3.jpg"))

                          ),
                          child: Container(
                            color: Colors.black54,
                            padding: EdgeInsets.all(8),
                            height: 100,
                            width: double.infinity,
                            child: Center(child: Text("Upcoming",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:30)))),
                        ),
                      ),
            Column(
                children: <Widget>[
                for(int i=0;i<cricdata.length;i++)
               if(cricdata[i]['header']['state']=="preview")
                  Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: (){
              
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Prevmtch("${cricdata[i]['team1']['name']} vs ${cricdata[i]['team2']['name']} ", cricdata[i]['match_id'],cricdata[i]['team1']['id'],cricdata[i]['team2']['id'],cricdata[i]['team1']['name'],cricdata[i]['team2']['name'])));
              
                    },
                    child: 
                    
                 
                     Card(
                       elevation: 5,
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(16)
                      //   ),
                                        child: Container(
                        height: 160,
                       // width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                    child:Column(
                      children: <Widget>[
                         Center(
                                child: Text( cricdata[i]['header']['state_title']=='In Progress'?"Live":cricdata[i]['header']['state'],style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold))
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("https://www.cricbuzz.com/stats/flags/web/official_flags/team_${cricdata[i]['team1']['id']}.png"))
                                    ),
                                  ),
                                   Container(
                                     
                                     child: Text(cricdata[i]["team1"]["name"],style: TextStyle(color: Colors.black))),
                                ],
                              ),

                              Text("Vs",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),

                              Column(
                                children: <Widget>[
                                  
                                
                                  Container(
                                    margin: EdgeInsets.only(left: 8),

                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("https://www.cricbuzz.com/stats/flags/web/official_flags/team_${cricdata[i]['team2']['id']}.png"))
                                    ),
                                  ),
                                   Container(
                                   
                                   child: Text(cricdata[i]["team2"]["name"],style: TextStyle(color: Colors.black))),
                                ],
                              ),
                             
                            ],
                          ),
                        ),
                         Flexible(child:Text(cricdata[i]['series_name'],style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),) ,),
                         Flexible(child: Text("Venu: ${cricdata[i]['venue']['name']} at ${cricdata[i]['venue']['location']}",style: TextStyle(fontWeight: FontWeight.w500,fontSize:10,color: Colors.black)),),
                         Text(cricdata[i]['header']['status'],style: TextStyle(color: Colors.black))
                      ],
                    )
                    
                     ),
                      ),
                    ),
                  ),
                ),
                ],
              ),


          
         ],
       );
                }else if(snapshot.hasError){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(child: CircularProgressIndicator(),);
              },

            )
          )
       
    );
  }
}
