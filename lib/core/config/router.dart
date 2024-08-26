import 'package:go_router/go_router.dart';

import '../../features/home/pages/home_page.dart';
import '../../features/home/pages/settings_page.dart';
import '../../features/splash/onboard_page.dart';
import '../../features/splash/splash_page.dart';
import '../../features/univer/pages/add/add_pros_page.dart';
import '../../features/univer/pages/add/add_specialization_page.dart';
import '../../features/univer/pages/add/add_univer_page.dart';
import '../../features/univer/pages/edit/edit_pros_page.dart';
import '../../features/univer/pages/edit/edit_specialization_page.dart';
import '../../features/univer/pages/edit/edit_univer_page.dart';
import '../../features/univer/pages/univer_detail_page.dart';
import '../models/university.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboard',
      builder: (context, state) => const OnboardPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/add1',
      builder: (context, state) => const AddUniverPage(),
    ),
    GoRoute(
      path: '/add2',
      builder: (context, state) => AddProsPage(
        university: state.extra as University,
      ),
    ),
    GoRoute(
      path: '/add3',
      builder: (context, state) => AddSpecializationPage(
        university: state.extra as University,
      ),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) => UniverDetailPage(
        university: state.extra as University,
      ),
    ),
    GoRoute(
      path: '/edit1',
      builder: (context, state) => EditUniverPage(
        university: state.extra as University,
      ),
    ),
    GoRoute(
      path: '/edit2',
      builder: (context, state) => EditProsPage(
        university: state.extra as University,
      ),
    ),
    GoRoute(
      path: '/edit3',
      builder: (context, state) => EditSpecializationPage(
        university: state.extra as University,
      ),
    ),
  ],
);
