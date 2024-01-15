import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/photo.dart';
import 'app_action.dart';
part 'list_photos.freezed.dart';

@freezed
class ListPhotos with _$ListPhotos implements AppAction {
  const factory ListPhotos({
    @Default('') String genre,
  }) = ListPhotosStart;

  const factory ListPhotos.successful(List<Photo> photos) = ListPhotosSuccessful;

  @Implements<ErrorAction>()
  const factory ListPhotos.error(Object error, StackTrace stackTrace) = ListPhotosError;
}
