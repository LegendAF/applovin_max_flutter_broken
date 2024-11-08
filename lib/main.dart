// ignore_for_file: avoid_print

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1.0),
        ),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  double _isOpacity = 1;

  @override
  void initState() {
    super.initState();

    initAppLovin();
  }

  void initAppLovin() async {
    await AppLovinMAX.initialize('VALID_SDK_KEY');

    AppLovinMAX.setHasUserConsent(true);
  }

  void _toggleOpacity() {
    setState(() {
      _isOpacity = _isOpacity == 1 ? 0 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (_) => Column(
            children: [
              Expanded(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    title: Text(widget.title),
                  ),
                  body: Container(
                    margin: const EdgeInsets.all(16),
                    child: const Text('Normal App Stuff'),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: _toggleOpacity,
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
        OverlayEntry(
          builder: (_) => Opacity(
            opacity: _isOpacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Content In Overlay Above Ad',
                    style: TextStyle(
                      fontSize: 10,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: MaxAdView(
                    adUnitId: "VALID_AD_UNIT_ID",
                    adFormat: AdFormat.banner,
                    isAutoRefreshEnabled: _isOpacity == 1 ? true : false,
                    extraParameters: const <String, String?>{
                      'adaptive_banner': 'true',
                    },
                    listener: AdViewAdListener(
                      onAdLoadedCallback: (MaxAd ad) =>
                          print('Banner Ad: Loaded from ${ad.networkName}'),
                      onAdLoadFailedCallback:
                          (String adUnitId, MaxError error) => print(
                              'Banner Ad: Failed to load with error code ${error.code} and message: ${error.message}'),
                      onAdClickedCallback: (MaxAd ad) =>
                          print('Banner Ad: Clicked'),
                      onAdExpandedCallback: (MaxAd ad) =>
                          print('Banner Ad: Expanded'),
                      onAdCollapsedCallback: (MaxAd ad) =>
                          print('Banner Ad: Collapsed'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
