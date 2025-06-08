import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/app_colors.dart';
import 'package:notes/db_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Addnotepage extends StatelessWidget {
  bool isupdate = false;
  int sno = 0;
  String title;
  String desc;
  // Dbhelper? dbref = Dbhelper.getInstance;
  TextEditingController tc = TextEditingController();
  TextEditingController dc = TextEditingController();

  Addnotepage({
    this.isupdate = false,
    this.sno = 0,
    this.title = "",
    this.desc = "",
  });

  @override
  Widget build(BuildContext context) {
    if (isupdate) {
      tc.text = title;
      dc.text = desc;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isupdate ? "Update Note" : "Add Note"),
        // backgroundColor: Colors.purple.shade200,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tc,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Enter the title here",
                    labelText: "Title",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: AppColors.borderbackground),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: AppColors.borderbackground),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextField(
                  maxLines: 8,
                  controller: dc,
                  decoration: InputDecoration(
                    hintText: "Enter the Description here",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: AppColors.borderbackground),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: AppColors.borderbackground),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () async {
                          var title = tc.text;
                          var desc = dc.text;
                          if (title.isNotEmpty && desc.isNotEmpty) {
                            if (isupdate) {
                              context.read<DbProvider>().updateNote(
                                title,
                                desc,
                                sno,
                              );
                              Navigator.pop(context);
                            } else {
                              context.read<DbProvider>().addNote(title, desc);
                              Navigator.pop(context);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isupdate
                                      ? "Note updated successfully!"
                                      : "Note added successfully!",
                                ),
                                backgroundColor: Colors.purple.shade200,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please fill in all the fields!"),
                                backgroundColor: Colors.grey.shade900,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Text(
                          isupdate ? "Update Note" : "Add Note",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: AppColors.borderbackground),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
