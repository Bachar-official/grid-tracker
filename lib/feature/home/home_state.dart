import 'package:flutter/material.dart';

@immutable
class HomeState {
  final int page;

  const HomeState({required this.page});

  const HomeState.initial() : page = 0;

  HomeState copyWith({int? page}) => HomeState(page: page ?? this.page);
}
