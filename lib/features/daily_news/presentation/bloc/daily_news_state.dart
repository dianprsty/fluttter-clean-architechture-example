part of 'daily_news_bloc.dart';

sealed class DailyNewsState extends Equatable {
  const DailyNewsState();
  
  @override
  List<Object> get props => [];
}

final class DailyNewsInitial extends DailyNewsState {}
