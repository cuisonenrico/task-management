import 'package:async_redux/async_redux.dart';
import 'package:task_management/state/app_state.dart';

/// Update [counter] in state based on Offset
class CounterAction extends ReduxAction<AppState> {
  CounterAction(this.offset);

  final int offset;
  @override
  AppState reduce() => state.copyWith(counter: state.counter + offset);
}

class SetLoginSuccessEvt extends ReduxAction<AppState> {
  SetLoginSuccessEvt(this.didSucceed);

  final bool didSucceed;
  @override
  AppState reduce() => state.copyWith(loginSuccessEvt: Event(didSucceed));

  @override
  void after() {
    // dispatch(SetUserLoggedInStatus(true));
    super.after();
  }
}

// /// Sets [isLoggedIn] status in state
// class SetUserLoggedInStatus extends ReduxAction<AppState> {
//   SetUserLoggedInStatus(this.isLoggedIn);
//
//   final bool isLoggedIn;
//
//   @override
//   AppState reduce() => state.copyWith.userState(isLoggedIn: isLoggedIn);
// }
