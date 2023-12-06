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
          TextButton(
              onPressed: () {},
              child: Text(
                '保存',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '予定タイトル',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _eventController,
              decoration: InputDecoration(
                hintText: 'タイトル',
              ),
            ),
            SizedBox(height: 20),
            Text(
              '日時',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _eventController,
              decoration: InputDecoration(
                hintText: '日時を追加',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 予定を追加する処理
                if (_eventController.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    _eventController.text,
                  );
                }
              },
              child: Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
