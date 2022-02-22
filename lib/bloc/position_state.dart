part of 'animation_bloc.dart';

abstract class PositionState extends Equatable {
  const PositionState();
  @override
  List<Object> get props => [];
}

class PositionInitial extends PositionState {}

class PositionSuccess extends PositionState {
  const PositionSuccess(this.count);
  final double count;

  @override
  List<Object> get props => [count];
}

class PositionComplete extends PositionState {
  const PositionComplete();
}
