import 'package:assignment2/Authentication/auth_service.dart';
import 'package:assignment2/Profile/screens/editProfile.dart';
import './Authentication/auth.dart';
import './MyFeed/myFeed.dart';
import './Profile/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_url_gen/transformation/effect/effect.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_flutter/cloudinary_object.dart';
// import 'package:cloudinary_flutter/image_uploader.dart';
// import 'package:cloudinary_flutter/uploader.dart';



// var cloudinary=Cloudinary.fromStringUrl('cloudinary://API_KEY:API_SECRET@CLOUD_NAME');

void main() async {
  //  cloudinary.config.urlConfig.secure = true;
  // upload();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true; // Loading state
  bool _isLoggedIn = false; // Auth state flag

  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
  }

  void _checkUserLoggedIn() async {
    final user = AuthService().getCurrentUser();
    setState(() {
      _isLoggedIn = user != null; // Check if user exists
      _isLoading = false; // Stop loading once checked
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(), // Show a loading spinner
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // If user is logged in, show Tabs screen; else, show Auth screen
      home: _isLoggedIn ? const Tabs() : const Auth(),
     
      routes: {
        Editprofile.routeName: (ctx) => Editprofile(),
        // Test2.routeName: (ctx)=> Test2(),
      },
    );
  }
}

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  final List<Map<String, dynamic>> _pages = [
    {'page': ProfilePage(), 'title': 'Profile'},
    {'page': Myfeed(), 'title': 'Feed'},
  ];
  int _selectedPageIndex = 0;

  void logout() async {
    final _auth = AuthService();
    await _auth.signOut();
    // Navigate to the Auth screen after logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Auth()),
      (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    void _selectPage(int index) {
      setState(() {
        _selectedPageIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.purple[300],
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
        ],
      ),
    );
  }
}
// upload() async{
//   var response = await cloudinary.uploader().upload('https://cloudinary-devs.github.io/cld-docs-assets/assets/images/butterfly.jpeg',
//     params: UploadParams(
//         publicId: 'quickstart_butterfly',
//         uniqueFilename: false,
//         overwrite: true));
//   print(response?.data?.publicId);
//   print(response?.data?.secureUrl);
// }
