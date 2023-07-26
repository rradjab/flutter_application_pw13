import 'package:flutter/material.dart';
import 'package:flutter_application_pw13/screens/fish_redux.dart';
import 'package:flutter_application_pw13/screens/flutter_bloc.dart';
import 'package:flutter_application_pw13/screens/flutter_bloc_cubit.dart';
import 'package:flutter_application_pw13/screens/flutter_bloc_stream_controller.dart';
import 'package:flutter_application_pw13/screens/flutter_mobx.dart';
import 'package:flutter_application_pw13/screens/flutter_redux.dart';
import 'package:flutter_application_pw13/screens/flutter_riverpod.dart';
import 'package:flutter_application_pw13/screens/hooks_riverpod.dart';
import 'package:flutter_application_pw13/screens/simple_state_management.dart';

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
