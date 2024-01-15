import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'firebase_options.dart';
import 'src/actions/get_current_user.dart';
import 'src/api/auth_api.dart';
import 'src/api/photo_api.dart';
import 'src/epics/app_epics.dart';
import 'src/models/app_state.dart';
import 'src/presentation/create_user.dart';
import 'src/presentation/home_page.dart';
import 'src/presentation/login_user.dart';
import 'src/presentation/profile_page.dart';
import 'src/reducer/reducer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Client client = Client();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final PhotoApi api = PhotoApi(accessKey: 'LiCIcjMwix0KXu4u9L1B2A69x80tLD6z8QOsojdePzs', client: client);
  final AuthApi authApi = AuthApi(auth: auth, storage: storage);
  final AppEpics appEpic = AppEpics(api, authApi);

  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(appEpic.call).call,
    ],
  );
  store.dispatch(const GetCurrentUser());

  runApp(PhotoGallery(store: store));
}

class PhotoGallery extends StatelessWidget {
  const PhotoGallery({super.key, required this.store});

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: const HomePage(),
        routes: <String, WidgetBuilder>{
          '/createUser': (BuildContext context) => const CreateUserPage(),
          '/loginUser': (BuildContext context) => const LoginUserPage(),
          '/profile': (BuildContext context) => const ProfilePage(),
        },
      ),
    );
  }
}

//THE OLD APP

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';

// const String accessKey = 'LiCIcjMwix0KXu4u9L1B2A69x80tLD6z8QOsojdePzs';
//
// void main() {
//   runApp(const PhotoGallery());
// }
//
// class PhotoGallery extends StatelessWidget {
//   const PhotoGallery({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: HomePage());
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => HomePageState();
// }
//
// class HomePageState extends State<HomePage> {
//   final List<Photo> items = <Photo>[];
//   bool isLoading = true;
//   int page = 1;
//   String searchString = 'photos';
//
//   @override
//   void initState() {
//     super.initState();
//     loadItems();
//   }
//
//   Future<void> loadItems() async {
//     final Client client = Client();
//
//     final Response response = await client.get(
//       Uri.parse(
//           'https://api.unsplash.com/search/photos?page=$page&query=$searchString'),
//       headers: <String, String>{'Authorization': 'Client-ID $accessKey'},
//     );
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data =
//           jsonDecode(response.body) as Map<String, dynamic>;
//       final List<dynamic> results = data['results'] as List<dynamic>;
//
//       for (final dynamic item in results) {
//         items.add(Photo(item as Map<String, dynamic>));
//       }
//
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Photo Gallery'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Column(
//         children: <Widget>[
//           TextField(
//             onChanged: (String value) {
//               setState(() {
//                 searchString = value;
//                 isLoading = true;
//                 items.clear();
//               });
//             },
//             onSubmitted: (String value) {
//               setState(() {
//                 page = 1;
//                 loadItems();
//               });
//             },
//             decoration: const InputDecoration(hintText: 'Search'),
//           ),
//           Expanded(
//             child: NotificationListener<ScrollNotification>(
//               onNotification: (ScrollNotification scrollInfo) {
//                 if (!isLoading &&
//                     scrollInfo.metrics.pixels ==
//                         scrollInfo.metrics.maxScrollExtent) {
//                   setState(() {
//                     isLoading = true;
//                     page++;
//                   });
//                   loadItems();
//                   return true;
//                 }
//                 return false;
//               },
//               child: Stack(
//                 children: <Widget>[
//                   GridView.builder(
//                     itemCount: items.length,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 8.0,
//                       crossAxisSpacing: 8.0,
//                       childAspectRatio: 0.7,
//                     ),
//                     itemBuilder: (BuildContext context, int index) {
//                       return GridTile(
//                         child: Image.network(
//                           items[index].imageUrl,
//                           fit: BoxFit.cover,
//                         ),
//                       );
//                     },
//                   ),
//                   if (isLoading)
//                     const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Photo {
//   Photo(Map<String, dynamic> json)
//       : imageUrl =
//             ((json['urls'] as Map<String, dynamic>?)?['regular'] as String?) ??
//                 '';
//
//   final String imageUrl;
//
//   @override
//   String toString() {
//     return 'Photo{imageUrl: $imageUrl}';
//   }
// }
