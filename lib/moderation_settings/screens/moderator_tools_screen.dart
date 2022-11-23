import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../models/moderator_tools.dart';
import './topics_screen.dart';

class ModeratorTools extends StatefulWidget {
  static const routeName = '/moderatortools';

  const ModeratorTools({super.key});

  @override
  State<ModeratorTools> createState() => _ModeratorToolsState();
}

class _ModeratorToolsState extends State<ModeratorTools> {
  @override
  // bool returned = false;
  void initState() {
    // TODO: implement initState

    //DioClient.init();
    super.initState();
  }

  List<String>? topics;

  @override
  void didChangeDependencies() {
    // // TODO: implement didChangeDependencies
    // DioClient.get(path: moderationTools).then((value) {
    //   final result = ModeratorToolsModel.fromJson(json.decode(value.data));
    //   topics = result.topics;
    //   // topics = ['Activisim'];
    //   print(topics);
    // });

    // returned = true;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //leading if there is no button when pushing add it don't forget
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text(
            'Moderator tools',
          ),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          backgroundColor: Colors.grey[50],
          titleSpacing: 0,
          elevation: 2,
          shadowColor: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey.shade300,
            width: 100.h,
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: const Text(
              'GENERAL',
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              //call buildGeneralOptions to create the widget of each option under general in settings
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(TopicsScreen.routeName),
                  'Topics',
                  Icons.topic),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector buildGeneralOptions(
      BuildContext context, VoidCallback onTap, String text, IconData next) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(next),
        trailing: const Icon(Icons.arrow_forward),
        title: Text(text),
      ),
    );
  }
}
