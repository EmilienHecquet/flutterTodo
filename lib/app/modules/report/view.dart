import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tasks_app/app/core/utils/extentions.dart';
import 'package:tasks_app/app/core/values/colors.dart';
import 'package:tasks_app/app/modules/home/controller.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});
  final homeCtr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          int createdTasks = homeCtr.getTotalTasks();
          int completedTasks = homeCtr.getTotalDoneTask();
          int liveTasks = createdTasks - completedTasks;
          String precent =
              (completedTasks / createdTasks * 100).toStringAsFixed(0);

          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0.wp),
                child: Text(
                  "Mon rapport",
                  style: TextStyle(
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3.0.wp,
                  horizontal: 4.0.wp,
                ),
                child: const Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 6.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(Colors.green, liveTasks, "En cours"),
                    _buildStatus(Colors.orange, completedTasks, "Complété"),
                    _buildStatus(blue, createdTasks, "Créer"),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0.wp,
              ),
              UnconstrainedBox(
                child: SizedBox(
                  width: 70.0.wp,
                  height: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: createdTasks == 0 ? 1 : createdTasks,
                    currentStep: completedTasks,
                    stepSize: 20,
                    selectedColor: green,
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 22,
                    roundedCap: (_, __) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${createdTasks == 0 ? 0 : precent}%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.0.wp,
                        ),
                        Text(
                          "Complétion",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

Widget _buildStatus(Color color, int number, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 3.0.wp,
        height: 3.0.wp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 0.5.wp,
            color: color,
          ),
        ),
      ),
      SizedBox(
        width: 3.0.wp,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$number",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0.sp,
            ),
          ),
          SizedBox(
            height: 2.0.wp,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.0.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],
  );
}
