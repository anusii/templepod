/// A Template for developing Solid Pod apps using Flutter.
///
// Time-stamp: <Friday 2024-08-16 14:54:14 +1000 Graham Williams>
///
/// Copyright (C) 2024, Software Innovation Institute, ANU.
///
/// Licensed under the GNU General Public License, Version 3 (the "License").
///
/// License: https://www.gnu.org/licenses/gpl-3.0.en.html.
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <https://www.gnu.org/licenses/>.
///
/// Authors: Graham Williams

library;

import 'package:flutter/material.dart';

import 'package:solidpod/solidpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:templepod/home.dart';
import 'package:templepod/utils/is_desktop.dart';

void main() async {
  // Support window size and top placement for desktop apps.

  if (isDesktop(PlatformWrapper())) {
    WidgetsFlutterBinding.ensureInitialized();

    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      // Setting [alwaysOnTop] here will ensure the app starts on top of other
      // apps on the desktop so that it is visible. We later turn it off as we
      // don't want to force it always on top.

      alwaysOnTop: true,

      // The [title] is used for the window manager's window title.

      title: 'Temple Pod',
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setAlwaysOnTop(false);
    });
  }

  // Ready to run the app.

  runApp(const TemplePod());
}

class TemplePod extends StatelessWidget {
  const TemplePod({super.key});

  // This widget is the root of our application.

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Temple Pod',
      home: SolidLogin(
        title: 'My Temple of Data',
        image: AssetImage('assets/images/image.png'),
        logo: AssetImage('assets/images/logo.png'),
        link: 'https://solidcommunity.au',
        webID: 'https://pods.solidcommunity.au',
        required: false,
        loginButtonStyle: LoginButtonStyle(
          background: Colors.lightGreenAccent,
          tooltip: 'You need to connect to your Solid Pod\n'
              'to save your saurvey results.',
        ),
        child: HomeScreen(),
      ),
    );
  }
}
