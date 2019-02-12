# Compress Image 0.1.2

A Plugin For Compressing Pictures taken from Camera

## Getting Started

Compress the picture in JPG format with a desired quality ranging from 0 to 100.

As of right now it's replacing the image taken..

Example:

```
  Future<File> _futureImage;
  File _imageFile;


  Future compressNow() async {
    _futureImage = ImagePicker.pickImage(source: ImageSource.camera);
    _imageFile = await _futureImage;
    print("FILE SIZE BEFORE: " + _imageFile.lengthSync().toString());
    await CompressImage.compress(imageSrc: _imageFile.path, desiredQuality: 80); //desiredQuality ranges from 0 to 100
    print("FILE SIZE  AFTER: " + _imageFile.lengthSync().toString());

    setState(() {
      _imageFile;
    });
  }
```


To do:

* Compress image from gallery.

* Create a new image instead of replacing it.