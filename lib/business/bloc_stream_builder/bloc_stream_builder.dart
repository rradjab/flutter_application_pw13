import 'dart:async';
import 'package:flutter_application_pw13/business/bloc_stream_builder/bloc_stream_builder_events.dart';

class ECommerceBloc {
  List<int> list = [];
  final _streamController = StreamController<List<int>>();

  Stream<List<int>> get myStream => _streamController.stream;

  void dispose() {
    _streamController.close();
  }

  void processEvent(ECommerceEvent action) async {
    list = [...list, action.element];
    _streamController.sink.add(list);
  }
}
