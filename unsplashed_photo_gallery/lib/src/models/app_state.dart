import 'package:freezed_annotation/freezed_annotation.dart';
import 'app_user.dart';

import 'photo.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    AppUser? user,
    @Default(<Photo>[]) List<Photo> photos,
    @Default(false) bool isLoading,
    @Default(1) int page,
    @Default('') String query,
  }) = AppState$;

  factory AppState.fromJson(Map<dynamic, dynamic> json) => _$AppStateFromJson(Map<String, dynamic>.from(json));
}