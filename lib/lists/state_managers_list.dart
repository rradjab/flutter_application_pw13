import 'package:flutter/material.dart';
import 'package:flutter_application_pw13/screens/fish_redux_ui.dart';
import 'package:flutter_application_pw13/screens/flutter_bloc_ui.dart';
import 'package:flutter_application_pw13/screens/flutter_bloc_cubit_ui.dart';
import 'package:flutter_application_pw13/screens/flutter_bloc_stream_controller_ui.dart';
import 'package:flutter_application_pw13/screens/flutter_mobx_ui.dart';
import 'package:flutter_application_pw13/screens/flutter_redux_ui.dart';
import 'package:flutter_application_pw13/screens/flutter_riverpod_ui.dart';
import 'package:flutter_application_pw13/screens/hooks_riverpod_ui.dart';
import 'package:flutter_application_pw13/screens/simple_state_management_ui.dart';

Map<String, Widget> approaches = {
  'Simple State Management': const SimpleStateExample(),
  'Flutter Riverpod': const RiverpodExample(),
  'Hooks Riverpod': const RiverpodHooksExample(),
  'Flutter Bloc': BlocExample(),
  'Flutter Cubit': BlocCubitExample(),
  'Flutter Bloc - StreamController': const BlocStreamExample(),
  'Flutter Redux': ReduxExample(),
  'Fish Redux': const FishReduxExample(),
  'Flutter Mobx': MobxExample(),
};
