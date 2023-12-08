import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/business_logic/blocs/home/bloc/post_bloc.dart';
import 'package:linkedin_clone/data/data_provider/post_data_provider.dart';
import 'package:linkedin_clone/data/repository/post_repository.dart';
import 'package:linkedin_clone/presentation/pages/home/home_screen.dart';
import 'package:linkedin_clone/presentation/widgets/custom_appbar.dart';
import 'package:linkedin_clone/presentation/widgets/custom_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    this.user,
  });
  final User? user;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  late PostRepository postRepository;
  final PostDataProvider _postDataProvider = PostDataProvider();
  late PostBloc _postBloc;

  final int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepository(
      postDataProvider: _postDataProvider,
    );
    _postBloc = PostBloc(
      postRepository: postRepository,
    );
    _postBloc.add(FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _postBloc,
      child: Scaffold(
          drawer: buildDrawer(context: context),
          key: _scaffoldState,
          appBar: appBarWidget(
            context,
            onProfileImageTap: () {
              // To-do : Open Drawer
              _scaffoldState.currentState?.openDrawer();
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentPageIndex,
            onTap: (index) {},
            selectedItemColor: AppColors.linkedInBlue,
            selectedLabelStyle: const TextStyle(
              color: AppColors.linkedInBlue,
            ),
            unselectedItemColor: AppColors.mediumGrey,
            unselectedLabelStyle: const TextStyle(
              color: AppColors.mediumGrey,
            ),
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.network_cell,
                ),
                label: "Network",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_box,
                  size: 30,
                ),
                label: "Post",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  size: 30,
                ),
                label: "Notifications",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.work,
                ),
                label: "Jobs",
              ),
            ],
          ),
          body: _switchPages(_currentPageIndex)),
    );
  }

  _switchPages(int index) {
    switch (index) {
      case 0:
        {
          return const HomeScreeen();
        }
      case 1:
        {
          return Container();
        }
      case 2:
        {}
      case 3:
        {}
      case 4:
        {}
    }
  }
}
