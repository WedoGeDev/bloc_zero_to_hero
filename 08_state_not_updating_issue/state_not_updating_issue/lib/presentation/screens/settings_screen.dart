import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/settings_cubit.dart';
import '../../logic/cubits/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  final Color color;
  final String title;

  const SettingsScreen({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(title),
      ),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          final snackBar = SnackBar(
            content: Text(
                'App ${state.appNotifications.toString().toUpperCase()}, '
                'Email ${state.emailNotifications.toString().toUpperCase()}'),
            duration: const Duration(
              milliseconds: 700,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Column(
              children: [
                SwitchListTile(
                  value: state.appNotifications,
                  title: const Text('App notifications'),
                  onChanged: (newValue) {
                    context
                        .read<SettingsCubit>()
                        .toggleAppNotifications(newValue);
                  },
                ),
                SwitchListTile(
                  value: state.emailNotifications,
                  title: const Text('Email notifications'),
                  onChanged: (newValue) {
                    context
                        .read<SettingsCubit>()
                        .toggleEmailNotifications(newValue);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
