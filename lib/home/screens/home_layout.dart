// import 'package:flutter_code_style/flutter_code_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../createpost/screens/createpost.dart';
import '../../icons/icon_broken.dart';
import '../../notification/screens/notifications_screen.dart';
import '../widgets/component.dart';
import '../widgets/drawer.dart';
import '../widgets/end_drawer.dart';

class homeLayoutScreen extends StatefulWidget {
  static const routeName = '/homescreen';
  @override
  State<homeLayoutScreen> createState() => _homeLayoutScreenState();
}

class _homeLayoutScreenState extends State<homeLayoutScreen> {
// Value for DropDownButton
  String dropDownButtonValue = "Home";
  List<String> list = ["Home", "Popular"];

  // Icons when expansionlist at the drawer
  dynamic icRecent = Icon(IconBroken.Arrow___Right_2);
  dynamic icModerating = Icon(IconBroken.Arrow___Right_2);
  dynamic icYourCommunities = Icon(IconBroken.Arrow___Right_2);
  // bools to handle the Expansion pannels in drawer
  bool isRecentlyVisitedPannelExpanded = true;
  bool isModeratingPannelExpanded = false;
  bool isOnline = true;
  //Unique  KEYS to handle the scaffold and form and drawer
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var drawerKey = GlobalKey<DrawerControllerState>();
  // drawer functions
  void showDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

// for dropdown list
  String dropValue = "Home";
  // Lists for DropDown Menu at appBar
  List<DropdownMenuItem> dropdownItems = [
    DropdownMenuItem(
        child: ButtonBar(
      children: [Text("Home")],
    )),
    DropdownMenuItem(
        child: ButtonBar(
      children: [Text("Popular")],
    ))
  ];
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
              // To make style for status bar
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              elevation: 1.0,
              backgroundColor: Colors.white,
              leading: Builder(builder: (context) {
                return IconButton(
                  onPressed: () => showDrawer(context),
                  icon:
                      Icon(Icons.menu_rounded, color: Colors.black, size: 30),
                );
              }),
              title: ElevatedButton.icon(
                onPressed: () {
                  print("ell");
                },
                icon: Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600),
                ),
                label: Icon(
                  IconBroken.Arrow___Down_2,
                  color: Colors.black,
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0),
                  fixedSize: MaterialStateProperty.all(Size(100.0, 20.0)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey[300]),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconBroken.Search,
                    color: Colors.black87,
                    size: 28.0,
                  ),
                ),
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: () => showEndDrawer(context),
                    icon: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/1016295_681893355195881_1578644646_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=19026a&_nc_eui2=AeFCVmaamBcbWQWbLgc5goA3TPveZl9CmeVM-95mX0KZ5Vix3F-p1IQuy-XTH_AaZw9YBNHT3DSG2M-3MKmnZCTP&_nc_ohc=sqT0q3soKqIAX_3KeFE&_nc_ht=scontent.fcai19-6.fna&oh=00_AfDtKbIed-hxraIzyhrh3idtNM-BDhP8dvZT6sKo7tAZsA&oe=6396FDE4'),
                          radius: 30.0,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 6,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              end: 2, bottom: 2),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 4,
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ]),
          bottomNavigationBar: Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 10.0),
            child: Container(
              height: 90.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: BottomNavigationBar(
                elevation: 0,
                selectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                onTap: (index) {
                  if (index == 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreatePostSCreen()));
                  }
                  if (index == 4) {
                    Navigator.of(context)
                        .pushNamed(NotificationScreen.routeName);
                  }
                },
                items: buttNavBar(),
              ),
            ),
          ),
          endDrawer:  endDrawer(),
          drawer: drawer(),
        );
  }



}
