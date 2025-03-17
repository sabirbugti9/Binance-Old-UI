import 'package:binanceui/core/theme/styles/styles.dart';
import 'package:binanceui/core/theme/theme_provider.dart';
import 'package:binanceui/presentation/features/home/home_screen_viewmodel.dart';
import 'package:binanceui/presentation/features/home/widgets/charts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'widgets/open_order.dart';
import 'widgets/order_book.dart';
import 'widgets/overlay_dropdown.dart';
import 'widgets/top_bar_summary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeScreenViewModel>(context, listen: false).fetchDetails();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeScreenViewModel>(context, listen: false)
          .startUpdatingBidsAndAsks();
    });
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<HomeScreenViewModel>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
 appBar: _customAppbar(themeProvider, context),
 backgroundColor: AppColors.lightGreyColor(context),
      body: Consumer<HomeScreenViewModel>(builder: (context, home, _) {
        return   SingleChildScrollView(
            child: Column(
          children: [
            Gap(8.h),
            const TopBarSummary(),
            Gap(8.h),
            _customTabbarPart(context, home),
            Gap(18.h),
            _customTabbarViewer(context, home),
                 Gap(39.h),

         
          ].animate().fadeIn(duration: const Duration(milliseconds: 300)).moveX(duration: const Duration(milliseconds: 300))
          
        ));
      }),
    );
  }
















  Container _customTabbarViewer(
      BuildContext context, HomeScreenViewModel home) {
    return Container(
      height: 510.h,
      color: AppColors.whiteBlackColor(context),
      child: Column(children: [
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    height: 42.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.lightGreyColor(context)),
                    child: TabBar(
                      onTap: (value) {
                        home.orderTabPage(value);
                      },
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: false,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      labelColor: AppColors.blackWhiteColor(context),
                      unselectedLabelColor: AppColors.blackWhiteColor(context),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.whiteBlackColor(context),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ]),
                      tabs: [
                        Container(
                          alignment: Alignment.center,
                          height: 34.h,
                          child: Text(
                            "Open Orders",
                            style: AppStyles.black14Medium,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 34.h,
                          child: Text(
                            "Positions",
                            style: AppStyles.black14Medium,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 34.h,
                          child: Text(
                            "Order History",
                            style: AppStyles.black14Medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: home.orderTabController,
                    children: [
                      const OpenOrderPage(),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Positions",
                          style: AppStyles.black14Medium,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Order History",
                          style: AppStyles.black14Medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Container _customTabbarPart(BuildContext context, HomeScreenViewModel home) {
    return Container(
      height: 591.h,
      padding: const EdgeInsets.all(16),
      color: AppColors.whiteBlackColor(context),
      child: Column(children: [
        _customTabBar(context, home),
      ]),
    );
  }

  Expanded _customTabBar(BuildContext context, HomeScreenViewModel home) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              height: 42.h,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightGreyColor(context)),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: false,
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                labelColor: AppColors.blackWhiteColor(context),
                unselectedLabelColor: AppColors.blackWhiteColor(context),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.whiteBlackColor(context),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ]),
                onTap: (value) {
                  home.tradeTabPage(value);
                },
                tabs: [
                  SizedBox(
                    width: 115.w,
                    height: 34.h,
                    child: Center(
                      child: Text(
                        "Charts",
                        style: AppStyles.black14Medium,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 110.w,
                    height: 34.h,
                    child: Center(
                      child: Text(
                        "Orderbook",
                        style: AppStyles.black14Medium,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120.w,
                    height: 34.h,
                    child: Center(
                      child: Text(
                        "Recent trades",
                        style: AppStyles.black14Medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: home.tradeTabController,
                children: [
                  const ChartsPage(),
                  OrderBook(
                    asks: home.asks,
                    bids: home.bids,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 34.h,
                    child: Text(
                      "Recent trades",
                      style: AppStyles.black14Medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _customAppbar(ThemeProvider themeProvider, BuildContext context) {
    return AppBar(
        title: SvgPicture.asset(
          themeProvider.isDarkMode
              ? 'assets/icons/white-full-logo.svg'
              : 'assets/icons/full-logo.svg',
          width: 121.w,
          height: 34.h,
        )
            .animate()
            .fadeIn(duration: 300.ms)
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .shimmer(
                duration: 1200.ms,
                delay: 600.ms,
                color: AppColors.whiteBlackColor(context)),
        centerTitle: false,
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/dp.png',
              width: 40.w,
              fit: BoxFit.cover,
              height: 40.h,
            ),
          ),
          Gap(18.w),
          SvgPicture.asset(
            'assets/icons/globe.svg',
            width: 24.w,
            height: 34.h,
          ),
          Gap(22.8.w),
          const OverlayDropdown(),
          Gap(20.8.w),
        ]);
  }
}
