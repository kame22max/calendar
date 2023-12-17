import 'package:calendar/add_event_page.dart';
import 'package:calendar/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now(); // 初期化を追加
  }

  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), //画面をタップした時に呼ばれる。
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                _selectedDay = _selectedDay.subtract(Duration(days: 30));
                // _controller.jumpToPage(_selectedDay);
              });
            },
          ),
          backgroundColor: Colors.pinkAccent,
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              DateFormat.yMMMM('ja_JP').format(_selectedDay),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.calendar_month),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  _selectedDay = _selectedDay.add(Duration(days: 30));
                  // _controller.jumpToPage(_selectedDay);
                });
              },
            ),

          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // _buildCalendarHeader(),
            TableCalendar(
              headerVisible: false,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false, //2weeksボタンの非表示
                titleCentered: true,
              ),
              locale: 'ja_JP',
              // ロケールを日本語に設定

              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // 更新することも可能
                });
              },
            ),
            Text('予定一覧'),
            Expanded(

              child: ListView.builder(
                itemCount: eventProvider.events.length,
                itemBuilder: (context, index) {
                  Event event = eventProvider.events[index];
                  return ListTile(
                    title: Text(event.title),
                    subtitle: Text(event.date.toString()),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pinkAccent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEventPage(),
                fullscreenDialog: true,
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }



// void _showBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         height: MediaQuery.of(context).size.height * 0.5, // 画面の半分までの高さ
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'This is a half-screen bottom sheet!',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Close'),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }//下から出る画面
}
