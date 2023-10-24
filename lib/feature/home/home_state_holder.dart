import 'package:grid_tracker/feature/home/home_state.dart';
import 'package:riverpod/riverpod.dart';

class HomeStateHolder extends StateNotifier<HomeState> {
  HomeStateHolder() : super(const HomeState.initial());

  void setPage(int page) {
    state = state.copyWith(page: page);
  }
}
