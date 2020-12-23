import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game_core/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Сугубо вертикальная ориентация экрана
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .whenComplete(() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    // 'MaterialApp' отвечает за дизайн как в андроиде
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false, // Убрать вывеску 'debug'
        home: Game()));
  });
}
