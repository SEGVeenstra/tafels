import 'dart:math';

import 'package:viewmodelscope/viewmodelscope.dart';

class TableViewModel extends ViewModel<TableState> {
  final _random = Random();

  TableViewModel(int table) : super(initialState: TableLoading(table));

  Future<void> loadNewSum() async {
    setState(
      TableLoaded(
        state.table,
        sumNumber: _random.nextInt(10) + 1,
        answer: 0,
        score: 0,
      ),
    );
  }

  Future<void> setAnswer(int answer) async {
    if (state is TableLoaded) {
      final s = state as TableLoaded;
      setState(
        TableLoaded(
          state.table,
          sumNumber: s.sumNumber,
          answer: answer,
          score: s.score,
        ),
      );
    }
  }

  Future<void> submitAnswer() async {
    if (state is TableLoaded) {
      final s = state as TableLoaded;
      final isCorrect = s.table * s.sumNumber == s.answer;

      if (isCorrect) {
        setState(
          TableLoaded(
            s.table,
            answer: 0,
            score: s.score + 1,
            sumNumber: _random.nextInt(10) + 1,
          ),
        );
      } else {
        setState(
          TableLoadedWrong(
            s.table,
            answer: s.answer,
            score: s.score,
            sumNumber: s.sumNumber,
          ),
        );
      }
    }
  }
}

abstract class TableState {
  final int table;

  TableState(this.table);
}

class TableLoading extends TableState {
  TableLoading(int table) : super(table);
}

class TableLoaded extends TableState {
  final int sumNumber;
  final int answer;
  final int score;
  TableLoaded(
    int table, {
    required this.sumNumber,
    required this.answer,
    required this.score,
  }) : super(table);
}

class TableLoadedWrong extends TableLoaded {
  TableLoadedWrong(
    int table, {
    required int sumNumber,
    required int answer,
    required int score,
  }) : super(
          table,
          score: score,
          answer: answer,
          sumNumber: sumNumber,
        );
}