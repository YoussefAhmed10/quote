import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qoutes/features/random_qoute/presentation/cubit/random_qoute_cubit.dart';

import 'package:qoutes/features/random_qoute/presentation/screens/qoute_screen.dart';
import 'package:qoutes/features/splash/presentation/screens/splash_screen.dart';
import 'package:qoutes/injection.dart' as di;

import '../../core/utils/app_string.dart';

class Routes {
  static const String initialRoute = '/';
  static const String randomQuoteRoute = '/randomQuote';
}

// final routes = {
//   Routes.initialRoute: (context) => const QouteScreen(),
//   Routes.favouriteRoute: (context) => const FavouriteScreen(),
// };

class AppRoute {
  static Route? onGenratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: ((context) => const SplashScreen()),
        );
      case Routes.randomQuoteRoute:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (context) => di.sl<RandomQouteCubit>(),
                child: const QouteScreen(),
              )),
        );

      default:
    }
    return undefindRoute();
  }

  static Route<dynamic> undefindRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text(AppString.noRoute),
            ),
          )),
    );
  }
}
