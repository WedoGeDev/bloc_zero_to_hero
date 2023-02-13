import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
          appNotifications: false,
          emailNotifications: false,
        ));

  void toggleAppNotifications(bool newValue) =>
      emit(state.copyWith(appNotifications: newValue));

  void toggleEmailNotifications(bool newValue) =>
      emit(state.copyWith(emailNotifications: newValue));
}
