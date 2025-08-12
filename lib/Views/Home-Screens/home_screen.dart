import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controllers/home_page_controller.dart';
import 'package:notes_app/Utils/app_size.dart';
import 'package:notes_app/Views/Home-Screens/write_note_screen.dart';
import 'package:notes_app/Views/SignIn-SignUp-Screens/sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    double w = AppSize.width(context);
    double h = AppSize.height(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Notes"),
        centerTitle: true,
        backgroundColor: Colors.purple.shade50,
        iconTheme: IconThemeData(color: Colors.purple),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
              ),
              child: Text(
                'Notes App',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              trailing: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Settings'),
              trailing: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('LogOut'),
              trailing: Icon(Icons.logout),
              onTap: () {
                homePageController.notes.clear();
                FirebaseAuth.instance.signOut().then(
                  (value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ));
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Obx(() => homePageController.notes.isEmpty
          ? Center(
              child: Text(
                "No notes yet!",
                style: TextStyle(fontSize: 18, color: Colors.purple.shade100),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: homePageController.notes.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.purple.shade50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      homePageController.isNewNote.value = false;
                      homePageController.noteNameController.text =
                          homePageController.notes[index]['noteName'] ??
                              'Note Name';
                      homePageController.noteController.text =
                          homePageController.notes[index]['note'] ??
                              'Note Content';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WriteNoteScreen(
                            index: index,
                            noteName: homePageController.notes[index]
                                    ['noteName'] ??
                                'Note Name',
                          ),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.edit_note_outlined,
                      color: Colors.purple,
                      // size: 18,
                    ),
                    title: Text(
                      homePageController.notes[index]['noteName'] ??
                          "Note Name",
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        final noteId = homePageController.notes[index]['id'];
                        homePageController.deleteNote(noteId);

                        homePageController.notes.removeAt(index);
                      },
                    ),
                  ),
                );
              },
            )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade200,
        shape: CircleBorder(),
        onPressed: () {
          homePageController.isNewNote.value = true;
          homePageController.noteNameController.clear();
          homePageController.noteController.clear();

          showAddNoteDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showAddNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Note Name"),
          content: TextField(
            controller: homePageController.noteNameController,
            decoration: InputDecoration(
              hintText: "Enter your note name here",
            ),
            maxLength: 40,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (homePageController.noteNameController.text.isNotEmpty) {
                  // homePageController.notes
                  //     .add(homePageController.noteNameController.text);
                  // homePageController.noteNameController.clear();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WriteNoteScreen(
                            noteName: homePageController.noteNameController.text
                                .trim()),
                      ));
                }
              },
              child: Text("Add"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _openCustomDrawer(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 300,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                  ),
                  child: Text(
                    'Notes App',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Home'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  title: Text('Settings'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
