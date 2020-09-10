import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes/note_model.dart';
import 'dart:math';

// ignore: must_be_immutable
class AddNote extends StatefulWidget {
  bool update;
  String updateTitle;
  String updateSubtitle;
  int updateKey;
  final Box<Note> notesBox;
  AddNote(
      {@required this.notesBox,
      this.updateTitle,
      this.updateSubtitle,
      this.update,this.updateKey});

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    String title;
    String subtitle;

    Random random = new Random();
    int randomNumber = random.nextInt(5000);


    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  showDialog(
                      context: context,
                      child: Center(
                        child: AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Are You Sure ?",
                                  style: TextStyle(fontSize: 25)),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RaisedButton(
                                    onPressed: () {
                                      widget.notesBox.delete(widget.updateKey);
                                      setState(() {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      "No",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.redAccent,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ));
                });
              }),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              onPressed: () {
                widget.notesBox.put(
                  widget.update ? widget.updateKey :widget.notesBox.length + randomNumber,
                  Note(title: title, subtitle: subtitle),
                );
                print("hello there $title");

                Navigator.pop(context);
              },
              color: Colors.green,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
        title: Text(
          "NOTE",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Color(0xfff5f5f5),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 10),
        child: Container(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  maxLines: null,
                  onChanged: (val){
                      title = val;
                  },
                  initialValue: widget.update ? widget.updateTitle : "",
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 40),
                ),
                TextFormField(
                  initialValue: widget.update ? widget.updateSubtitle : "",
                  maxLines: null,
                  onChanged: (val){
                      subtitle = val;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write Here...",
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 25),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
