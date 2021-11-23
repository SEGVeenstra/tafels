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
      );
    });
  }
}
