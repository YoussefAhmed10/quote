import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qoutes/config/locale/app_localizations.dart';
import 'package:qoutes/core/utils/app_colors.dart';
import 'package:qoutes/features/random_qoute/presentation/cubit/random_qoute_cubit.dart';
import 'package:qoutes/features/random_qoute/presentation/screens/error_screen.dart';
import 'package:qoutes/features/random_qoute/presentation/widgets/qoute_content.dart';
import 'package:qoutes/features/splash/presentation/cubit/local_cubit.dart';

class QouteScreen extends StatefulWidget {
  const QouteScreen({Key? key}) : super(key: key);

  @override
  State<QouteScreen> createState() => _QouteScreenState();
}

class _QouteScreenState extends State<QouteScreen> {
  Future<void> getRandomQoute() =>
      RandomQouteCubit.get(context).getRandomQoute();

  @override
  void initState() {
    getRandomQoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                if (AppLocalizations.of(context)!.isEnLocale) {
                  LocaleCubit.get(context).toArbic();
                } else {
                  LocaleCubit.get(context).toEnglish();
                }
              },
              icon: Icon(
                Icons.translate_outlined,
                color: AppColors.primary,
              ),
            ),
            title: Text(AppLocalizations.of(context)!.translate('app_name')!),
          ),
          body: buildBodyContent(),
        ),
        onRefresh: () => getRandomQoute());
  }

  Widget buildBodyContent() {
    return BlocBuilder<RandomQouteCubit, RandomQouteStates>(
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => state is! RandomQouteIsLoadingState,
          widgetBuilder: (context) {
            if (state is RandomQouteSuccessState) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primary,
                      ),
                      child: QouteContent(qoute: state.qoute),
                    ),
                    const SizedBox(height: 20),
                    refreshContent(),
                  ],
                ),
              );
            } else {
              return Center(
                child: ErrorScreen(
                  onPressed: () {
                    getRandomQoute();
                  },
                ),
              );
            }
          },
          fallbackBuilder: (context) => Center(
            child: SpinKitFadingCircle(color: AppColors.primary),
          ),
        );
      },
    );
  }

  Widget refreshContent() {
    return InkWell(
      onTap: () {
        getRandomQoute();
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        child: const Icon(
          Icons.refresh,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }
}
