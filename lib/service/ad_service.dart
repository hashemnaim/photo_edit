import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  static BannerAd? bannerAd;
  static InterstitialAd? interstitialAd;

  static initilizeBanner() {
    bannerAd = BannerAd(
        size:
            AdSize.banner, // test id "ca-app-pub-3940256099942544/6300978111",
        adUnitId: Platform.isAndroid
            ? "ca-app-pub-8645993540070406/2359966300"
            : Platform.isIOS
                ? "ca-app-pub-3940256099942544/2934735716"
                : '',
        listener: BannerAdListener(
            onAdLoaded: (ad) {
              if (kDebugMode) {
                print("Add Loaded $ad");
              }
            },
            onAdClicked: (a) {},
            onAdFailedToLoad: (ad, er) {
              if (kDebugMode) {
                print("ad failed to load ${er.toString()}");
              }
            }),
        request: const AdRequest());

    bannerAd!.load();
  }

  static initilizeInterstitial() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-8645993540070406/6981737592'
            : Platform.isIOS
                ? 'ca-app-pub-3940256099942544/4411468910'
                : '',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            if (kDebugMode) {
              print('InterstitialAd failed to load: $error');
            }
          },
        ));
  }
}
