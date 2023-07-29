import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_pw13/business/bloc/bloc_events.dart';
import 'package:flutter_application_pw13/business/bloc/bloc_states.dart';

List<int> list = [];

class ECommerceBloc extends Bloc<ECommerceEvent, ECommerceState> {
  ECommerceBloc() : super(ECommerceState(list: [])) {
    on<ECommerceEvent>((event, emit) async {
      list = [...list, event.element];
      emit(ECommerceState(list: list));
    });
  }
}
