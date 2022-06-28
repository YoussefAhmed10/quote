part of 'local_cubit.dart';

abstract class LocalStates extends Equatable {
  final Locale locale;
  const LocalStates(this.locale);

  @override
  List<Object> get props => [locale];
}

class ChangeLocaleState extends LocalStates {
  final Locale localeSelected;
  const ChangeLocaleState(this.localeSelected) : super(localeSelected);
}
