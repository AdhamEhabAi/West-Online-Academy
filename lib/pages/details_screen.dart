import 'package:elmanasa/models/all_own_courses.dart';
import 'package:elmanasa/models/all_pdf.dart';
import 'package:elmanasa/services/get_all_pdf.dart';
import 'package:elmanasa/services/get_all_videos.dart';
import 'package:elmanasa/widgets/courseScreenWidgets/custom_video_player.dart';
import 'package:elmanasa/widgets/courseScreenWidgets/pdf_card.dart';
import 'package:elmanasa/widgets/courseScreenWidgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import '../models/video_model.dart';

class DetailsScreen extends StatefulWidget {
  final AllOwnCourses ownedCourse;
  const DetailsScreen({
    Key? key,
    required this.ownedCourse,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState(ownedCourse);
}

class _DetailsScreenState extends State<DetailsScreen> {
  final AllOwnCourses ownedCourse;
  int _selectedTag = 0;
  String selectedVideoUrl = "g4ets8XeWsg";

  void updateSelectedVideoUrl(String url) {
    Future.delayed(Duration.zero, () {
      setState(() {
        selectedVideoUrl = url;
      });
    });
  }

  _DetailsScreenState(this.ownedCourse);

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: OrientationBuilder(
            builder: (context, orientation) => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 25),
                  CustomVideoPlayer(
                    initialApiUrl: selectedVideoUrl,
                    onVideoChanged: updateSelectedVideoUrl,
                  ),
                  const SizedBox(height: 25),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          ownedCourse.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/star_outlined.png',
                              height: 20,
                            ),
                            const Text(
                              " 4.8",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Icon(
                              Icons.timer,
                              color: Colors.grey,
                            ),
                            const Text(
                              " 72 ساعة",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              " \$40",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        CustomTabView(
                          index: _selectedTag,
                          changeTab: changeTab,
                        ),
                        _selectedTag == 0
                            ? PlayList(
                          ownedCourse: ownedCourse,
                          onVideoSelected: updateSelectedVideoUrl,
                        )
                            : Description(
                          ownedCourse: ownedCourse,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        // bottomSheet: BottomSheet(
        //   onClosing: () {},
        //   backgroundColor: Colors.white,
        //   enableDrag: false,
        //   builder: (context) {
        //     return SizedBox(
        //       height: 80,
        //       child: EnrollBottomSheet(
        //         icon: Icons.edit,
        //         txt: 'الاختبار',
        //         onTabSub: () {},
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}


class PlayList extends StatelessWidget {
  const PlayList({
    Key? key,
    required this.ownedCourse,
    required this.onVideoSelected,
  }) : super(key: key);

  final AllOwnCourses ownedCourse;
  final Function(String) onVideoSelected;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: AllVideosService().getAllVideos(courseId: ownedCourse.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const SizedBox();  // Instead of Text('No videos available.');
        } else {
          List<Video> videos = snapshot.data!;
          return ListView.separated(
            separatorBuilder: (_, __) {
              return const SizedBox(
                height: 20,
              );
            },
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            shrinkWrap: true,  // Use shrinkWrap: true if inside a Column
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return VideoCard(
                video: videos[index],
                onVideoSelected: onVideoSelected,
              );
            },
          );
        }
      },
    );
  }
}

class Description extends StatelessWidget {
  const Description({Key? key, required this.ownedCourse}) : super(key: key);
  final AllOwnCourses ownedCourse;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AllPdf>>(
      future: AllPdfService().getAllPdf(courseId: ownedCourse.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const SizedBox();  // Instead of Text('');
        } else {
          List<AllPdf> pdfs = snapshot.data!;
          return ListView.separated(
            separatorBuilder: (_, __) {
              return const SizedBox(
                height: 20,
              );
            },
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            shrinkWrap: true,  // Use shrinkWrap: true if inside a Column
            itemCount: pdfs.length,
            itemBuilder: (context, index) {
              return PdfCard(pdf: pdfs[index]);
            },
          );
        }
      },
    );
  }
}


class CustomTabView extends StatefulWidget {
  final Function(int) changeTab;
  final int index;
  const CustomTabView({Key? key, required this.changeTab, required this.index})
      : super(key: key);

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  final List<String> _tags = ["المحاضرات", "Pdf"];

  Widget _buildTags(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.changeTab(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .08,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: widget.index == index ? kPrimaryColor : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            _tags[index],
            style: TextStyle(
              color: widget.index != index ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: _tags
            .asMap()
            .entries
            .map((MapEntry map) => _buildTags(map.key))
            .toList(),
      ),
    );
  }
}


