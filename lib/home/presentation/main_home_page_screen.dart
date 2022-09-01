import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mental_health_care/auth/application/auth_controller.dart';
import 'package:mental_health_care/core/theme/brand_images.dart';
import 'package:mental_health_care/core/theme/custom_text.dart';
import 'package:mental_health_care/ui/custom_text.dart';
import 'package:mental_health_care/ui/spacing.dart';

class MainHomePageScreen extends StatefulWidget {
  const MainHomePageScreen({Key? key}) : super(key: key);

  @override
  State<MainHomePageScreen> createState() => _MainHomePageScreenState();
}

class _MainHomePageScreenState extends State<MainHomePageScreen>
    with TickerProviderStateMixin {
  final AuthController _authController = Get.put(AuthController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        // child: Center(
        //   child: GestureDetector(
        //       onTap: () {
        //         _authController.signOut();
        //       },
        //       child: Text('Main HOme page')),
        // ),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: CustomSpacing.kHorizontalPad),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              customSizeBox(context: context, size: 0.02),
              Row(children: [
                mainHeading(text: CustomText.mentalHomeTitle, context: context),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage('assets/images/${BrandImages.kSearchIconName}'),
                    color: Theme.of(context).iconTheme.color,
                    size: 30.0,
                  ),
                ),
              ]),
              TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      icon: ImageIcon(
                        AssetImage(
                            'assets/images/${BrandImages.kSearchIconName}'),
                        color: Theme.of(context).iconTheme.color,
                        size: 30.0,
                      ),
                    ),
                    Tab(
                      icon: ImageIcon(
                        AssetImage(
                            'assets/images/${BrandImages.kSearchIconName}'),
                        color: Theme.of(context).iconTheme.color,
                        size: 30.0,
                      ),
                    ),
                    Tab(
                      icon: ImageIcon(
                        AssetImage(
                            'assets/images/${BrandImages.kSearchIconName}'),
                        color: Theme.of(context).iconTheme.color,
                        size: 30.0,
                      ),
                    ),
                    Tab(
                      icon: ImageIcon(
                        AssetImage(
                            'assets/images/${BrandImages.kSearchIconName}'),
                        color: Theme.of(context).iconTheme.color,
                        size: 30.0,
                      ),
                    ),
                    Tab(
                      icon: ImageIcon(
                        AssetImage(
                            'assets/images/${BrandImages.kSearchIconName}'),
                        color: Theme.of(context).iconTheme.color,
                        size: 30.0,
                      ),
                    )
                  ]),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  Center(
                    child: Text('Tab 1'),
                  ),
                  Center(
                    child: Text('Tab 1'),
                  ),
                  Center(
                    child: Text('Tab 1'),
                  ),
                   Center(
                    child: Text('Tab 1'),
                  ),
                   Center(
                    child: Text('Tab 1'),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
                top: BorderSide(
                    color: Theme.of(context).dividerColor, width: 1.0))),
      ),
    );
  }
}
