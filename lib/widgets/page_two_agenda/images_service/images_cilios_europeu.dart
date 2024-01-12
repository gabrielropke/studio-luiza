import 'package:flutter/material.dart';
import 'package:studio_luiza_web/widgets/page_two_agenda/images_service/images_fullscreen.dart';

class ImagesCiliosEuropeu extends StatefulWidget {
  const ImagesCiliosEuropeu({Key? key}) : super(key: key);

  @override
  State<ImagesCiliosEuropeu> createState() => _ImagesCiliosEuropeuState();
}

class _ImagesCiliosEuropeuState extends State<ImagesCiliosEuropeu> {
  List<String> imagesCilios = [
    'assets/images/cilios_europeu_01.jpg',
    'assets/images/cilios_europeu_02.jpg',
    'assets/images/cilios_europeu_03.jpg',
    'assets/images/cilios_europeu_04.jpg',
    'assets/images/cilios_europeu_05.jpg',
    'assets/images/cilios_europeu_06.jpg',
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
