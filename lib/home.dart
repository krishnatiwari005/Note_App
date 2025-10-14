// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/providers/notes_provider.dart';

class Home extends ConsumerWidget {
 Home({super.key});

final formKey = GlobalKey<FormState>();
final notesCtrl = TextEditingController();
final txtFocusNode = FocusNode();

  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("NoteApp"),),
      body:Column(
        children: [
        Form(
          key: formKey,         
          autovalidateMode: AutovalidateMode.onUserInteraction,
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: notesCtrl,
                focusNode: txtFocusNode,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Please Enter some text";
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if(formKey.currentState!.validate()){
                 ref.read(notesProvider).onSaveNote(notesCtrl.text);
                 formKey.currentState!.save();
                  //clear input
                 notesCtrl.clear();
                 txtFocusNode.unfocus();
                 formKey.currentState!.reset();
                   // showing message

                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Note added"),
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.green,)
                 );
                }

            }, child: const Text("Submit"))
           ],
           ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NotesListView(),
            ),
          ),
        ],
      ),
    );
  }
}

class NotesListView extends ConsumerWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    final notesWatcher =ref.watch(notesProvider);
    
    return ListView.builder(
        itemCount: notesWatcher.notesList.length,
        itemBuilder: (BuildContext context,int index){
          return Card(
            child: ListTile(
              title: Text(notesWatcher.notesList[index].toString()),
              trailing: GestureDetector(
                onTap: () {
                  ref.read(notesProvider).onRemoveNote(index);

                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Note removed"),
                  duration: Duration(seconds: 3),
                  backgroundColor: const Color.fromARGB(255, 239, 46, 46),)
                 );


                },
                child: Icon(Icons.delete,color: Colors.red,)),
            ),
          );
        }
        );
  }
}