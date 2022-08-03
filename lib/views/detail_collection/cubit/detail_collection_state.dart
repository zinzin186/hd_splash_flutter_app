// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_collection_cubit.dart';


class DetailCollectionState extends Equatable {
  const DetailCollectionState(
      {required this.collection,
      this.statusType = StatusType.init,
      this.photos = const [],
      this.currentIndex = 1});
  final StatusType statusType;
  final List<Photo> photos;
  final Collection collection;
  final int currentIndex;

  @override
  List<Object> get props => [statusType, photos, currentIndex];

  DetailCollectionState copyWith(
      {StatusType? statusType,
      List<Photo>? photos,
      Collection? collection,
      int? currentIndex}) {
    return DetailCollectionState(
        statusType: statusType ?? this.statusType,
        photos: photos ?? this.photos,
        collection: collection ?? this.collection,
        currentIndex: currentIndex ?? this.currentIndex);
  }
}
