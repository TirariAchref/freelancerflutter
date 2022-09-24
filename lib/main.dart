import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:freelancerflutter/screens/loginscreen.dart';

import 'package:page_transition/page_transition.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import 'app.dart';

void main()  {

 final client = StreamChatClient(streamKey);
  runApp( MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,required this.client}) : super(key: key);
final StreamChatClient client;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: (context,child){
        return StreamChatCore(
          client: client,
          child: ChannelsBloc(child: UsersBloc(child: child!)),
        );
      },
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
         home: AnimatedSplashScreen(
            duration: 3000,
            splash: Image.asset(
                              'assets/images/logo.png',
                            
                               fit: BoxFit.fitWidth,
                          ),
            nextScreen: LoginScreen(),
            splashTransition: SplashTransition.fadeTransition,
            
            backgroundColor: Colors.white),
            

    );
    
  }
}
