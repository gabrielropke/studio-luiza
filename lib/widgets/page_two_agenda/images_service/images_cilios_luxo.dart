import 'package:flutter/material.dart';
import 'package:studio_luiza_web/widgets/page_two_agenda/images_service/images_fullscreen.dart';

class ImagesCiliosLuxo extends StatefulWidget {
  const ImagesCiliosLuxo({Key? key}) : super(key: key);

  @override
  State<ImagesCiliosLuxo> createState() => _ImagesCiliosLuxoState();
}

class _ImagesCiliosLuxoState extends State<ImagesCiliosLuxo> {
  List<String> imagesCilios = [
    'assets/images/cilios_luxo_01.jpg',
    'assets/images/cilios_luxo_02.jpg',
    'assets/images/cilios_luxo_03.jpg',
    'assets/images/cilios_luxo_04.jpg',
    'assets/images/cilios_luxo_05.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: imagesCilios.map((String imagePath) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(imagePath: imagePath),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
