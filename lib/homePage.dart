import 'package:flutter/material.dart';
import 'package:notes/AddNotePage.dart';
import 'package:notes/app_colors.dart';
import 'package:notes/data/DBHelper.dart';
import 'package:notes/db_provider.dart';
import 'package:notes/theme_provider.dart';
import 'package:provider/provider.dart';


class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<DbProvider>().getInitialNotes();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          alignment: Alignment.center,
          children: [Text(" 📝 Notes ")],
        ),
        // backgroundColor: Colors.grey.shade500,
        actions: [
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  height: 10,

                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 15),
                      Text('Settings'),
                    ],
                  ),

                  onTap: () async {
                    return showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Consumer<ThemeProvider>(
                          builder: (ctx, provider, __) {
                            return Container(
                              height: 180,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text("Settings"),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          // Icon(Icons.mode_night, size: 15),
                                          Text("Dark mode"),
                                          Expanded(child: SizedBox(width: 100)),
                                          Switch(
                                            value: provider.getThemeValue(),
                                            onChanged: (value) {
                                              provider.updatetheme(
                                                value: value,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () async {
                                          context
                                              .read<DbProvider>()
                                              .deleteAllNotes();
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Delete All Notes",
                                              style: TextStyle(
                                                color: Colors.red,
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
                          },
                        );
                      },
                    );
                  },
                ),
              ];
            },
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SizedBox(height: 2),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<DbProvider>(
                builder: (_, provider, __) {
                  List<Map<String, dynamic>> allNotes = provider.getNotes();

                  return allNotes.isNotEmpty
                      ? ListView.builder(
                        itemCount: allNotes.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            leading: Text(
                              "${index + 1}",
                              style: TextStyle(fontSize: 16),
                            ),
                            title: Text(
                              allNotes[index][Dbhelper.TITLE_COL],
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              allNotes[index][Dbhelper.DESC_COL],
                              style: TextStyle(fontSize: 15),
                            ),
                            trailing: SizedBox(
                              width: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Addnotepage(
                                              isupdate: true,
                                              title:
                                                  allNotes[index][Dbhelper
                                                      .TITLE_COL],
                                              desc:
                                                  allNotes[index][Dbhelper
                                                      .DESC_COL],
                                              sno:
                                                  allNotes[index][Dbhelper
                                                      .S_NO_COL],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.grey.shade600,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  InkWell(
                                    onTap: () {
                                      context.read<DbProvider>().deleteNote(
                                        allNotes[index][Dbhelper.S_NO_COL],
                                      );
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      : Center(
                        child: Text(
                          "No Notes yet!",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 25,
                          ),
                        ),
                      );
                },
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Addnotepage();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
