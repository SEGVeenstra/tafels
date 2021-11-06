import 'package:flutter/material.dart';
import 'package:tables/table_selection_viewmodel.dart';
import 'package:tables/table_viewmodel.dart';
import 'package:viewmodelscope/viewmodelscope.dart';

class TablePage extends StatelessWidget {
  const TablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Los de sommen op!'),
        leading: BackButton(
          onPressed: () {
            context.vm<TableSelectionViewModel>().clearSelection();
          },
        ),
      ),
      body: ViewModelConsumer<TableSelectionViewModel>(
        builder: (context, vm, _) {
          final state = vm.state;
          if (state is TableSelected) {
            return ViewModelScope(
                viewModel: TableViewModel(state.selectedTable)..loadNewSum(),
                child: const TableContent());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class TableContent extends StatelessWidget {
  const TableContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelConsumer<TableViewModel>(
      builder: (context, vm, child) {
        final state = vm.state;
        if (state is TableLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (widget, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        child: widget,
                        scale: Tween(begin: 1.5, end: 1.0).animate(animation),
                      ),
                    );
                  },
                  child: Text(
                    'PUNTEN: ${state.score}',
                    key: ValueKey(state.score),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${state.sumNumber} x ${state.table} = ',
                        style: const TextStyle(
                            fontSize: 64, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 32),
                        color: state is TableLoadedWrong
                            ? Colors.red.shade200
                            : Colors.grey.shade300,
                        child: Text(
                          '${state.answer}',
                          style: const TextStyle(
                              fontSize: 64, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Input(),
                ),
              ),
            ],
          );
        }
        return Center(
          child: Text('${vm.state.table}'),
        );
      },
    );
  }
}

class Input extends StatelessWidget {
  const Input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelConsumer<TableViewModel>(builder: (context, vm, _) {
      final state = vm.state;
      if (state is! TableLoaded) {
        return const SizedBox.shrink();
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: state.answer == 0
                  ? null
                  : ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
              onPressed: state.answer == 0
                  ? null
                  : () {
                      context.vm<TableViewModel>().setAnswer(0);
                    },
              child: const Icon(
                Icons.delete,
                size: 54,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(
                      5,
                      (index) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.vm<TableViewModel>().setAnswer(
                                    state is TableLoadedWrong
                                        ? index + 1
                                        : _createNewAnswer(
                                            state.answer,
                                            index + 1,
                                          ),
                                  );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(
                      5,
                      (index) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.vm<TableViewModel>().setAnswer(
                                    state is TableLoadedWrong
                                        ? (index + 6) % 10
                                        : _createNewAnswer(
                                            state.answer,
                                            (index + 6) % 10,
                                          ),
                                  );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${(index + 6) % 10}',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: state.answer > 0 && state is! TableLoadedWrong
                  ? ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    )
                  : null,
              onPressed: state.answer > 0 && state is! TableLoadedWrong
                  ? () {
                      context.vm<TableViewModel>().submitAnswer();
                    }
                  : null,
              child: const Icon(
                Icons.send,
                size: 54,
              ),
            ),
          ),
        ],
      );
    });
  }

  int _createNewAnswer(int currentAnswer, int pressedNumber) {
    final newAnswer = int.parse('$currentAnswer$pressedNumber');
    return newAnswer < 1000 ? newAnswer : currentAnswer;
  }
}
