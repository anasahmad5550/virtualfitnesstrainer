import 'package:flutter/material.dart';
import 'calorieCalculatorScreen.dart';
import 'dashboardScreen.dart';
import 'profileScreen.dart';
import 'saveWorkoutsScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/cupertino.dart';
import 'settingsscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Widget> _buildScreens() {
  return [
    SaveWorkoutsScreen(),
    CalorieCalculatorScreen(),
    Dashboard(),
    SettingScreen(),
    ProfileScreen()
  ];
}

class _HomeScreenState extends State<HomeScreen> {
  // Properties & Variables needed

  // int currentTab = 0; // to keep track of active tab index
  // final List<Widget> screens = [
  //   Dashboard(),
  //   CalorieCalculatorScreen(),
  //   ProfileScreen(),
  //   SaveWorkoutsScreen(),
  // ]; // to store nested tabs
  // final PageStorageBucket bucket = PageStorageBucket();
  // Widget currentScreen = Dashboard(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.folder),
          title: ("Workouts"),
          activeColor: Theme.of(context).accentColor,
          inactiveColor: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.calculate),
          title: ("KCAL"),
          activeColor: Theme.of(context).accentColor,
          inactiveColor: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ("Home"),
          activeColor: Color(0xffFB376C),
          activeColorAlternate: Colors.white,
          inactiveColor: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.device_unknown),
          title: ("unk"),
          activeColor: Theme.of(context).accentColor,
          inactiveColor: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle),
          title: ("profile"),
          activeColor: Theme.of(context).accentColor,
          inactiveColor: CupertinoColors.systemGrey,
        ),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 2);
    return SafeArea(
      child: Scaffold(
        // body: PageStorage(
        //   child: currentScreen,
        //   bucket: bucket,
        // ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.home),
        //   onPressed: () {
        //     setState(() {
        //       currentScreen =
        //           Dashboard(); // if user taps on this dashboard tab will be active
        //       currentTab = 0;
        //     });
        //   },
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),

          confineInSafeArea: true,
          // navBarHeight: (MediaQuery.of(context).size.height -
          //         MediaQuery.of(context).padding.top) *
          //     0.07263,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears.
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: false,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style15, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}
