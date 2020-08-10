import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

import 'admob_service.dart';

class AnuncioWidget extends StatefulWidget {
  @override
  _AnuncioWidgetState createState() => _AnuncioWidgetState();
}

class _AnuncioWidgetState extends State<AnuncioWidget> {
  final ams= AdMobService();

  @override
  void initState(){
    super.initState();
    Admob.initialize(ams.getAdMobAppId());
  }

  @override
  Widget build(BuildContext context) {
    return AdmobBanner(
      adUnitId: ams.getBannerAdId(),
      adSize: AdmobBannerSize.LEADERBOARD,
    );
  }



}
