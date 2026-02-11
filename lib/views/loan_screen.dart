import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../widgets/Common_card.dart';
import 'new_loan_screen.dart';

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Loans",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewLoanScreen()),
              );
            },
            icon: Icon(Icons.add, size: 20.sp),
          ),
          SizedBox(width: 12.w),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 12.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              isScrollable: false,

              indicator: BubbleTabIndicator(
                indicatorHeight: 30.h,
                indicatorColor: Colors.blue,
                indicatorRadius: 30.r,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),

              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),

              tabs: [
                _tabItem("All Loans", 80.w),
                _tabItem("Active", 80.w),
                _tabItem("Closed", 90.w),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_allLoans(), _activeLoans(), _closedLoans()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _allLoans() {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: const [
        LoanCard(isActive: true, progress: 0.54),
        LoanCard(isActive: false, progress: 0.20),
      ],
    );
  }

  Widget _activeLoans() {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: const [LoanCard(isActive: true, progress: 0.54)],
    );
  }

  Widget _closedLoans() {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: const [LoanCard(isActive: false, progress: 0.20)],
    );
  }
}

Widget _tabItem(String text, double width) {
  return Container(
    width: width,
    alignment: Alignment.center,
    child: Text(text),
  );
}

class LoanCard extends StatelessWidget {
  final bool isActive;
  final double progress;

  const LoanCard({super.key, required this.isActive, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10.r),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "LOAN003",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  isActive ? "Active" : "Closed",
                  style: TextStyle(
                    color: isActive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          Text(
            "Anita Kumari",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 12.h),

          /// Amounts
          Row(
            children: [
              _amountBox("Loan Amount", "₹15,000", Colors.black),
              SizedBox(width: 10.w),
              _amountBox("Outstanding", "₹7,980", Colors.orange),
            ],
          ),

          SizedBox(height: 16.h),

          /// Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Repayment Progress", style: TextStyle(fontSize: 12.sp)),
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            lineHeight: 5.h,
            percent: progress,
            barRadius: Radius.circular(10.r),
            backgroundColor: Colors.grey.shade200,
            progressColor: Colors.green,
          ),

          SizedBox(height: 10.h),

          Wrap(
            spacing: 12.w,
            runSpacing: 8.h,
            children: const [
              InfoChip(icon: Icons.calendar_today, text: "25/4/2024"),
              InfoChip(icon: Icons.percent, text: "12% Interest"),
              InfoChip(icon: Icons.timer, text: "26 weeks"),
              InfoChip(icon: Icons.currency_rupee, text: "₹150 EMI"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _amountBox(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: const Color(0xffF6F8FC),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
