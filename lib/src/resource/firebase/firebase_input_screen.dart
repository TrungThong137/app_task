import 'package:app_task/src/resource/model/input_screen_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreInputScreen {
  static Future<void> createInputScreenFirebase(InputScreenModel inputScreen) async {
    final doc = FirebaseFirestore.instance.collection('inputScreen');
    await doc.add({
      'idUser': inputScreen.idUser,
    }).then((value) => FirebaseFirestore.instance.collection('inputScreen').doc(value.id)
      .set({
        'idUser': inputScreen.idUser,
        'bodyFat': inputScreen.bodyFat,
        'weight': inputScreen.weight,
        'dateTime': inputScreen.dateTime,
        'idIconStamp': inputScreen.idIconStamp,
        'note': inputScreen.note,
        'idInput': value.id,
      })
    );
  }

  static Future<void> removeInputScreenFirebase(String id) async{
    final bodyIndex= FirebaseFirestore.instance.collection('inputScreen');
    await bodyIndex.doc(id).delete();
  }

  static Future<void> removeAllInputScreenFirebase(String id) async{
    final bodyIndex= FirebaseFirestore.instance.collection('inputScreen');
    final userSnapshot= await bodyIndex.where('idUser', isEqualTo: id).get();
    for (DocumentSnapshot doc in userSnapshot.docs) {
      await doc.reference.delete();
    }
  }

  static Future<void> updateInputScreenFirebase(InputScreenModel inputScreenModel)async{
     await FirebaseFirestore.instance.collection('inputScreen')
        .doc(inputScreenModel.idUser)
        .update(
          inputScreenModel.toJson()
        );
  }
}
