import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tasks_app/app/core/utils/extentions.dart';
import 'package:tasks_app/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  AddDialog({super.key});
  final homeCtr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCtr.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtr.editCtrl.clear();
                        homeCtr.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      onPressed: () {
                        if (homeCtr.formKey.currentState!.validate()) {
                          if (homeCtr.task.value == null) {
                            EasyLoading.showError(
                                "Veuillez votre type de tâche.");
                          } else {
                            var success = homeCtr.updateTask(
                              homeCtr.task.value!,
                              homeCtr.editCtrl.text,
                            );
                            if (success) {
                              EasyLoading.showSuccess(
                                  "Ajout de la tâche avec succès.");
                            } else {
                              EasyLoading.showError("Cette tâche existe déjà.");
                            }
                          }
                          homeCtr.editCtrl.clear();
                          Get.back();
                        }
                      },
                      style: const ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent),
                      ),
                      child: Text(
                        "Fait",
                        style: TextStyle(fontSize: 14.0.sp),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Text(
                  "Nouvelle tâche",
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  controller: homeCtr.editCtrl,
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veulliez entrer votre tâche ici.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
                child: Text(
                  "Ajouter une tâche",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0.sp,
                  ),
                ),
              ),
              ...homeCtr.tasks
                  .map(
                    (element) => Obx(
                      () => InkWell(
                        onTap: () => homeCtr.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp,
                            horizontal: 5.0.wp,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(element.icon,
                                        fontFamily: 'MaterialIcons'),
                                    color: HexColor.fromHex(element.color),
                                  ),
                                  SizedBox(
                                    width: 3.0.wp,
                                  ),
                                  Text(
                                    element.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0.sp,
                                    ),
                                  ),
                                ],
                              ),
                              if (homeCtr.task.value == element)
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
