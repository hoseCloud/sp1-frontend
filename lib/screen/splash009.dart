import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/screen/login_member004.dart';
import 'package:flutterapp/screen/main_tabs008.dart';

// #009 ScreenSplash
class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  void initDb() async {
    // 1. 로그인 시도
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
      // 2. 로그인 정보를 stats에 저장
      // login screen 에서 처리

      // 3. 계정에 저장된 서비스를 stats에 저장
      GroupModel proGroup = Provider.of<GroupModel>(context, listen: false);
      List<Group> group = proUser.items[0].groups;

      for(int i = 0; i < group.length; i++) {
        Group temp = Group.init();
        temp.ott = group[i].ott;
        proGroup.add(temp);
      }

      Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenMainTabs(),
              ));
        });
    }

    // 2. 로그인 정보를 stats에 저장
    // 3. 계정에 저장된 서비스를 DB와 stats에 저장
    // 4. 로그아웃시 DB에 저장된 정보를 삭제
    /*
    UserModel proUser = Provider.of<UserModel>(context, listen: false);
    await proUser.db.dbOpen();
    //await proUser.db.dbEliminate();
    //await proUser.db.dbCreate();
    dynamic userA = await proUser.db.dbIsAuto();
    User user = User('', '', '', 0);
    if (userA.length > 0) {
      user = User(
          userA[0]['id'], userA[0]['pw'], userA[0]['email'], userA[0]['auto']);
    }
    debugPrint('${user.id}, ${user.pw}, ${user.email}, ${user.auto}');

    Future.delayed(const Duration(seconds: 3), () {
      if (user.auto == 1) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenMainTabs(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenLoginMember(),
            ));
      }
    });
    */
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
