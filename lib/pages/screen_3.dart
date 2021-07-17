import 'package:flutter/material.dart';
import 'package:suitmedia/pages/screen_2.dart';
import 'package:suitmedia/storage/storage.dart';

class ViewEvents extends StatefulWidget {
  @override
  _ViewEventsState createState() => _ViewEventsState();
}

class _ViewEventsState extends State<ViewEvents> {
  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "nama": "A Event",
      "tanggal": "2014-01-01",
      "image": 'assets/image/dummy.jpg'
    },
    {
      "id": 2,
      "nama": "B Event",
      "tanggal": "2014-01-02",
      "image": 'assets/image/dummy.jpg'
    },
    {
      "id": 3,
      "nama": "C Event",
      "tanggal": "2014-01-03",
      "image": 'assets/image/dummy.jpg'
    },
    {
      "id": 4,
      "nama": "D Event",
      "tanggal": "2014-01-04",
      "image": 'assets/image/dummy.jpg'
    },
    {
      "id": 5,
      "nama": "E Event",
      "tanggal": "2014-01-05",
      "image": 'assets/image/dummy.jpg'
    },
    {
      "id": 6,
      "nama": "F Event",
      "tanggal": "2014-01-06",
      "image": 'assets/image/dummy.jpg'
    },
    {
      "id": 7,
      "nama": "G Event",
      "tanggal": "2014-01-07",
      "image": 'assets/image/dummy.jpg'
    },
    {
      "id": 8,
      "nama": "H Event",
      "tanggal": "2014-01-08",
      "image": 'assets/image/dummy.jpg'
    },
    {
      "id": 9,
      "nama": "I Event",
      "tanggal": "2014-01-09",
      "image": 'assets/image/dummy.jpg'
    },
    {
      "id": 10,
      "nama": "J Event",
      "tanggal": "2014-01-10",
      "image": 'assets/image/dummy.jpg'
    },
  ];
  final secureStorage = SecureStorage();
  int _selectedIndex = 10;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final indexEvent =
        await SecureStorage().readSecureData('eventIndex') ?? '10';
    var intEventIndex = int.parse(indexEvent);
    setState(() {
      this._selectedIndex = intEventIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: Key('scaffold'),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(18, 40, 75, 1.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'EVENT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                ),
              ),
            ],
          ),
        ),
        body: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container()),
            Expanded(
              flex: 9,
              child: Scaffold(
                body: new ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, int index) {
                    return new ListTile(
                      title: Text(events[index]["nama"]),
                      leading: Image.asset(events[index]["image"]),
                      subtitle: Text(events[index]["tanggal"]),
                      isThreeLine: true,
                      selected: index == _selectedIndex,
                      onTap: () async {
                        setState(() {
                          _selectedIndex = index;
                        });
                        await secureStorage.writeSecureData(
                            'eventNama', events[index]["nama"]);
                        await secureStorage.writeSecureData(
                            'eventIndex', "$index");
                        print("berhasil ngewrite event");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EventGuest();
                        }));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
