import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '/widgets/fadeanimation.dart';
import 'dart:convert';
import 'package:vault_inmobia/models/login_response_model.dart';
import '../widgets/fadeanimation.dart';
import '../widgets/bottomnavigation.dart';
import '../widgets/history.dart';
import '../widgets/widgeticons.dart';
import '../services/api.dart';
import '../services/shared.dart';
import '../models/usermodel.dart';


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
                      child: const Icon(Icons.person_outlined,color: Colors.white,)
                  )
                ],),
            ),
          ],
        ),

        body: userProfile()
        //bottomNavigationBar: const boottomnavigationBar() // bottomNavigationBar custom...
    );

   /* return Scaffold(
      appBar: AppBar(
        title: Text('My Home'),
        //title: Text(SharedService.loginDetails().toString()),
        title: Text(SharedService.loginDetails().toString()),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              SharedService.logout(context);
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: userProfile(),
    );*/
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
                                                Text(kbody["data"]["amount"],style: const TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),),
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
                    // Icons custom button //
 /*                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        iconswidget(
                            title: "Send",
                            child: IconButton(onPressed: (){}, icon: const Icon(Icons.send),color: Colors.blue,),
                            color: const Color(0xFF17334E),
                            delayanimation: 1.5
                        ),
                        SizedBox(
                          width: we * 0.03,
                        ),
                        iconswidget(
                            title: "Pay",
                            child: IconButton(onPressed: (){}, icon: const Icon(Icons.payments),color: Colors.red,),
                            color: const Color(0xFF411C2E),
                            delayanimation: 1.7
                        ),
                        SizedBox(
                          width: we * 0.03,
                        ),
                        iconswidget(
                            title: "withdraw",
                            child: IconButton(onPressed: (){}, icon:
                            Image.asset("images/icons8-cash-withdrawal-96.png",
                              width: we * 0.08,
                              height: we * 0.08,
                              color: Colors.green,
                            ) ,),
                            color: const Color(0xFF163333),
                            delayanimation: 1.9
                        ),
                        SizedBox(
                            width: we * 0.03
                        ),
                        iconswidget(
                            title: "Bill",
                            child: IconButton(onPressed: (){}, icon: const Icon(Icons.receipt),color: Colors.purple,),
                            color: const Color(0xFF32204D),
                            delayanimation: 2.1
                        ),
                        SizedBox(
                          width: we * 0.03,
                        ),
                        iconswidget(
                            title: "voucher",
                            child: IconButton(onPressed: (){}, icon: Image.asset("images/icons8-voucher-96.png"
                              ,width: we * 0.08,
                              height: he * 0.08,
                              color: Colors.orange,
                            ),color: Colors.purple,),
                            color: const Color(0xFF412D27),
                            delayanimation: 2.3
                        ),
                      ],
                    ),
                    SizedBox(
                      height: he * 0.05,
                    ),
*/
                    // histories from wallet  ..  //
                    historywallet(
                        images: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Spotify_icon.svg/1982px-Spotify_icon.svg.png",
                        title: "Spotify Subscription",
                        day: "21Jun 2021",
                        postiveornagtive: "-",
                        money: "11.90",
                        time: "12:01 am"),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    historywallet(
                        images: "https://seeklogo.com/images/P/pinterest-logo-CA98998DCB-seeklogo.com.png",
                        title: "Pinterest Salary",
                        day: "20Jun 2021",
                        postiveornagtive: "+",
                        money: "63.0",
                        time: "09:0 pm"),
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
