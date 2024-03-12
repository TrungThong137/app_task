import 'package:app_task/src/resource/model/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreTodo {
  static Future<void> createTodoFirebase(ToDoModel todo) async {
    final doc = FirebaseFirestore.instance.collection('infoTodo_AppTask');
    await doc.add({
      'idUser': todo.idUser,
    }).then((value) => FirebaseFirestore.instance.collection('infoTodo_AppTask').doc(value.id)
      .set({
        'idUser': todo.idUser,
        'dateTime': todo.dateTime,
        'idTodo': value.id,
        'title': todo.title,
        'isCheckBox': todo.isCheckBox
      })
    );
  }

  static Future<void> removeTodoFirebase(String id) async{
    final bodyIndex= FirebaseFirestore.instance.collection('infoTodo_AppTask');
    await bodyIndex.doc(id).delete();
  }

  static Future<void> removeAllTodoFirebase(String id) async{
    final bodyIndex= FirebaseFirestore.instance.collection('infoTodo_AppTask');
    final userSnapshot= await bodyIndex.where('idUser', isEqualTo: id).get();
    for (DocumentSnapshot doc in userSnapshot.docs) {
      await doc.reference.delete();
    }
  }

  static Future<void> updateTodoFirebase(ToDoModel todo)async{
     await FirebaseFirestore.instance.collection('infoTodo_AppTask')
        .doc(todo.idTodo)
        .update(
          todo.toJson()
        );
  }
}
