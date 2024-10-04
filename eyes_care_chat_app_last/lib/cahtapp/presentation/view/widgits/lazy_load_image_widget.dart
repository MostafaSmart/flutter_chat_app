import 'package:eyes_care_chat_app_last/cahtapp/presentation/controllers/masseges_contrtoller.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class LazyLoadImageWidget extends StatefulWidget {
  final String imgUrl;
  final double height;
  final double width;
  final BoxFit fit;

  const LazyLoadImageWidget({
    Key? key,
    required this.imgUrl,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  _LazyLoadImageWidgetState createState() => _LazyLoadImageWidgetState();
}

class _LazyLoadImageWidgetState extends State<LazyLoadImageWidget> {
  bool _isImageLoaded = false; // تحديد ما إذا تم تحميل الصورة
  final MessageController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_isImageLoaded) {
            controller.showImageDialog(imagePath: widget.imgUrl, flag: 0);
          }
          else{
            _isImageLoaded = true;
          }

         
        });
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        color: Colors.grey[300], // لون خلفية بديل قبل التحميل
        child: _isImageLoaded
            ? CachedNetworkImage(
                imageUrl: widget.imgUrl,
                height: widget.height,
                width: widget.width,
                fit: widget.fit,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : const Center(
                child: Icon(
                  Icons.download,
                  size: 50,
                  color: Colors.blue,
                ), // أيقونة أو عنصر يرمز لبدء التحميل
              ),
      ),
    );
  }
}
