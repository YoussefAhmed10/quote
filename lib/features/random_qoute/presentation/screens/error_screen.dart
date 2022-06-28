import 'package:flutter/material.dart';
import 'package:qoutes/config/locale/app_localizations.dart';
import 'package:qoutes/core/utils/app_colors.dart';
import 'package:qoutes/core/utils/mediaquery_values.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback? onPressed;
  const ErrorScreen({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: AppColors.primary,
              size: 200,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                AppLocalizations.of(context)!
                    .translate('something_went_wrong')!,
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.translate('try_again')!,
              style: TextStyle(
                color: AppColors.blackColor?.withOpacity(.6),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 50,
              width: context.width * 0.55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  onPrimary: Theme.of(context).primaryColor,
                  elevation: 500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  if (onPressed != null) {
                    onPressed!();
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.translate('reload_screen')!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
