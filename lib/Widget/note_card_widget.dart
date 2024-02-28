import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/note_model.dart';


final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    // final color = _lightColors[index % _lightColors.length];
    // final time = DateFormat.yMMMd().format(note.createdTime);
    var time=TimeOfDay.now();

    return Card(
      // color: color,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 4),
            Text(
              note.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              note.description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                time.toString(),
                style: TextStyle(color: Colors.grey.shade700,fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }


}