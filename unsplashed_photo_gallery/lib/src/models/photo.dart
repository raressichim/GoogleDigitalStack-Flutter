import 'package:freezed_annotation/freezed_annotation.dart';
import 'photo_urls.dart';

part 'photo.freezed.dart';

part 'photo.g.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    @JsonKey(name: 'alt_description') required String description,
    required PhotoUrls urls,
  }) = Photo$;

  factory Photo.fromJson(Map<dynamic, dynamic> json) =>
      _$PhotoFromJson(Map<String, dynamic>.from(json));
}
