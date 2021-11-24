import 'package:flutter/material.dart';
import 'package:tables/settings/settings_viewmodel.dart';
import 'package:viewmodelscope/viewmodelscope.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelConsumer<SettingsViewModel>(builder: (context, vm, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Instellingen'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 480),
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text('Laagste getal'),
                      trailing: Text(
                        '${vm.s.includeZero ? 0 : 1}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        vm.setIncludeZero(!vm.s.includeZero);
                      },
                    ),
                    ListTile(
                      title: const Text('Hoogste getal'),
                      trailing: Text(
                        '${vm.s.topLimit == 10 ? 10 : 12}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        vm.setToplimit(vm.s.topLimit == 10 ? 12 : 10);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
