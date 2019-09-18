
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:lesscrick/completed.dart';

import 'package:lesscrick/fullview.dart';
import 'package:lesscrick/livematchs.dart';
import 'package:lesscrick/prev.dart';
//import 'package:lesscrick/rssfeeddata.dart';
import 'package:lesscrick/upcoming.dart';
//import 'package:lesscrick/urllaunch.dart';

 void main(){
   runApp(MaterialApp(home: Mainpage(),
   debugShowCheckedModeBanner: false,
   
   ));
 }



 class Mainpage extends StatefulWidget {
   @override
   _MainpageState createState() => _MainpageState();
 }
 


 class _MainpageState extends State<Mainpage> {
   final String cricurl="http://mapps.cricbuzz.com/cbzios/match/livematches";
   List cricdata;
   List bowteam;
   List news;
  
 @override
  void initState() {
    
    super.initState();
    this.getcricdata();

    //this.getnewsfeed();
  }
  List data;
  List cricfeed;
 String news2;


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
     return Scaffold(
      backgroundColor: Colors.grey[100],
       appBar: AppBar(
         
         title: Text("Lesscric",style: TextStyle(fontSize: 25,color: Colors.white,fontFamily: 'Cabin')),
         centerTitle: true,
         //elevation: 0,
         backgroundColor: Colors.black,
         
       ),
       body: 
          RefreshIndicator(
            onRefresh: getcricdata,
            child:FutureBuilder(
              future: getcricdata(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return  ListView(
         children: <Widget>[
             Stack(
          children: <Widget>[
            Container(
              height: 100,
              width:double.infinity,
              color: Colors.grey[100],
              margin: EdgeInsets.all(0),    
              padding: EdgeInsets.all(0),
            ),
            
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
                Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.black)
              ),
            ),

           Wrap(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Live()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                 height: 120,
                width: 100,
                decoration: BoxDecoration(
                 color: Colors.white,
                
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                 color: Colors.black87,
                 //border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage("https://i.ibb.co/nmXyjSw/Cricket-Poster-Cards-India-Online-Sportwalk-2.jpg"))
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Live Matches",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),
                  ),
                ),
              ),
              )
            ),
          ),
          
           GestureDetector(
             onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Completed()));
            },
             child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                 height: 120,
                width: 100,
                decoration: BoxDecoration(
                 color: Colors.white,
                
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                 color: Colors.black87,
                 //border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("https://i.ibb.co/swbfDs9/Cricket-Poster-Cards-India-Online-Sportwalk-4.jpg"))
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Completed",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17)),
                  ),
                ),
              ),
              )
          ),
           ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Upcoming()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                 height: 120,
                width: 100,
                decoration: BoxDecoration(
                 color: Colors.white,
                
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Container(
                height: 110,
                width: 100,
                decoration: BoxDecoration(
                 color: Colors.black87,
                 //border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage("https://i.ibb.co/PxGV03K/Cricket-Poster-Cards-India-Online-Sportwalk-3.jpg"))
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Upcoming",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                  ),
                ),
              ),
              )
            ),
          )
        ],
      ),
             ],
           )
          ],
        ),
 












 Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Matches",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.black)
              ),
            ),
           






Column(
                children: <Widget>[
                for(int i=0;i<cricdata.length;i++)
               if(cricdata[i]['header']['state']=="preview"||cricdata[i]['header']['state_title']=="In Progress"||cricdata[i]['header']['state']=="delay"||cricdata[i]['state']=="innings break"||cricdata[i]['state']=="toss")
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      cricdata[i]['header']['state']=="preview"||cricdata[i]['header']['state']=="delay"?
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Prevmtch("${cricdata[i]['team1']['name']} vs ${cricdata[i]['team2']['name']} ", cricdata[i]['match_id'],cricdata[i]['team1']['id'],cricdata[i]['team2']['id'],cricdata[i]['team1']['name'],cricdata[i]['team2']['name']))):
               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Fullview("${cricdata[i]['team1']['name']} vs ${cricdata[i]['team2']['name']} ", cricdata[i]['match_id'],cricdata[i]["bow_team"]['id'],)));
             
                    },
                    child: 
                    
                    cricdata[i]['header']['state_title']=="In Progress"?
                    Material(
                      
                          borderRadius: BorderRadius.circular(5),
                     elevation: 6,
                      
                                        child: Container(
                        //height: 160,
                        //width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Center(
                                    child: Text( cricdata[i]['header']['state_title']=='In Progress'?"Live":cricdata[i]['header']['state'],style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,))
                                  ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                
                                 
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: <Widget>[
                                     Container(
                                height:50,
                                width: 60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("https://via.placeholder.com/150/000000/FFFFFF/?text=No image")),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                
                                child: Image.network(
                                  'https://www.cricbuzz.com/stats/flags/web/official_flags/team_${cricdata[i]['bat_team']['id']}.png',
                                  scale: 1,fit: BoxFit.cover,
                                ),
                              ),
                                   
                                      cricdata[i]["bat_team"]['id']==cricdata[i]['team1']['id']?
                                      Text(cricdata[i]['team1']['name'],style: TextStyle(color: Colors.black),)
                                 :
                                      Text(cricdata[i]['team2']['name'],style: TextStyle(color: Colors.black)),
                               
                                         SizedBox(height: 2,),
                                         cricdata[i]['bat_team']['innings'].toString()=="[]"?Text("yet to bat ",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black)): Text("${cricdata[i]['bat_team']['innings'][0]['score']}/${cricdata[i]['bat_team']['innings'][0]['wkts']}(${cricdata[i]['bat_team']['innings'][0]['overs']})",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
                                   ],
                                 ),
                                 Text("Vs",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
                                  Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: <Widget>[
                                       Container(
                                height:50,
                                width: 60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("https://via.placeholder.com/150/000000/FFFFFF/?text=No image")),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                
                                child: Image.network(
                                  'https://www.cricbuzz.com/stats/flags/web/official_flags/team_${cricdata[i]['bow_team']['id']}.png',
                                  scale: 1,fit: BoxFit.cover,
                                ),
                              ),
                                     cricdata[i]["bow_team"]['id']==cricdata[i]['team1']['id']?
                                      Text(cricdata[i]['team1']['name'],style: TextStyle(color: Colors.black))
                                 :
                                      Text(cricdata[i]['team2']['name'],style: TextStyle(color: Colors.black)),
                                         SizedBox(height: 2,),
                   cricdata[i]['bow_team']['innings'].toString()=="[]"?Text("yet to bat ",style: TextStyle(fontWeight: FontWeight.w400)): Text("${cricdata[i]['bow_team']['innings'][0]['score']}/${cricdata[i]['bow_team']['innings'][0]['wkts']}(${cricdata[i]['bow_team']['innings'][0]['overs']})",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
                                       
                                   ],
                                 ),
                               
                                ],
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(cricdata[i]['header']['status']),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(cricdata[i]['header']['match_desc'],style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(cricdata[i]['header']['type'],style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ):
                     Material(
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                      //   ),
                      elevation: 6,
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
                                height:50,
                                width: 60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("https://via.placeholder.com/150/000000/FFFFFF/?text=No image")),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                
                                child: Image.network(
                                  'https://www.cricbuzz.com/stats/flags/web/official_flags/team_${cricdata[i]['team1']['id']}.png',
                                  scale: 1,fit: BoxFit.cover,
                                ),
                              ),
                                  
                                   Container(
                                     //width: 60,
                                     child: Text(cricdata[i]["team1"]["name"],
                                     //style: TextStyle(color: Colors.white)
                                     )),
                                ],
                              ),

                              Text("Vs",
                              //style: TextStyle(color: Colors.white)
                              ),

                              Column(
                                children: <Widget>[
                                  
                                 
                                    Container(
                                height:50,
                                width:60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("https://via.placeholder.com/150/000000/FFFFFF/?text=No image")),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                
                                child: Image.network(
                                  'https://www.cricbuzz.com/stats/flags/web/official_flags/team_${cricdata[i]['team2']['id']}.png',
                                  scale: 1,fit: BoxFit.cover,
                                ),
                              ),
                                  Container(
                                  //  width: 50,
                                   child: Text(cricdata[i]["team2"]["name"],
                                   //style: TextStyle(color: Colors.white)
                                   )),
                                ],
                              ),
                             
                            ],
                          ),
                        ),
                         Padding(
                           padding: const EdgeInsets.all(2.0),
                           child: Text(cricdata[i]['series_name'],style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
                         ),
                         Flexible(child: Text("Venu: ${cricdata[i]['venue']['name']} at ${cricdata[i]['venue']['location']}",
                         style: TextStyle(fontWeight: FontWeight.w500,fontSize:10,color: Colors.black)
                         ),),
                         Text(cricdata[i]['header']['status'],
                         //style: TextStyle(color: Colors.white)
                         )
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
