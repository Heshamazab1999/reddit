import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:test_app/models/subreddit_about%20_rules.dart';
import '../../models/subreddit_about _rules.dart';
import 'dart:convert';
import '../../moderation_settings/screens/moderator_tools_screen.dart';
import '../../widgets/profile_comments.dart';
import '../../widgets/profile_posts.dart';
import '../../icons/icon_broken.dart';
import '../../widgets/subreddit_about.dart';
import '../../widgets/drawer.dart';
import '../widgets/moderated_subreddit_pop_up_menu_button.dart';
import '../widgets/moderated_subriddet_posts.dart';
import '../models/moderated_subreddit_data.dart';
import '../../screens/subreddit_search_screen.dart';
import '../../myprofile/screens/myprofile_screen.dart';
import '../../create_community/screens/create_community.dart';

class ModeratedSubredditScreen extends StatefulWidget {
  static const routeName = '/moderatedsubreddit';

  @override
  State<ModeratedSubredditScreen> createState() =>
      _ModeratedSubredditScreenState();
}

class _ModeratedSubredditScreenState extends State<ModeratedSubredditScreen>
    with TickerProviderStateMixin {
  //=====================End Drawer=============//
  bool isOnline = true;
  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  //================Tab bar==================//
  List<Tab> tabs = <Tab>[
    const Tab(text: 'Posts'),
    const Tab(text: 'About'),
  ];
  TabController? _controller;
  TabBar get _tabBar => TabBar(
        controller: _controller,
        isScrollable: true,
        tabs: tabs,
        labelColor: Colors.black,
        labelPadding: const EdgeInsets.only(left: 28, right: 28),
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        indicatorColor: Colors.blue,
      );
  //==================notification=========================//
  String dropDownValue = "Low";
  IconData icon = Icons.notifications;
  var _isLoading = false;
  var _isInit = true;
  var userName;
  ModeratedSubredditData? loadedSubreddit = ModeratedSubredditData(
      id: 10,
      name: 'Cooking',
      subredditPicture:
          'https://previews.123rf.com/images/seamartini/seamartini1609/seamartini160900764/64950290-chef-toque-vector-sketch-icon-cook-cap-kitchen-cooking-hat-emblem-for-restaurant-design-element-bake.jpg',
      subredditBackPicture:
          'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fassets.marthastewart.com%2Fstyles%2Fwmax-750%2Fd30%2Feasy-basic-pancakes-horiz-1022%2Feasy-basic-pancakes-horiz-1022_0.jpg%3Fitok%3DXQMZkp_j',
      description: 'I\'m Chef',
      subredditLink:
          'https://previews.123rf.com/images/seamartini/seamartini1609/seamartini160900764/64950290-chef-toque-vector-sketch-icon-cook-cap-kitchen-cooking-hat-emblem-for-restaurant-design-element-bake.jpg',
      numOfMembers: 10398,
      numOfOnlines: 1789,
      rules: [
        SubredditAboutRules('no codeing', 'i hate coding'),
        SubredditAboutRules('no codeing', 'i hate cod'),
        SubredditAboutRules('no codeing', 'i hate code'),
        SubredditAboutRules('no codeing', 'i hate code')
      ],
      moderators: ['Ali', 'omer', 'zeinab', 'mazen'],
      isJoined: true);
  @override
  void initState() {
    // date= DateFormat.yMMMEd().format(toDay);
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //===============================doing fetch=======================================//
    // if (_isInit) {
    //   setState(() {
    //     _isLoading = true;
    //   });
    userName = ModalRoute.of(context)?.settings.arguments as String;
    //   DioClient.init();
    //   DioClient.get(path: subredditPath).then((responseSub) {
    //     loadedSubreddit = SubredditData.fromJson(json.decode(responseSub.data));
    //     DioClient.get(path: moderators).then((responseMod) {
    //       Map<String, dynamic> extractedDate = json.decode(responseMod.data);
    //       List<String> modsName = [];
    //       extractedDate.forEach((id, modDate) {
    //         modsName.add(modDate[userName]);
    //       });
    //       loadedSubreddit!.moderators = modsName;
    //       setState(() {
    //         _isLoading = false;
    //       });
    //     }).catchError((error) {});
    //   }).catchError((error) {});
    // }
    // _isInit = false;
    //==================================================//
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
        body: _isLoading
            ? const Center(
                child: Icon(
                  Icons.reddit,
                  color: Colors.blue,
                ),
              )
            : NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        elevation: 4,
                        backgroundColor: innerBoxIsScrolled
                            ? const Color.fromARGB(137, 33, 33, 33)
                            : Colors.white,
                        leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                        ),
                        title: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(137, 33, 33, 33),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: 60.w,
                          height: 4.h,
                          //color: Color.fromARGB(157, 255, 245, 245),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(SubredditSearchScreen.routeName);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  'r/${loadedSubreddit!.name}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          ModeratedSubredditPopupMenuButton(
                            linkOfCommuinty:
                                loadedSubreddit!.subredditLink.toString(),
                            communityName: loadedSubreddit!.name.toString(),
                            userName: userName,
                          ),
                          Builder(builder: (context) {
                            return IconButton(
                              onPressed: () => showEndDrawer(context),
                              icon: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/1016295_681893355195881_1578644646_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=19026a&_nc_eui2=AeFCVmaamBcbWQWbLgc5goA3TPveZl9CmeVM-95mX0KZ5Vix3F-p1IQuy-XTH_AaZw9YBNHT3DSG2M-3MKmnZCTP&_nc_ohc=sqT0q3soKqIAX_3KeFE&_nc_ht=scontent.fcai19-6.fna&oh=00_AfCLuiiUp7fk2tXYmTGxX5hGven3emX6kxYkUDGkTddyJg&oe=63973624'),
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
                        ],
                        expandedHeight: (loadedSubreddit!.description == null ||
                                loadedSubreddit!.description == '')
                            ? 35.h
                            : (35 +
                                    ((loadedSubreddit!.description
                                                .toString()
                                                .length /
                                            42) +
                                        7))
                                .h,
                        floating: false,
                        pinned: true,
                        snap: false,
                        bottom: PreferredSize(
                          preferredSize: _tabBar.preferredSize,
                          child: ColoredBox(
                            color: Colors.white,
                            child: _tabBar,
                          ),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(children: <Widget>[
                            Stack(
                              alignment: AlignmentDirectional.centerStart,
                              children: <Widget>[
                                //Profile back ground
                                Container(
                                    height: (loadedSubreddit!.description ==
                                                null ||
                                            loadedSubreddit!.description == '')
                                        ? 30.h
                                        : (30 +
                                                ((loadedSubreddit!.description)
                                                        .toString()
                                                        .length /
                                                    42) +
                                                7)
                                            .h,
                                    width: 100.w,
                                    color: Colors.white,
                                    child: Image.network(
                                      loadedSubreddit!.subredditBackPicture
                                          .toString(),
                                      fit: BoxFit.cover,
                                    )),
                                // for name , members ,online and description
                                Positioned(
                                  top: 150,
                                  right: 0,
                                  left: 0,
                                  bottom: 0,
                                  child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 15),
                                            width: 100.w,
                                            height: 9.h,
                                            child: ListTile(
                                                title: Text(
                                                    'r/${loadedSubreddit!.name.toString()}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                subtitle: Text(
                                                  '${int.parse(loadedSubreddit!.numOfMembers.toString())} members .${int.parse(loadedSubreddit!.numOfOnlines.toString())} online ',
                                                ),
                                                trailing: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 30),
                                                  width: 35.w,
                                                  height: 4.h,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Color
                                                                  .fromARGB(
                                                                      255,
                                                                      9,
                                                                      149,
                                                                      104)),
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.white),
                                                      shape: MaterialStateProperty.all(
                                                          const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          22)))),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.build,
                                                          color: Colors.white,
                                                        ),
                                                        Text('Mod Tools'),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              ModeratorTools
                                                                  .routeName);
                                                    },
                                                  ),
                                                )),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Text(
                                                '${loadedSubreddit!.description.toString()}',
                                                overflow: TextOverflow.ellipsis,
                                              ))
                                        ],
                                      )),
                                ),
                                //for profile picture
                                Positioned(
                                  top: 90,
                                  right: 260,
                                  left: 0,
                                  bottom: 120,
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(loadedSubreddit!
                                              .subredditPicture
                                              .toString()),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ];
                },
                body: _isLoading
                    ? const Center(
                        child: Icon(
                          Icons.reddit,
                          color: Colors.blue,
                        ),
                      )
                    : TabBarView(controller: _controller, children: [
                        ModeratedSubriddetPosts(
                            routeNamePop: ModeratedSubredditScreen.routeName),
                        SubredditAbout(
                            rules: loadedSubreddit!.rules
                                as List<SubredditAboutRules>,
                            moderators:
                                loadedSubreddit!.moderators as List<String>,
                            userName: userName)
                      ])),
        endDrawer: _isLoading
            ? const Center(
                child: Icon(
                  Icons.reddit,
                  color: Colors.blue,
                ),
              )
            : endDrawerHome(context));
  }

  Drawer endDrawerHome(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      width: 250.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80.0,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: 250.0,
                height: 250.0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                            'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/1016295_681893355195881_1578644646_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=19026a&_nc_eui2=AeFCVmaamBcbWQWbLgc5goA3TPveZl9CmeVM-95mX0KZ5Vix3F-p1IQuy-XTH_AaZw9YBNHT3DSG2M-3MKmnZCTP&_nc_ohc=sqT0q3soKqIAX_3KeFE&_nc_ht=scontent.fcai19-6.fna&oh=00_AfCLuiiUp7fk2tXYmTGxX5hGven3emX6kxYkUDGkTddyJg&oe=63973624'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'u/' + 'Ahmed Fawzy',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        width: 200.0,
                        height: 30.0,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              if (isOnline) {
                                isOnline = false;
                              } else {
                                isOnline = true;
                              }
                            });
                          },
                          icon: CircleAvatar(
                            radius: 4,
                            backgroundColor:
                                isOnline ? Colors.green : Colors.grey[200],
                          ),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[200]),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(
                                          color: isOnline
                                              ? Colors.green
                                              : Colors.black54)))),
                          label: Text(
                            "Online Status: " + "${isOnline ? "On" : "Off"}",
                            style: TextStyle(
                                color:
                                    isOnline ? Colors.green : Colors.black54),
                          ),
                        ),
                      ),
                    ])),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(Icons.account_circle_outlined),
              title: Text(
                'My profile',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(MyProfileScreen.routeName, arguments: userName);
              },
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(IconBroken.Category),
              title: Text(
                'Create a community',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(CreateCommunity.routeName);
                // Navigator.pop(context);
              },
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(Icons.save),
              title: Text(
                'Saved',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(Icons.access_time_outlined),
              title: Text(
                'History',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(IconBroken.Setting),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
