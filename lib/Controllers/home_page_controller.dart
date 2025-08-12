import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notes_app/Models/note_model.dart';

class HomePageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  TextEditingController noteNameController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  RxBool isNewNote = true.obs;

  RxList notes = [].obs;

  // Save note to Firestore
  // Future<void> saveNote() async {
  //   try {
  //     final noteName = noteNameController.text.trim();

  //     if (noteName.isEmpty || noteController.text.trim().isEmpty) {
  //       print("Note name or content is empty.");
  //       return;
  //     }

  //     print("Save Data Called");
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       // final note = NoteModel(
  //       //     title: noteNameController.text.trim(),
  //       //     content: noteController.text.trim(),
  //       //     createdAt: DateTime.now());
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(user.uid)
  //           .collection('notes') // specify collection name
  //           .doc() // auto-generated document ID
  //           .set({
  //         'noteName': noteName,
  //         'note': noteController.text.trim(),
  //         'createdAt': FieldValue.serverTimestamp(),
  //       });
  //     }

  //     print("Save Data Completed");
  //     fetchNotes();
  //   } catch (e) {
  //     print("Error saving data: $e");
  //   }
  // }


Future<void> saveNote() async {
  try {
    final noteName = noteNameController.text.trim();
    final noteContent = noteController.text.trim();

    if (noteName.isEmpty || noteContent.isEmpty) {
      print("Note name or content is empty.");
      return;
    }

    print("Save Data Called");
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final note = NoteModel(
        title: noteName, 
        content: noteContent,
        createdAt: DateTime.now()
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('notes')
          .doc() // Auto-generated document ID
          .set(note.toJson()); // Convert model to Map
    }

    print("Save Data Completed");
    fetchNotes();
  } catch (e) {
    print("Error saving data: $e");
  }
}


  // Fetch notes from Firestore
  Future<void> fetchNotes() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('notes') // specify collection name
            .orderBy('createdAt', descending: true)
            .get();

        notes.value = snapshot.docs
            .map((doc) => {
                  'id': doc.id, // <-- document ID add kiya
                  ...doc.data(),
                })
            .toList();
      }
    } catch (e) {
      print("Error fetching notes: $e");
    }
  }

  Future updateNote(String noteId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('notes')
            .doc(noteId) // ✅ Use existing document ID here
            .update({
          'noteName': noteNameController.text.trim(),
          'note': noteController.text.trim(),
        });
        fetchNotes();
      }
    } catch (e) {
      print("Error updating note: $e");
    }
  }

  Future deleteNote(String noteId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('notes') // specify collection name
            .doc(noteId)
            .delete();
        fetchNotes();
      }
    } catch (e) {
      print("Error deleting note: $e");
    }
  }
}
