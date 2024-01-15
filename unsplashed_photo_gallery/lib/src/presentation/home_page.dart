import 'package:flutter/material.dart';

import '../actions/list_photos.dart';
import '../actions/set.dart';
import '../models/app_state.dart';
import '../models/app_user.dart';
import '../models/photo.dart';
import 'containers/app_user_container.dart';
import 'containers/is_loading_container.dart';
import 'containers/photos_container.dart';
import 'extensions.dart';
import 'user_picture.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController controller = ScrollController();
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.dispatch(const ListPhotos());
    controller.addListener(_onScroll);
  }

  void _onScroll() {
    final double offset = controller.offset;
    final double maxExtent = controller.position.maxScrollExtent;

    if (!context.state.isLoading && offset > maxExtent * .8) {
      context.dispatch(const ListPhotos());
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhotosContainer(
      builder: (BuildContext context, List<Photo> photos) {
        return IsLoadingContainer(
          builder: (BuildContext context, bool isLoading) {
            return RefreshIndicator(
              onRefresh: () async {
                textController.clear();
                context
                  ..dispatch(const SetQuery(''))
                  ..dispatch(const ListPhotos());

                await context.store.onChange.firstWhere((AppState state) => !state.isLoading);
              },
              child: AppUserContainer(
                builder: (BuildContext context, AppUser? user) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Photos'),
                      actions: <Widget>[
                        if (user != null)
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                            child: const UserPicture(),
                          )
                      ],
                    ),
                    body: Column(
                      children: <Widget>[
                        Expanded(
                          child: CustomScrollView(
                            controller: controller,
                            slivers: <Widget>[
                              SliverToBoxAdapter(
                                child: TextField(
                                  controller: textController,
                                  onChanged: (String value) {
                                    context
                                      ..dispatch(SetQuery(value))
                                      ..dispatch(const ListPhotos());
                                  },
                                ),
                              ),
                              if (!isLoading && photos.isEmpty)
                                const SliverToBoxAdapter(
                                  child: Center(
                                    child: Text('No items found.'),
                                  ),
                                ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    final Photo photo = photos[index];

                                    return GestureDetector(
                                      onTap: () {
                                        if (user != null) {
                                          print('user is: $user for photo: $photo');
                                        } else {
                                          Navigator.pushNamed(context, '/createUser');
                                        }
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius: BorderRadius.circular(16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Image.network(
                                                photo.urls as String,
                                                height: 345,
                                                errorBuilder:
                                                    (BuildContext context, Object error, StackTrace? stackTrace) {
                                                  return const Placeholder(
                                                    fallbackHeight: 345,
                                                    fallbackWidth: 200,
                                                  );
                                                },
                                                loadingBuilder:
                                                    (BuildContext context, Widget widget, ImageChunkEvent? progress) {
                                                  if (progress == null) {
                                                    return widget;
                                                  }

                                                  return SizedBox(
                                                    height: 345,
                                                    child: Center(
                                                      child: CircularProgressIndicator(
                                                        value: progress.cumulativeBytesLoaded /
                                                            (progress.expectedTotalBytes ?? 1),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                          ListTile(
                                            title:
                                             Text(
                                              photo.description,
                                              maxLines: 5,
                                            )
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  childCount: photos.length,
                                ),
                              ),
                              if (isLoading)
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding: MediaQuery.paddingOf(context),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}