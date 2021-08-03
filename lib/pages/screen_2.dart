import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia/pages/screen_3.dart';
import 'package:suitmedia/pages/screen_4.dart';
import 'package:suitmedia/storage/storage.dart';

class EventGuest extends StatefulWidget {
  @override
  _EventGuestState createState() => _EventGuestState();
}

class _EventGuestState extends State<EventGuest> {
  final secureStorage = SecureStorage();
  String namaLengkap;
  String namaEvent = "Pilih event";
  String namaGuest = "Pilih guest";
  int guestBirthdate = 0;
  String message = "";
  String primeNumber = "is";
  int guestMontBirthdate = 0;

  Future init() async {
    final userName =
        await SecureStorage().readSecureData('namaLengkap') ?? 'anonymous';
    final namaEvent =
        await SecureStorage().readSecureData('eventNama') ?? 'Pilih event';
    final namaGuest =
        await SecureStorage().readSecureData('guestNama') ?? 'Pilih guest';
    final guestBirthdate =
        await SecureStorage().readSecureData('guestBirthdate') ?? '0000-00-00';
    var sub = guestBirthdate.substring(8);
    var tanggal = int.parse(sub);
    var message;
    if (tanggal % 2 == 0 && tanggal % 3 == 0) {
      message = "iOS";
    } else if (tanggal % 2 == 0) {
      message = "Blackberry";
    } else if (tanggal % 3 == 0) {
      message = "Android";
    } else {
      message = "Feature phone";
    }
    var sub2 = guestBirthdate.substring(5, 7);
    var bulan = int.parse(sub2);
    var primeNumber = "is";
    print("bulan adalaahhh $bulan");
    if (bulan == 1) {
      primeNumber = "is not";
    } else {
      for (var i = 2; i <= sqrt(bulan); i++) {
        if (bulan % i == 0) {
          print("Bulan nya bukan prime numbers");
          primeNumber = "is not";
          break;
        }
      }
    }

    setState(() {
      this.namaLengkap = userName;
      this.namaEvent = namaEvent;
      this.namaGuest = namaGuest;
      this.guestBirthdate = tanggal;
      this.message = message;
      this.guestMontBirthdate = bulan;
      this.primeNumber = primeNumber;
    });
    if (this.guestBirthdate != 0) {
      print("masukk show dialog");
      _showAlert(context);
    }
  }

  Widget checkPalindrome() {
    var nama = this.namaLengkap;
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) => AlertDialog(
        title: Text("Guest Info"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Guest birthdate $guestBirthdate'),
              Text(message),
              Text(
                  'Bulan lahir : $guestMontBirthdate, $primeNumber a prime number'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: Key('scaffold'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          key: Key('column'),
          children: <Widget>[
            Text(
              'Nama : $namaLengkap',
              key: Key('namaLengkap'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Inter',
                color: Color.fromRGBO(18, 40, 75, 1.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  print('masuk siniii 2');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ViewEvents();
                  }));
                },
                child: Text(namaEvent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  print('masuk siniii 3');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ViewGuest();
                  }));
                },
                child: Text(namaGuest),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
