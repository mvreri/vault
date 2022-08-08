import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '/widgets/fadeanimation.dart';
import 'dart:convert';
import '../widgets/fadeanimation.dart';
import '../widgets/bottomnavigation.dart';
import '../widgets/history.dart';
import '../services/api.dart';
import '../services/shared.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: const Color(0xFF181B2A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF181B2A),
          elevation: 0,
          actions: [
            // custom appBar with animation ....
            FadeAnimation(
              delay: 1,
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("THE",style: TextStyle(color: Colors.grey),),
                      Text("Vault" ,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(left: 200,right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFF272A3F)
                      ),
                      //child: const Icon(Icons.person_outlined,color: Colors.white,)
                      child: IconButton(
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          SharedService.logout(context);
                        },
                      ),

                  )
                ],),
            ),
          ],
        ),

        body: userProfile()
      //bottomNavigationBar: const boottomnavigationBar() // bottomNavigationBar custom...
    );

  }

  Widget userProfile() {
    return FutureBuilder(
      future: APIService.getUserProfile(),
      builder: (
          BuildContext context,
          AsyncSnapshot<String> model,
          ) {
        if (model.hasData) {
          //return Center(child: Text(model.data!));
          final kbody = json.decode(model.data!);
          List<dynamic> tx = kbody["data"]["transactions"];
          var we = MediaQuery.of(context).size.width;
          var he  = MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            child: SafeArea(
              child: SizedBox(
                width: we,
                height: he,
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      delay: 1.5,
                      child: Swiper(
                        itemCount: 1,
                        layout: SwiperLayout.TINDER,
                        itemWidth:400,
                        itemHeight:  340 ,
                        itemBuilder: (c,i){
                          return Stack(
                            children: <Widget>[
                              Column(
                                  children: <Widget>[
                                    SizedBox(height: he * 0.015),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25)
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [Color(0xFFE96443),Color(0xFF904E95)],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomCenter
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color:Colors.grey.withOpacity(0.5),
                                                blurRadius: 7,
                                                offset: const Offset(0,3),
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(25)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(kbody["data"]["username"],style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25)),
                                                  SizedBox(
                                                    width:we * 0.5 ,
                                                  ),
                                                  Image.asset("images/amazon.png",
                                                    width: we * 0.07,
                                                    height: he * 0.07,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: he * 0.03,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(right: 100),
                                                child: Row(
                                                  mainAxisAlignment:MainAxisAlignment.center,
                                                  children:  <Widget>[
                                                    Text("Card No. "+kbody["data"]["number"],style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),

                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: he * 0.05,
                                              ),
                                              Container(
                                                  margin: const EdgeInsets.only(right: 200),
                                                  child: const Text("Available Balance",style: TextStyle(color: Colors.white),)),
                                              SizedBox(
                                                  height: he * 0.01
                                              ),
                                              Row(
                                                  children: <Widget>[
                                                    Image.asset("images/us-dollar.png",
                                                      width: we * 0.06,
                                                      height: we * 0.06,
                                                      color: Colors.white,
                                                    ),
                                                    Text("",style: const TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),),
                                                    SizedBox(
                                                        width: we * 0.45
                                                    ),
                                                    Image.asset('images/mastercard.png',
                                                        width: we * 0.09,
                                                        height: we * 0.09,
                                                        color: Colors.white
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ]
                              )
                            ],
                          );
                        },
                      ),
                    ), // cards ..

                    Text("Balance: "+kbody["data"]["amount"] ,style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                    SizedBox(
                      height: he * 0.05,
                    ),

                    // histories from wallet  ..  //
                    Container(
                        child: Column(
                            children: [
                              for ( var i in tx ) Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  historywallet(
                                      images: i["img"].toString(),
                                      title: i["type"].toString(),
                                      day: i["date"].toString(),
                                      postiveornagtive: "+",
                                      money: i["currency"].toString() + i["amount"].toString(),
                                      time: ""),
                                  SizedBox(
                                    height: he * 0.02,
                                  )
                                ],
                              ),
                            ]
                        )
                    ),

                  ],
                ),
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );

      },
    );
  }
}
