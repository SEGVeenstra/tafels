import 'dart:math';

import 'package:viewmodelscope/viewmodelscope.dart';

class TableViewModel extends ViewModel<TableState> {
  final _random = Random();

  TableViewModel(int table, int topLimit, bool includeZero)
      : super(
            initialState: TableLoading(
          table,
          topLimit,
          includeZero,
        ));

  Future<void> loadNewSum() async {
    int? previousNumber;

    if (state is! TableLoaded) {
      previousNumber = null;
    } else {
      previousNumber = (previousNumber as TableLoaded).sumNumber;
    }

    setState(
      TableLoaded(
        state.table,
        state.topLimit,
        state.includeZero,
        sumNumber: _nextNumber(
          previousNumber ?? 0,
          s.topLimit,
          s.includeZero,
        ),
        answer: null,
        score: 0,
      ),
    );
  }

  Future<void> setAnswer(int? answer) async {
    if (state is TableLoaded) {
      final s = state as TableLoaded;
      setState(
        TableLoaded(
          state.table,
          state.topLimit,
          state.includeZero,
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
            state.topLimit,
            state.includeZero,
            answer: null,
            score: s.score + 1,
            sumNumber: _nextNumber(
              s.sumNumber,
              s.topLimit,
              s.includeZero,
            ),
          ),
        );
      } else {
        setState(
          TableLoadedWrong(
            s.table,
            state.topLimit,
            state.includeZero,
            answer: s.answer,
            score: s.score,
            sumNumber: s.sumNumber,
          ),
        );
      }
    }
  }

  int _nextNumber(int previousNumber, int topLimit, bool includeZero) {
    final newNum = _random.nextInt(topLimit + (includeZero ? 1 : 0)) +
        (includeZero ? 0 : 1);

    if (newNum != previousNumber) return newNum;

    return _nextNumber(
      previousNumber,
      topLimit,
      includeZero,
    );
  }
}

abstract class TableState {
  final int table;
  final int topLimit;
  final bool includeZero;

  TableState(
    this.table,
    this.includeZero,
    this.topLimit,
  );
}

class TableLoading extends TableState {
  TableLoading(int table, int topLimit, bool includeZero)
      : super(
          table,
          includeZero,
          topLimit,
        );
}

class TableLoaded extends TableState {
  final int sumNumber;
  final int? answer;
  final int score;
  TableLoaded(
    int table,
    int topLimit,
    bool includeZero, {
    required this.sumNumber,
    required this.answer,
    required this.score,
  }) : super(
          table,
          includeZero,
          topLimit,
        );
}

class TableLoadedWrong extends TableLoaded {
  TableLoadedWrong(
    int table,
    int topLimit,
    bool includeZero, {
    required int sumNumber,
    required int? answer,
    required int score,
  }) : super(
          table,
          topLimit,
          includeZero,
          score: score,
          answer: answer,
          sumNumber: sumNumber,
        );
}
