import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../controllers/posts_controllers.dart';

class BuildFormType extends StatelessWidget {
  const BuildFormType({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PostController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0),
        child: controller.typeOfPost.value == "text"
            ? TextFormField(
                controller: controller.textPost,
                enabled: true,
                style: const TextStyle(fontSize: 14.0),
                showCursor: true,
                toolbarOptions:
                    const ToolbarOptions(copy: true, cut: true, paste: true),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                autofocus: true,
                maxLines: null,
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                    hintText: "Add optional body text",
                    border: InputBorder.none),
              )
            : controller.typeOfPost.value == "url"
                ? TextFormField(
                    controller: controller.urlPost,
                    enabled: true,
                    style: const TextStyle(fontSize: 14.0),
                    showCursor: true,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                        hintText: "URL", border: InputBorder.none
                        //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
                        ),
                  )
                : controller.typeOfPost.value == "image"
                    ? SizedBox()
                    : null);
  }
}
