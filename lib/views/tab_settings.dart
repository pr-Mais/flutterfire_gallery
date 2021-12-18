import 'package:flutter/material.dart';

import '../theme/theme_provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  void onLogout() async {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: ListTile.divideTiles(
          tiles: [
            const ThemeSection(),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.logout_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: onLogout,
            )
          ],
          context: context,
        ).toList(),
      ),
    );
  }
}

class ThemeSection extends StatelessWidget {
  const ThemeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = FlutterFireTheme();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Theme',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        RadioListTile<ThemeMode>(
          title: Row(
            children: const [
              Icon(Icons.light_mode_rounded),
              SizedBox(width: 20),
              Text('Light'),
            ],
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          value: ThemeMode.light,
          groupValue: themeProvider.currentTheme,
          onChanged: themeProvider.setCurrentTheme,
        ),
        RadioListTile<ThemeMode>(
          title: Row(
            children: const [
              Icon(Icons.dark_mode_rounded),
              SizedBox(width: 20),
              Text('Dark'),
            ],
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          value: ThemeMode.dark,
          groupValue: themeProvider.currentTheme,
          onChanged: themeProvider.setCurrentTheme,
        ),
        RadioListTile<ThemeMode>(
          title: Row(
            children: const [
              Icon(Icons.phone_android_rounded),
              SizedBox(width: 20),
              Text('System'),
            ],
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          value: ThemeMode.system,
          groupValue: themeProvider.currentTheme,
          onChanged: themeProvider.setCurrentTheme,
        ),
      ],
    );
  }
}
