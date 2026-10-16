import 'package:TrustLens/view/add_subject/custom_widgets/custom_subject_tile.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:TrustLens/viewmodel/subject_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubjectTab extends StatefulWidget {
  final Map<String, dynamic> newclass;
  const new({super.key, required this.newclass});

  @override
  State<SubjectTab> createState() => _SubjectTabState();
}

class _SubjectTabState extends State<SubjectTab> {
  late SubjectController subjectController;
  @override
  void initState() {
    super.initState();

    subjectController = Get.find<SubjectController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      subjectController.fetchClassSubject(widget.newclass["id"].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return GetBuilder<SubjectController>(
          builder: (subjectController) {
            return Expanded(
              child: subjectController.isloading == true
                  ? Container(
                      height: 30.h,
                      width: 30.w,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await subjectController.fetchClassSubject(
                          widget.newclass["id"],
                        );
                      },
                      child: subjectController.subject.isNotEmpty
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: subjectController.subject.length,
                              itemBuilder: (context, index) {
                                final subjectdata =
                                    subjectController.subject[index];

                                return CustomSubjectTile(
                                  subjectName: subjectdata["subject_name"],
                                  index: index,
                                  credits: subjectdata["credits"],
                                  icon: Icons.school_sharp,
                                  onTap: () {
                                    print(
                                      "class name and id " +
                                          widget.newclass["id"] +
                                          " " +
                                          widget.newclass["class_name"],
                                    );
                                  },
                                  onMoreTap: () {
                                    final int subjectId = subjectdata['id'];

                                    subjectController.deleteSubject(
                                      subjectId,
                                      index,
                                      widget.newclass["id"],
                                    );
                                    print(
                                      "Subject ID : " + subjectId.toString(),
                                    );
                                  },
                                );
                              },
                            )
                          : Center(
                              child: Image.asset(
                                "assets/nosubjectfound.png",
                                height: 250.h,
                              ),
                            ),
                    ),
            );
          },
        );
      },
    );
  }
}
