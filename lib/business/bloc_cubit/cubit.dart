import 'package:flutter_application_pw13/business/bloc_cubit/cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<int> list = [];

class ECommerceBloc extends Cubit<ECommerceState> {
  ECommerceBloc() : super(ECommerceState(list: []));

  void addProduct(int element) {
    list = [...list, element];
    emit(ECommerceState(list: list));
  }
}
