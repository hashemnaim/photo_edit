import 'dart:io';

class ImageModelEditing {
  File? image;
  double? size;
  double? top;
  double? left;
  bool? isEdit = false;

  ImageModelEditing(
      {this.image, this.size, this.left, this.top, this.isEdit = false});
}
