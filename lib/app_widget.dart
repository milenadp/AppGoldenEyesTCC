import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_eyes/views/activity/new%20activity/new_activity_page.dart';
import 'package:golden_eyes/widgets/colors.dart';

import 'views/register/register_page.dart';
import 'views/register/recover_password_page.dart';
import 'views/activity/activity_options.dart';
import 'views/activity/register_activity.dart';
import 'views/activity/register_download.dart';
import 'views/activity/new activity/register_new_activity.dart';
import 'views/dog/dog_page.dart';
import 'views/dog/edit_dog.dart';
import 'views/dog/register_dog.dart';
import 'views/home/home_page.dart';
import 'views/login/login_page.dart';
import 'views/profile/edit_profile.dart';
import 'views/profile/profile_page.dart';
import 'views/role/role_page.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: COLOR_YELLOW));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Golden Eyes",
      initialRoute: '/',
      theme: ThemeData(
        scaffoldBackgroundColor: COLOR_LIGHT_GREY,
        appBarTheme: AppBarTheme(
          backgroundColor: COLOR_LIGHT_GREY,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),

        //account
        '/account/create': (context) => RegisterPage(),
        '/account/recover_password': (context) => RecoverPasswordPage(),

        //activity
        '/activity': (context) => NewActivityPage(),
        // '/activity/register': (context) => RegisterActivity(),
        '/activity/download': (context) => RegisterDownload(),
        '/activity/register_new_activity': (context) => RegisterNewActivity(),
        '/activity/options': (context) => ActivityOptions(),

        //dog
        '/dog': (context) => DogPage(),
        '/dog/register': (context) => RegisterDog(),
        '/dog/edit': (context) => EditDog(),

        //role
        '/role': (context) => RolePage(),

        //profile
        '/profile': (context) => ProfilePage(),
        '/profile/edit': (context) => EditProfile(),
      },
    );
  }
}
