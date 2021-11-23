import 'package:viewmodelscope/viewmodelscope.dart';

class SettingsViewModel extends ViewModel<SettingsState> {
  SettingsViewModel()
      : super(
          initialState: SettingsState(
            includeZero: true,
            topLimit: 10,
          ),
        );

  void setIncludeZero(bool includeZero) {
    setState(
      SettingsState(
        includeZero: includeZero,
        topLimit: state.topLimit,
      ),
    );
  }

  void setToplimit(int topLimit) {
    setState(
      SettingsState(
        includeZero: state.includeZero,
        topLimit: topLimit,
      ),
    );
  }
}

class SettingsState {
  final bool includeZero;
  final int topLimit;

  SettingsState({
    required this.includeZero,
    required this.topLimit,
  });
}
