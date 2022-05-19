import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.redAccent,
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return Material(
            child: ListTile(
              title: const Text('Restaurant Notification'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: provider.isDailyNewsActive,
                    onChanged: (value) async {
                      scheduled.scheduledRestaurant(value);
                      provider.enableDailyNews(value);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
