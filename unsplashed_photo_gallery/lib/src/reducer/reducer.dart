import 'dart:developer';

import 'package:redux/redux.dart';

import '../actions/change_picture.dart';
import '../actions/create_user.dart';
import '../actions/get_current_user.dart';
import '../actions/list_photos.dart';
import '../actions/login.dart';
import '../actions/set.dart';
import '../actions/sign_out.dart';
import '../models/app_state.dart';
import '../models/photo.dart';

// State + Action => State
AppState reducer(AppState state, dynamic action) {
  log('$action');

  return combineReducers<AppState>(<Reducer<AppState>>[
    TypedReducer<AppState, ListPhotosStart>(_listPhotosStart).call,
    TypedReducer<AppState, ListPhotosSuccessful>(_listPhotosSuccessful).call,
    TypedReducer<AppState, ListPhotosError>(_listPhotosError).call,
    TypedReducer<AppState, SetQuery>(_setQuery).call,
    TypedReducer<AppState, CreateUserSuccessful>(_createUserSuccessful).call,
    TypedReducer<AppState, GetCurrentUserSuccessful>(_getCurrentUserSuccessful).call,
    TypedReducer<AppState, SignOutSuccessful>(_signOutSuccessful).call,
    TypedReducer<AppState, LoginSuccessful>(_loginSuccessful).call,
    TypedReducer<AppState, ChangePictureSuccessful>(_changePictureSuccessful).call,
  ])(state, action);
}

AppState _listPhotosStart(AppState state, ListPhotosStart action) {
  return state.copyWith(isLoading: true);
}

AppState _listPhotosSuccessful(AppState state, ListPhotosSuccessful action) {
  return state.copyWith(
    isLoading: false,
    page: state.page + 1,
    photos: <Photo>[...state.photos, ...action.photos],
  );
}

AppState _listPhotosError(AppState state, ListPhotosError action) {
  return state.copyWith(isLoading: false);
}

AppState _setQuery(AppState state, SetQuery action) {
  return state.copyWith(
    query: action.query,
    page: 1,
    photos: <Photo>[],
  );
}

AppState _createUserSuccessful(AppState state, CreateUserSuccessful action) {
  return state.copyWith(user: action.user);
}

AppState _getCurrentUserSuccessful(AppState state, GetCurrentUserSuccessful action) {
  return state.copyWith(user: action.user);
}

AppState _signOutSuccessful(AppState state, SignOutSuccessful action) {
  return state.copyWith(user: null);
}

AppState _loginSuccessful(AppState state, LoginSuccessful action) {
  return state.copyWith(user: action.user);
}

AppState _changePictureSuccessful(AppState state, ChangePictureSuccessful action) {
  return state.copyWith(user: action.user);
}