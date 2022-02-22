// ignore_for_file: unused_element

part of 'animation_bloc.dart';

abstract class PositionEvent extends Equatable {
  const PositionEvent();

  @override
  List<Object> get props => [];
}

class PositionStarted extends PositionEvent {
  const PositionStarted();
}

class _PositionStarted extends PositionEvent {
  const _PositionStarted(this.countPosition);

  final double countPosition;

  @override
  List<Object> get props => [countPosition];
}
