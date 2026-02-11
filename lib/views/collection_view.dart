import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_agent/views/record_collection.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

class CollectionsView extends StatelessWidget {
  const CollectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyData = [
      {
        "name": "Lakshmi Devi",
        "loanId": "LOAN001",
        "status": AppTexts.completed,
        "due": "₹220",
        "collected": "₹220",
        "mode": "Cash",
        "date": "23/1/2026",
      },
      {
        "name": "Anita Kumari",
        "loanId": "LOAN003",
        "status": AppTexts.completed,
        "due": "₹150",
        "collected": "₹150",
        "mode": "Cash",
        "date": "23/1/2026",
      },
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTexts.collections,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordCollectionView()));},
                        icon: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              /// Tabs
              TabBar(
                isScrollable: false,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                indicator: BubbleTabIndicator(
                  indicatorHeight: 36.h,
                  indicatorColor: AppColors.primary,
                  indicatorRadius: 20.r,
                ),
                tabs: const [
                  Tab(text: AppTexts.all),
                  Tab(text: AppTexts.today),
                  Tab(text: AppTexts.thisWeek),
                ],
              ),

              SizedBox(height: 16.h),

              /// Summary
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _stat(AppTexts.totalCollected, "₹370"),
                    Container(height: 40.h, width: 1, color: Colors.grey[300]),
                    _stat(AppTexts.transactions, "2"),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  children: List.generate(
                    3,
                    (_) => ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: dummyData.length,
                      itemBuilder: (_, index) =>
                          _collectionCard(dummyData[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(String title, String value) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.grey)),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
        ),
      ],
    );
  }

  Widget _collectionCard(Map<String, String> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"]!,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Loan: ${item["loanId"]}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  item["status"]!,
                  style: TextStyle(color: AppColors.green),
                ),
              ),
            ],
          ),

          Divider(height: 24.h),

          _row("Due Amount", item["due"]!),
          _row("Collected", item["collected"]!, valueColor: AppColors.green),
          _row("Payment Mode", item["mode"]!),
          _row("Date", item["date"]!),
        ],
      ),
    );
  }

  Widget _row(String title, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, color: valueColor),
          ),
        ],
      ),
    );
  }
}
