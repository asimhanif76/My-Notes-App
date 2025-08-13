import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controllers/home_page_controller.dart';
import 'package:notes_app/Utils/custom_snack_bar.dart';
import 'package:notes_app/Widgets/my_button.dart';

class WriteNoteScreen extends StatelessWidget {
  int? index;
  String? noteName;
  WriteNoteScreen({super.key, this.index, this.noteName});

  HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(noteName ?? "Write Note"),
        titleTextStyle: TextStyle(
          color: Colors.purple,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: Colors.purple.shade50,
        iconTheme: IconThemeData(color: Colors.purple),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() => homePageController.isNewNote.value
              ? SizedBox()
              : Container(
                  margin: EdgeInsets.only(right: 20),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    homePageController.notes[index!]['createdAt'] != null
                        ? (homePageController.notes[index!]['createdAt']
                                as Timestamp)
                            .toDate()
                            .toString()
                            .split('.')[0]
                        : '',
                  ),
                )),
          Expanded(
            child: TextField(
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top, // Top align vertically

              controller: homePageController.noteController,
              decoration: InputDecoration(
                  hintText: 'Write your note here...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.shade50.withOpacity(0.6),
                  filled: true),
              maxLines: null, // null ka matlab unlimited lines
              expands: true, // pura available height cover karega
            ),
          ),
          Padding(
            padding: EdgeInsets.all(11),
            child: MyButton(
                color: Colors.purple.shade300,
                widget: Text(
                  'Save Note',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  if (homePageController.isNewNote.value) {
                    try {
                      homePageController.saveNote(context);
                      homePageController.noteNameController.clear();
                      homePageController.noteController.clear();
                      Navigator.pop(context);
                      CustomSnackBar.showSuccess(
                          message: 'Note Saved', context: context);
                      print('Add New Note');
                    } catch (e) {
                      CustomSnackBar.showError(
                          message: '${e.toString().split(']')[1].trim()}',
                          context: context);
                    }
                  } else if (homePageController.isNewNote.value == false) {
                    try {
                      homePageController.updateNote(
                          homePageController.notes[index!]['id'], context);
                      homePageController.noteNameController.clear();
                      homePageController.noteController.clear();
                      Navigator.pop(context);
                      CustomSnackBar.showSuccess(
                          message: 'Secussfully Updated', context: context);
                      print('Update Note');
                    } catch (e) {
                      CustomSnackBar.showError(
                          message: '${e.toString().split(']')[1].trim()}',
                          context: context);
                    }
                  }
                }),
          ),
        ],
      ),
    );
  }
}
