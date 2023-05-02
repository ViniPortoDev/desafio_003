import 'package:app/modules/pages/desktop/home_page_desktop.dart';
import 'package:app/modules/pages/mobile/home_page_mobile.dart';
import 'package:app/utils/screen_helper.dart';
import 'package:flutter/material.dart';
import '../../repositories/task_repositories.dart';
import '../../service/prefs_service.dart';
import '../../stores/task_store.dart';

class HomePage extends StatelessWidget {
  //TODO
  // final TaskStore taskStore;
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenHelperWidget(
      desktop: HomePageDesktop(
        taskStore: TaskStore(
          TaskDataBaseRepository(
            PrefsLocalStorageService(),
          ),
        ),
      ),
      tablet: const Center(
        child: Text('EM CONSTRUÇÃO'),
      ),
      mobile: const HomePageMobile(),
    );
  }
}