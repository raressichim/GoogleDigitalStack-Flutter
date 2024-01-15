// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'torrent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Torrent _$TorrentFromJson(Map<String, dynamic> json) {
  return Torrent$.fromJson(json);
}

/// @nodoc
mixin _$Torrent {
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TorrentCopyWith<Torrent> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TorrentCopyWith<$Res> {
  factory $TorrentCopyWith(Torrent value, $Res Function(Torrent) then) =
      _$TorrentCopyWithImpl<$Res, Torrent>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$TorrentCopyWithImpl<$Res, $Val extends Torrent>
    implements $TorrentCopyWith<$Res> {
  _$TorrentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Torrent$ImplCopyWith<$Res> implements $TorrentCopyWith<$Res> {
  factory _$$Torrent$ImplCopyWith(
          _$Torrent$Impl value, $Res Function(_$Torrent$Impl) then) =
      __$$Torrent$ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$Torrent$ImplCopyWithImpl<$Res>
    extends _$TorrentCopyWithImpl<$Res, _$Torrent$Impl>
    implements _$$Torrent$ImplCopyWith<$Res> {
  __$$Torrent$ImplCopyWithImpl(
      _$Torrent$Impl _value, $Res Function(_$Torrent$Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$Torrent$Impl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Torrent$Impl implements Torrent$ {
  const _$Torrent$Impl({required this.url});

  factory _$Torrent$Impl.fromJson(Map<String, dynamic> json) =>
      _$$Torrent$ImplFromJson(json);

  @override
  final String url;

  @override
  String toString() {
    return 'Torrent(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Torrent$Impl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Torrent$ImplCopyWith<_$Torrent$Impl> get copyWith =>
      __$$Torrent$ImplCopyWithImpl<_$Torrent$Impl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Torrent$ImplToJson(
      this,
    );
  }
}

abstract class Torrent$ implements Torrent {
  const factory Torrent$({required final String url}) = _$Torrent$Impl;

  factory Torrent$.fromJson(Map<String, dynamic> json) =
      _$Torrent$Impl.fromJson;

  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$Torrent$ImplCopyWith<_$Torrent$Impl> get copyWith =>
      throw _privateConstructorUsedError;
}
