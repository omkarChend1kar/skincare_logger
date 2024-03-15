import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetLangCubit extends Cubit<Locale> {
  SetLangCubit() : super(const Locale('en'));

  Future<void> setLocale(Locale locale) async {
    emit(locale);
  }
}

class LocaleIntance extends Locale implements Equatable {
  LocaleIntance(super.languageCode);

  @override
  List<Object?> get props => [languageCode];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}
