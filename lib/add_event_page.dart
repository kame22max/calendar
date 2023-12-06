// pages/add_event_page.dart
import 'package:flutter/material.dart';

class AddEventPage extends StatelessWidget {
  final TextEditingController _eventController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('予定を追加'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _eventController,
              decoration: InputDecoration(
                hintText: '予定のタイトルを入力',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'カラー',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '終日',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '開始',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '終了',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _eventController,
              decoration: InputDecoration(
                hintText: '日時を追加',
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
