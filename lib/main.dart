import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/social_layout.dart';
import 'modules/login_screen.dart';
import 'network/local/cacheHelper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  Widget widget;
  if(uId != null)
  {
    widget = SocialLayout();
  } else
  {
    widget = SocialLoginScreen();
  }


  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {

  late final Widget startWidget;
  MyApp({
    required this.startWidget,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:[
      BlocProvider(
        create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()..getUsers(),
      ),

    ] ,
        child:MaterialApp(
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          home: startWidget,
        )  );
  }
}

