import 'package:flutter/material.dart';
import 'package:tables/settings/settings_page.dart';
import 'package:tables/table_selection_viewmodel.dart';
import 'package:viewmodelscope/viewmodelscope.dart';

class TableSelectionPage extends StatelessWidget {
  const TableSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welke tafel wil je oefenen?'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SettingsPage()));
              },
              icon: const Icon(
                Icons.settings,
              ),
            )
          ],
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          crossAxisCount: MediaQuery.of(context).size.width ~/ 160,
          children: List.generate(
            12,
            (index) => ElevatedButton(
              onPressed: () {
                context.vm<TableSelectionViewModel>().selectTable(index + 1);
              },
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ));
  }
}
