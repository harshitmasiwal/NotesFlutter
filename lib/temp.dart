// import 'package:flutter/material.dart';
// import 'package:notes/data/DBHelper.dart';

// class Homepage extends StatefulWidget {
//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   List<Map<String, dynamic>> allNotes = [];
//   Dbhelper? dbref;

//   var rtitle = TextEditingController();
//   var rdesc = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     dbref = Dbhelper.getInstance;
//     getNotes();
//   }

//   void getNotes() async {
//     allNotes = await dbref!.getAllNotes();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('Notes')),
//         backgroundColor: Colors.purple.shade200,
//       ),
//       body:
//           allNotes.isNotEmpty
//               ? ListView.builder(
//                 itemCount: allNotes.length,
//                 itemBuilder: (_, index) {
//                   return ListTile(
//                     leading: Text(
//                       "${index + 1}",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     title: Text(
//                       allNotes[index][Dbhelper.TITLE_COL],
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     subtitle: Text(
//                       allNotes[index][Dbhelper.DESC_COL],
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     trailing: SizedBox(
//                       width: 60,
//                       child: Row(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               getBottomSheet(
//                                 context,
//                                 isupdate: true,
//                                 sno: allNotes[index][Dbhelper.S_NO_COL],
//                               );
//                               rtitle.text = allNotes[index][Dbhelper.TITLE_COL];
//                               rdesc.text = allNotes[index][Dbhelper.DESC_COL];
//                             },
//                             child: Icon(
//                               Icons.edit,
//                               color: Colors.grey.shade600,
//                               size: 20,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           InkWell(
//                             onTap: () async {
//                               bool flag = await dbref!.deleteNote(
//                                 sno: allNotes[index][Dbhelper.S_NO_COL],
//                               );
//                               if (flag) {
//                                 getNotes();
//                               }
//                             },
//                             child: Icon(
//                               Icons.delete,
//                               color: Colors.grey.shade700,
//                               size: 20,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )
//               : Center(
//                 child: Text(
//                   "No Notes yet!",
//                   style: TextStyle(color: Colors.grey.shade700),
//                 ),
//               ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           rtitle.clear();
//           rdesc.clear();
//           await getBottomSheet(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Future<void> getBottomSheet(
//     BuildContext context, {
//     bool isupdate = false,
//     int sno = 0,
//   }) async {
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: SingleChildScrollView(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxHeight: constraints.maxHeight,
//                     ),
//                     child: IntrinsicHeight(
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(isupdate ? "Update Note" : "Add Note"),
//                             SizedBox(height: 20),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: TextField(
//                                 controller: rtitle,
//                                 textInputAction: TextInputAction.next,
//                                 decoration: InputDecoration(
//                                   hintText: "Enter the title here",
//                                   labelText: "Title",
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(11),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(11),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//                               child: TextField(
//                                 maxLines: 8,
//                                 controller: rdesc,
//                                 decoration: InputDecoration(
//                                   hintText: "Enter the Description here",
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(11),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(11),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: OutlinedButton(
//                                       style: OutlinedButton.styleFrom(
//                                         backgroundColor: Colors.black,
//                                       ),
//                                       onPressed: () async {
//                                         var title = rtitle.text;
//                                         var desc = rdesc.text;
//                                         if (title.isNotEmpty &&
//                                             desc.isNotEmpty) {
//                                           bool check =
//                                               isupdate
//                                                   ? await dbref!.updateNote(
//                                                     title: title,
//                                                     desc: desc,
//                                                     sno: sno,
//                                                   )
//                                                   : await dbref!.addNote(
//                                                     mTitle: title,
//                                                     mDesc: desc,
//                                                   );
//                                           if (check) {
//                                             Navigator.pop(context);
//                                             rtitle.clear();
//                                             rdesc.clear();
//                                             getNotes();

//                                             ScaffoldMessenger.of(
//                                               context,
//                                             ).showSnackBar(
//                                               SnackBar(
//                                                 content: Text(
//                                                   isupdate
//                                                       ? "Note updated successfully!"
//                                                       : "Note added successfully!",
//                                                 ),
//                                                 backgroundColor:
//                                                     Colors.purple.shade200,
//                                                 duration: Duration(seconds: 2),
//                                               ),
//                                             );
//                                           }
//                                         } else {
//                                           Navigator.pop(context);
//                                           ScaffoldMessenger.of(
//                                             context,
//                                           ).showSnackBar(
//                                             SnackBar(
//                                               content: Text(
//                                                 "Please fill in all the fields!",
//                                               ),
//                                               backgroundColor:
//                                                   Colors.grey.shade900,
//                                               duration: Duration(seconds: 2),
//                                             ),
//                                           );
//                                         }
//                                       },
//                                       child: Text(
//                                         isupdate ? "Update Note" : "Add Note",
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: 5),
//                                   Expanded(
//                                     child: OutlinedButton(
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text(
//                                         "Cancel",
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }







