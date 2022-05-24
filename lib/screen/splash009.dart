import 'package:flutter/material.dart';
import 'package:flutterapp/screen/mainTabs008.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);


  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {

  void initDb() async {
    dynamic pro = Provider.of<ServiceModel>(context, listen: false);
    await pro.db.dbOpen();
    //await pro.db.dbEliminate();
    //await pro.db.dbCreate();
    dynamic list = await pro.db.dbSelect();
    for(int idx = 0; idx < list.length; idx++) {
      Service service = Service(
        list[idx]['name'],
        list[idx]['accountId'],
        list[idx]['accountPw'],
        list[idx]['paymentType'],
        list[idx]['paymentDetail'],
        list[idx]['paymentNext'],
        list[idx]['membershipType'],
        list[idx]['membershipCost'],
      );
      service.changeStatus(200);
      pro.add(service);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const ScreenMainTabs(),
      ));
    });
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