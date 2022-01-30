import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wally_the_stupid/Database/staticData.dart';
import 'package:wally_the_stupid/UI/ui.dart';

class AboutPage extends StatelessWidget {
  final PackageInfo? packageInfo;
  const AboutPage({
    Key? key,
    this.packageInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StaticData.appName,
          style: UI.appText,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            StaticData.about,
            style: UI.appText.copyWith(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.justify,
          ),
          Divider(
            color: UI.appButtonColor,
          ),
          Text(
            '${StaticData.appCopywrit} ~ v.${packageInfo?.version}',
            style: UI.appText.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
