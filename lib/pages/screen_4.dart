import 'package:flutter/material.dart';
import 'package:suitmedia/api/Api.dart';
import 'package:suitmedia/pages/screen_2.dart';
import 'package:suitmedia/storage/storage.dart';

class ViewGuest extends StatefulWidget {
  @override
  _ViewGuestState createState() => _ViewGuestState();
}

class _ViewGuestState extends State<ViewGuest> {
  var data = [];
  final secureStorage = SecureStorage();
  int selectedCard = -1;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final data = await Api().getGuests();
    final indexGuest =
        await SecureStorage().readSecureData('guestIndex') ?? '-1';
    var intGuestIndex = int.parse(indexGuest);

    setState(() {
      this.selectedCard = intGuestIndex;
      this.data = data;
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
                'GUEST',
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
                body: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          // ontap of each card, set the defined int to the grid view index
                          selectedCard = index;
                        });
                        await secureStorage.writeSecureData(
                            'guestNama', data[index]['name']);
                        await secureStorage.writeSecureData(
                            'guestBirthdate', data[index]['birthdate']);
                        await secureStorage.writeSecureData(
                            'guestIndex', "$index");
                        print("berhasil ngewrite event");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EventGuest();
                        }));
                      },
                      child: Card(
                        // check if the index is equal to the selected Card integer
                        color:
                            selectedCard == index ? Colors.blue : Colors.amber,
                        child: Container(
                          height: 200,
                          width: 200,
                          child: GridTile(
                            header: GridTileBar(
                              title: Icon(
                                Icons.account_circle,
                                size: 80,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  data[index]['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    color: Color.fromRGBO(255, 255, 255, 1.0),
                                  ),
                                ),
                              ],
                            ),
                            footer: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  data[index]['birthdate'],
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
                        ),
                      ),
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
