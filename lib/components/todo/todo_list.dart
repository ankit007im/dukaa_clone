import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dukaan_clone/components/todo/todo.dart';
import 'package:mobx/mobx.dart';
part 'todo_list.g.dart';

// @jsonSerializable
class TodoList = _TodoList with _$TodoList;

abstract class _TodoList with Store {
  @observable
  ObservableList<Todo> todos = ObservableList<Todo>();

  @action
  void addTodo(String description) {
    final todo = Todo(description);
    todos.add(todo);
  }

  @action
  void removeTodo(Todo todo) {
    todos.removeWhere((element) => element == todo);
  }

  @computed
  String get itemsDescription {
    if (todos.isEmpty) {
      return "There are no Todos here. Why don't you add one?.";
    }
    if (todos.length > 0) {
      return "";
    }
  }
}
