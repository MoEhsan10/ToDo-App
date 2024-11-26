import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/dataBase_Manager/model/todo_dm.dart';
import 'package:todo_app/dataBase_Manager/model/user_dm.dart';

class FireBaseFunctions {


  static CollectionReference getCollection() {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);

    return todoCollection;
  }


  static updateTask(TodoDM todo)async{
    CollectionReference todoCollection =getCollection();
    DocumentReference todoDoc =  todoCollection.doc(todo.id);
   await todoDoc.update(todo.toFireStore());
  }


  static updateIsDone(TodoDM todo)async{
    CollectionReference todoCollection =getCollection();
    DocumentReference todoDoc =  todoCollection.doc(todo.id);
    await todoDoc.update({'isDone' : todo.isDone});
  }
}
