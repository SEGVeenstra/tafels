import 'package:viewmodelscope/viewmodelscope.dart';

class TableSelectionViewModel extends ViewModel<TableSelectionState> {
  TableSelectionViewModel() : super(initialState: EmptySelection());

  Future<void> selectTable(int table) async {
    setState(TableSelected(selectedTable: table));
  }

  Future<void> clearSelection() async {
    setState(EmptySelection());
  }
}

abstract class TableSelectionState {}

class EmptySelection extends TableSelectionState {}

class TableSelected extends TableSelectionState {
  final int selectedTable;

  TableSelected({required this.selectedTable});
}
