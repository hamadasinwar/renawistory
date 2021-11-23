import 'package:renawistory/screens/courses.dart';
import 'package:renawistory/screens/library.dart';
import 'package:renawistory/screens/participantsPhotos.dart';
import 'package:renawistory/screens/toolsPictures.dart';
import 'package:renawistory/screens/veHandNew.dart';
import 'package:renawistory/screens/videos.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(3, 154, 156, 1),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: //FilePdf(),
          // PdfViewer(),
          //   MyHomePage(),
          LoginScreen(),
      //    Courses(),
      routes: {
        MyHomePage.route: (context) => MyHomePage(),
        Videos.routeName: (context) => Videos(),
        LoginScreen.routeName: (context) => LoginScreen(),
        ParticipantsPhotos.routeName: (context) => ParticipantsPhotos(),
        ToolsPictures.routeName: (context) => ToolsPictures()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String route = 'home_page';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List pages = [Library(), VeHandNew(), Courses()];
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pages[_currentIndex]),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
                currentIndex: _currentIndex,
                backgroundColor: Color.fromRGBO(230, 245, 253, 1),
                selectedItemColor: Color.fromRGBO(30, 62, 135, 1),
                unselectedItemColor: Colors.black,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 0,
                    ),
                    label: ' مكتبة ريناوي',
                  ),
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings_outlined,
                        size: 0,
                      ),
                      label: 'دورات ريناوي')
                ]),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: _currentIndex == 1
              ? Theme.of(context).primaryColor
              : Colors.blueGrey,
          child: Icon(
            Icons.home,
            color: Colors.black,
          ),
          onPressed: () => setState(() {
            _currentIndex = 1;
          }),
        ),
      ),
    );
  }
}
