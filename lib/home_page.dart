import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
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
                  _focusedDay = focusedDay;
                });
              },
            ),
            EventList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEventPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EventProvider extends ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }
}

class Event {
  final String title;
  final DateTime date;

  Event(this.title, this.date);
}

class EventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Column(
      children: eventProvider.events.map((event) {
        return ListTile(
          title: Text(event.title),
          subtitle: Text(event.date.toString()),
        );
      }).toList(),
    );
  }
}

class AddEventPage extends StatelessWidget {
  final TextEditingController _eventController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _eventController,
              decoration: InputDecoration(labelText: 'Event Title'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final eventProvider = Provider.of<EventProvider>(context, listen: false);
                final String title = _eventController.text;
                final DateTime date = DateTime.now(); // 仮の日付、必要に応じて変更
                final Event event = Event(title, date);
                eventProvider.addEvent(event);
                Navigator.pop(context);
              },
              child: Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}

bool isSameDay(DateTime day1, DateTime day2) {
  return day1.year == day2.year && day1.month == day2.month && day1.day == day2.day;
}
