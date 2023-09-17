import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pet/Event.dart';
import 'package:pet/HomeScreen.dart';
import 'package:pet/Screen2.dart';
import 'package:table_calendar/table_calendar.dart';
/*
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SchedulePage(),
  ));
}
*/
class SchedulePage extends StatefulWidget {
  final String petName;

  SchedulePage({required this.petName});
  @override

  _MySchedulePageState createState() => _MySchedulePageState();
}

class _MySchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsInDay(_selectedDay!));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsInDay(selectedDay);
      });
    }
  }

  List<Event> _getEventsInDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Schedule'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text("Event Name"),
                    content: Padding(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        controller: _eventController,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          events.addAll({
                            _selectedDay!: [Event(_eventController.text)]
                          });
                          Navigator.of(context).pop();
                          _selectedEvents.value =
                              _getEventsInDay(_selectedDay!);
                        },
                        child: Text("Enter"),
                      )
                    ],
                  );
                });
          },
          child: Icon(Icons.add)),
      body: Column(
        children: [
        //Text("Selected Day = " + _focusedDay.toString().split(" ")[0]),
          Container(
            child: TableCalendar(
              rowHeight: 60,
              headerStyle: const HeaderStyle(formatButtonVisible: false),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (_selectedDay) =>
                  isSameDay(_selectedDay, _focusedDay),
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: _onDaySelected,
              eventLoader: _getEventsInDay,
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: () => print(""),
                            title: Text('${value[index]}'),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
      bottomNavigationBar: GNav(
        backgroundColor: Color.fromARGB(255, 235, 156, 78),
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Color.fromARGB(255, 241, 186, 123),
        gap: 5,
        padding: EdgeInsets.all(20),
        tabs: [
          GButton(
            icon: Icons.chevron_left,
            text: 'Back',
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
          ),
          GButton(
            icon: Icons.home,
            text: 'Home',
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screen2(petName: widget.petName),
                  ),
                );
              },
          ),
          GButton(
            icon: Icons.map,
            text: 'Map',
          ),
          GButton(
            icon: Icons.alarm,
            text: 'Schedule',
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulePage(petName: widget.petName),
                  ),
                );
              },
          ),
        ],
      ),
    );
  }
}
