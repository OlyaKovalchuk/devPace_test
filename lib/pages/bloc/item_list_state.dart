import 'package:equatable/equatable.dart';

abstract class ItemListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitState extends ItemListState {}

class ProgressState extends ItemListState {}

class ReceivedItemState extends ItemListState {
  ReceivedItemState(this.itemName);

  final String itemName;

  @override
  List<Object?> get props => [itemName];
}

class RemovedItemState extends ItemListState {}

class ErrorState extends ItemListState {
  ErrorState({
    this.title,
    this.message,
  });

  final String? title;
  final String? message;

  @override
  List<Object?> get props => [title, message];
}
