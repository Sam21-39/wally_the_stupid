import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wally_the_stupid/Auth/auth.dart';
import 'package:wally_the_stupid/Database/dataHandler.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Dashboard/dashbaord.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Like the Game? \n\nIf Yes, Then\n\n Sign In \nand \nDo more Challenges!!!',
              style: UI.appText.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
              textScaleFactor: 1.2,
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assets/images/wally.png',
              height: size.height * 0.16,
            ),
            Obx(
              () => SizedBox(
                width: size.width * 0.8,
                child: MaterialButton(
                  onPressed: () async {
                    isLoading.value = true;
                    final auth = Auth.instance;
                    final db = DataHandler.dataInstance;
                    final result = await auth.signInWithGoogle();
                    print(result);

                    if (result != false) {
                      final sp = await SharedPreferences.getInstance();
                      sp.setBool('isLogged', true);
                      db.initiateUserCreation();
                      Get.off(
                        () => DashBoardPage(
                          index: 0,
                        ),
                        popGesture: false,
                      );
                      // Fluttertoast.showToast(
                      //   msg: 'Some error occured. Try again later',
                      // );
                    } else {
                      isLoading.value = false;
                      Get.snackbar(
                        'Error',
                        'Some Error occured. Try again later!',
                      );
                    }
                  },
                  padding: const EdgeInsets.all(8.0),
                  child: isLoading.value
                      ? CircularProgressIndicator(
                          color: UI.appErrorColor,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              height: size.height * 0.05,
                            ),
                            Text(
                              'Sign In with Google',
                              style: UI.appText.copyWith(fontSize: 24.0),
                            ),
                          ],
                        ),
                  animationDuration: Duration(milliseconds: 700),
                  color: UI.appButtonColor,
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
