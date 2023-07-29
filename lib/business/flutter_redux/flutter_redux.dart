class AppState {
  final List<int> productsList;

  AppState(this.productsList);
}

enum ActionType { addProduct }

class Action {
  final ActionType type;
  final int element;
  Action(this.type, {required this.element});
}

AppState reducer(AppState state, dynamic action) {
  if (action is Action) {
    switch (action.type) {
      case ActionType.addProduct:
        return AppState([...state.productsList, action.element]);
    }
  }
  return state;
}
