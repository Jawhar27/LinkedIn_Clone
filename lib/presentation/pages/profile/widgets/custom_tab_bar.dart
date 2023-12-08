import 'package:flutter/material.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.child1,
    required this.child2,
    required this.child3,
    required this.child4,
    required this.tab1Text,
    required this.tab2Text,
    required this.tab3Text,
    required this.tab4Text,
  });
  final String tab1Text;
  final String tab2Text;
  final String tab3Text;
  final String tab4Text;
  final Widget child1;
  final Widget child2;
  final Widget child3;
  final Widget child4;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Adjust the length based on the number of tabs
      child: SizedBox(
        height: ScreenUtils.height * 0.48,
        child: Column(
          children: [
            TabBar(
              labelStyle: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
              indicatorColor: Colors.green,
              controller: _tabController,
              tabs: [
                _tabText(
                  widget.tab1Text,
                ),
                _tabText(
                  widget.tab2Text,
                ),
                _tabText(
                  widget.tab3Text,
                ),
                _tabText(
                  widget.tab4Text,
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtils.height * 0.4,
              child: TabBarView(
                controller: _tabController,
                children: [
                  widget.child1,
                  widget.child2,
                  widget.child3,
                  widget.child4,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabText(String text) {
    return Tab(
      text: text,
    );
  }
}
