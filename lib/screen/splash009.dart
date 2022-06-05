import 'package:flutter/material.dart';
import 'package:flutterapp/screen/main_tabs008.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/screen/login_member004.dart';

// #009 ScreenSplash
class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  void initDb() async {
    ServiceModel proService = Provider.of<ServiceModel>(context, listen: false);
    await proService.db.dbOpen();
    //await proService.db.dbEliminate();
    //await proService.db.dbCreate();
    dynamic list = await proService.db.dbSelect();
    for (int idx = 0; idx < list.length; idx++) {
      Service service = Service(
        list[idx]['name'],
        Account(list[idx]['accountId'], list[idx]['accountPw']),
        Payment(list[idx]['paymentType'], list[idx]['paymentDetail'],
            list[idx]['paymentNext']),
        Membership(list[idx]['membershipType'], list[idx]['membershipCost']),
      );
      service.changeStatus(200);
      proService.add(service);
    }

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
            mainAxisAlignment: MainAxisAlignment.start,
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
