import 'package:image_picker/image_picker.dart';

class imageselecterclass {
  Future<XFile?> selectimage() async {
    ImagePicker imagePicker = ImagePicker();
    // imagepicker class has inbuilt 2 methods : get img and pick img
    // get img, used to pick img from device gallery and camera
    // pick img func is used to pick img from gallery
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    // XFile obj contains infor abt selected img, like filepath, filesize, filetype
    if (file != null) {
      return file;
    }
    return null;
    
  }
}
