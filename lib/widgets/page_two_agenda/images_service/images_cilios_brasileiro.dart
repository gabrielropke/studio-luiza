import 'package:flutter/material.dart';
import 'package:studio_luiza_web/widgets/page_two_agenda/images_service/images_fullscreen.dart';

class ImagesCiliosBrasileiro extends StatefulWidget {
  const ImagesCiliosBrasileiro({Key? key}) : super(key: key);

  @override
  State<ImagesCiliosBrasileiro> createState() => _ImagesCiliosBrasileiroState();
}

class _ImagesCiliosBrasileiroState extends State<ImagesCiliosBrasileiro> {
  List<String> imagesCilios = [
    'assets/images/cilios_brasileiro_01.jpg',
    'assets/images/cilios_brasileiro_02.jpg',
    'assets/images/cilios_brasileiro_03.jpg',
    'assets/images/cilios_brasileiro_04.jpg',
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
