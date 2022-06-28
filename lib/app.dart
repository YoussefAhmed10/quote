import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qoutes/config/locale/app_localizations_setup.dart';
import 'package:qoutes/config/routes/app_routes.dart';
import 'package:qoutes/config/theme/app_theme.dart';

import 'package:qoutes/core/utils/app_string.dart';
import 'package:qoutes/features/splash/presentation/cubit/local_cubit.dart';
import 'package:qoutes/injection.dart' as di;

class QouteApp extends StatelessWidget {
  const QouteApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<LocaleCubit>()..getSavedLang(),
        )
      ],
      child: BlocBuilder<LocaleCubit, LocalStates>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            title: AppString.appName,
            theme: themeData(),
            // routes: routes,
            onGenerateRoute: AppRoute.onGenratedRoute,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            // home: const ErrorScreen(),
          );
        },
      ),
    );
  }
}
