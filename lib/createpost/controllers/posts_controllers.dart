import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newst4/createpost/model/post_model.dart';
import 'package:newst4/createpost/services/post_services.dart';
import 'package:video_player/video_player.dart';
//import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  static PostController to = Get.find();
  final services = PostServices();
  RxBool isLoading = true.obs;
  TextEditingController postTitle = TextEditingController();
  TextEditingController postBody = TextEditingController();
  TextEditingController textPost = TextEditingController();
  TextEditingController urlPost = TextEditingController();
  RxString typeOfPost = ''.obs;
  final title = "".obs;
  final body = "".obs;
  final formKey = GlobalKey<FormState>();
  final images = ''.obs;
  final imagePicker = ImagePicker();

  // VideoPlayerController? controller;
  Future<void>? initializeVideoPlayerFuture;

  // File? videoFile;
  final videoFile = Rx<File?>(null);
  final controller = Rx<VideoPlayerController?>(null);

  @override
  void onInit() {
    _fetchHouses();

    super.onInit();
  }

  sendPost(BuildContext context) {
    services.sendPost(
        PostModel(
          title: title.value,
          text: body.value,
          flairId: "",
          flairText: "",
          kind: "",
          nsfw: "",
          owner: "",
          ownerType: "",
          scheduled: "",
          sendReplies: "",
          sharedFrom: "",
          spoiler: "",
          suggestedSort: "",
          url: "",
        ),
        context);
  }

  Future<void> _fetchHouses() async {
    try {
      ///here fitch Your Posts
    } finally {
      isLoading(false);
    }
  }

  Future<void> createPost() async {
    try {
      isLoading.value = true;

      ///here post Your Posts
      await Future.delayed(const Duration(seconds: 3), () {
        isLoading.value = false;
      });
    } finally {
      isLoading(false);
    }
  }

  selectImage() async {
    try {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) images.value = image.path;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getVideo() async {
    Future<XFile?> videoFiles =
        ImagePicker().pickVideo(source: ImageSource.gallery);
    videoFiles.then((file) async {
      videoFile.value = File(file!.path);
      controller.value = VideoPlayerController.file(videoFile.value!);
      update();
      // Initialize the controller and store the Future for later use.
      initializeVideoPlayerFuture = controller.value!.initialize();

      // Use the controller to loop the video.
      controller.value!.setLooping(true);
    });
  }

  playVideo() {
    if (controller.value!.value.isPlaying) {
      controller.value!.pause();
    } else {
      // If the video is paused, play it.
      controller.value!.play();
    }
    update();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    controller.value!.dispose();
    super.dispose();
  }
}
