import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pedometer/pedometer.dart';

import 'example_app.dart';


int steps = 0;

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  FlutterBackgroundService.initialize(onStart);

  runApp(ExampleApp());
}




Future<void> onStart() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stream<StepCount> _stepCountStream = Pedometer.stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream  = Pedometer.pedestrianStatusStream;

  _stepCountStream.listen(onStepCount);
  _pedestrianStatusStream.listen(onPedestrianStatusChanged);


  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    if (event!["action"] == "setAsForeground") {
      service.setForegroundMode(true);

      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });

  // bring to foreground
  service.setForegroundMode(true);
  Timer.periodic(Duration(seconds: 1), (timer) async {

    if (!(await service.isServiceRunning())) timer.cancel();

    service.setNotificationInfo(
      title: "My App Service",
      content: "Updated at $steps",
    );

    service.sendData(
      {"current_date": DateTime.now().toIso8601String()},
    );
  });
}

void onPedestrianStatusError(error) {
  /// Handle the error
}

void onStepCountError(error) {
  /// Handle the error
}

void onStepCount(StepCount event) {
  /// Handle step count changed
  print('onStepCount : ' + steps.toString());

  //코드작성

  //내부에 저장하고 서버에 저장하고


  steps = event.steps;

  FlutterBackgroundService().setNotificationInfo(
    title: "My App Service",
    content: "Updated at $steps",
  );
}

void onPedestrianStatusChanged(PedestrianStatus event) {
}



