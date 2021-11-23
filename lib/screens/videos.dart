import 'package:renawistory/widgets/video.dart';
import 'package:flutter/material.dart';

class Videos extends StatelessWidget {
  static String routeName = 'videos_page';
  List videos = [
    'https://www.youtube.com/watch?v=T_-H7hMOx1s&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=1',
    'https://www.youtube.com/watch?v=K-LicGnbL1g&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=2',
    'https://www.youtube.com/watch?v=xcLG7SDxv_0&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=3',
    'https://www.youtube.com/watch?v=FVwD35VSYFo&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=4',
    'https://www.youtube.com/watch?v=ZAcElINC4Mg&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=5',
    'https://www.youtube.com/watch?v=ElSWO0d4Qgw&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=6',
    'https://www.youtube.com/watch?v=Cp0JkER7VPM&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=7',
    'https://www.youtube.com/watch?v=qfRGc_aDWgQ&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=8',
    'https://www.youtube.com/watch?v=EVtrv1ZEhqM&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=9',
    'https://www.youtube.com/watch?v=pP3xKagFpK4&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=10',
    'https://www.youtube.com/watch?v=Bkf8I36V8mU&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=11',
    'https://www.youtube.com/watch?v=cq0VFI2KAXY&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=12',
    'https://www.youtube.com/watch?v=OBhFoaz6qcY&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=13',
    'https://www.youtube.com/watch?v=c3OMai4ghxc&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=14',
    'https://www.youtube.com/watch?v=9HJfETMggQA&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=15',
    'https://www.youtube.com/watch?v=thFvVX-Bj74&list=PL4Lyy0fezn26nDciJnt4ZQeU1cgXUz4eA&index=16',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.all(5),
                  child: video(
                    videoUrl: videos[index],
                  ));
            }),
      ),
    );
  }
}
