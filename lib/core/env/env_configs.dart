import 'app_state.dart';

void envConfig() {
  const environment =
      String.fromEnvironment('environment', defaultValue: 'production');
  StateHandler _appState = StateHandler(environment);
  _appState.init();
}
