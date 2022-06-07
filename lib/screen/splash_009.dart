import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/screen/login_member_004.dart';
import 'package:flutterapp/screen/main_tabs_008.dart';

// #009 ScreenSplash
class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  void initDb() async {
    UserModel proUser = Provider.of<UserModel>(context, listen: false);

    if(proUser.lengthUser == 0) {
      Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenLoginMember(),
                ));
          });
    }
    else {
      GroupModel proGroup = Provider.of<GroupModel>(context, listen: false);
      List<Group> group = proUser.items[0].groups;

      for(int i = 0; i < group.length; i++) {
        group[i].ott.changeStatus(200);
        proGroup.add(group[i]);
      }

      Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenMainTabs(),
              ));
        });
    }
  }

  @override
  void initState() {
    super.initState();
    initDb();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    //var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.384375),
              Center(
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.grey,
                    size: 100,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.0625),
            ],
          ),
        ),
      ),
    );
  }
}
