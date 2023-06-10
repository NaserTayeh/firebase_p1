// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      zoom: 20, target: LatLng(31.768319, 35.213710))));
            },
            child: Icon(Icons.location_pin)),
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          markers: markers,
          onTap: (LatLng x) {
            // markers.add(Marker(
            //     markerId: MarkerId('jerusalem+${x.latitude}'), position: x));
            // setState(() {});
          },
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: const LatLng(32.21991661251466, 35.260676108300690),
            zoom: 10.0,
          ),
        ),
      ),
    );
  }
}





































// // ignore_for_file: unused_local_variable, annotate_overrides, prefer_const_constructors

// import 'dart:math';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_firebase/admin/provider/admin_provider.dart';
// import 'package:flutter_application_firebase/admin/views/screens/add_category.dart';
// import 'package:flutter_application_firebase/admin/views/screens/display_categories.dart';
// import 'package:flutter_application_firebase/admin/views/screens/main_admin_screen.dart';
// import 'package:flutter_application_firebase/app_router/app_router.dart';
// import 'package:flutter_application_firebase/auth/auth_helper.dart';
// import 'package:flutter_application_firebase/provider/auth_provider.dart';
// import 'package:flutter_application_firebase/screen/sign_in_screen.dart';
// import 'package:flutter_application_firebase/screen/sign_up_screen.dart';
// import 'package:flutter_application_firebase/screen/splash_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:string_validator/string_validator.dart';

// import 'firebase_options.dart';

// // ecommerce app
// // users :
// /*
//  1-asmin user
//  - add new p 
//  - edit  p 
//  - delete p 
//  - display all p 
//  - display all orders 
//  - accept or reject orders 
//  2 - customer user :
//  - display all p 
//  - add p to cart
//  - remove p from caer
//  - edit p quanitiy in cart 
//  - checkout 
//  - add p tp favourite 
//  - share p to friend 

//  */
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<AuthProvider>(create: (context) {
//           return AuthProvider();
//         }),
//         ChangeNotifierProvider<AdminProvider>(create: (context) {
//           return AdminProvider();
//         })
//       ],
//       child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           navigatorKey: AppRouter.appRouter.navigatorKey,
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//           ),
//           home: MainAdminScreen()
//           // AllCategoriesScreen()
//           // AddNewCategory()
//           // SplachScreen()
//           // SignInScreen(),
//           ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<Widget> widgets = [TextFormField()];
//   TextEditingController emailTextEditingController = TextEditingController();
//   TextEditingController passwordTextEditingController = TextEditingController();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Authentication'),
//       ),
//       body: Center(
//         child: Container(
//           height: 350,
//           margin: EdgeInsets.only(top: 50),
//           decoration: BoxDecoration(
//               color: Colors.black12,
//               borderRadius: BorderRadius.all(Radius.circular(50))),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // ElevatedButton(
//                 //     onPressed: () {
//                 //       AuthHelper.authHelper.signUp('nasert@gmail.com', '1234566');
//                 //     },
//                 //     child: Text('Add new Author')),
//                 TextFormField(
//                   cursorColor: Colors.green,
//                   validator: (v) {
//                     if (v == null || v.isEmpty) {
//                       return 'Required field';
//                     } else if (!(isEmail(v))) {
//                       return "Incoreect email syntax ";
//                     }

//                     return null;
//                   },
//                   controller: emailTextEditingController,
//                   decoration: const InputDecoration(
//                     label: Text('email'), /*hintText: 'Email'*/
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   obscureText: true,
//                   validator: (v) {
//                     if (v == null || v.isEmpty) {
//                       return 'Required field';
//                     } else if ((v.length) <= 6) {
//                       return 'Error , password must be larger than 6 letter';
//                     }
//                     // v?.length ?? 0

//                     return null;
//                   },
//                   controller: passwordTextEditingController,
//                   decoration: const InputDecoration(
//                     label: Text('password'), /*hintText: 'Password'*/
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     print(emailTextEditingController.text);
//                     print(passwordTextEditingController.text);
//                     bool isValid = formKey.currentState!.validate();
//                     if (isValid) {
//                       AuthHelper.authHelper.signUp(
//                           emailTextEditingController.text,
//                           passwordTextEditingController.text);
//                       emailTextEditingController.clear();
//                       passwordTextEditingController.clear();
//                     }
//                   },
//                   child: Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
