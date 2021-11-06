import 'package:flutter/material.dart';
import 'package:tables/table_page.dart';
import 'package:tables/table_selection_page.dart';
import 'package:tables/table_selection_viewmodel.dart';
import 'package:viewmodelscope/viewmodelscope.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ViewModelScope(
      viewModel: TableSelectionViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ViewModelConsumer<TableSelectionViewModel>(
            builder: (context, vm, _) {
          if (vm.state is EmptySelection) return const TableSelectionPage();
          return const TablePage();
        }),
      ),
    );
  }
}
