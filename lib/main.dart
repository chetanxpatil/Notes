import 'dart:io';
import 'package:flutter/material.dart';
import 'package:notes/note/note_tile.dart';
import 'note_model.dart';
import 'note/add_note.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await path.getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>("notes");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Box<Note> notesBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesBox = Hive.box<Note>("notes");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNote(
                notesBox: notesBox,
                update: false,
                updateTitle: "",
                updateSubtitle: "",
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text(
          "NOTE",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Color(0xfff5f5f5),
        elevation: 0,
      ),
      body: Container(
        child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ValueListenableBuilder(
                valueListenable: notesBox.listenable(),
                builder: (context, Box<Note> notes, _) {
                  return ListView.builder(
                    itemCount: notes.keys.toList().length,
                    itemBuilder: (context, index) {
                      final key = notesBox.keys.toList()[index];
                      final title = notesBox.get(key).title;
                      final subtitle = notesBox.get(key).subtitle;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNote(
                                notesBox: notesBox,
                                update: true,
                                updateSubtitle: subtitle,
                                updateTitle: title,
                                updateKey: key,
                              ),
                            ),
                          );
                        },
                        child: NoteTile(
                          title: title,
                          subtitle: subtitle,
                        ),
                      );
                    },
                  );
                })),
      ),
    );
  }
}
