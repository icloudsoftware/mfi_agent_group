import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_agent/views/loan_screen.dart';
import 'package:group_agent/views/record_collection.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'add_customer.dart';
import 'collection_view.dart';
import 'incentivesScreen.dart';
import 'new_loan_screen.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppTexts.goodDay, style: TextStyle(fontSize: 14.sp)),
              Text(
                AppTexts.agentDashboard,
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20.h),

              _statCard(
                title: "Total Collection",
                value: "₹3",
                icon: Icons.currency_rupee_outlined,
                color: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CollectionsView()),
                  );
                },
              ),
              _statCard(
                title: "Pending Dues",
                value: "3",
                icon: Icons.pending_actions,
                color: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CollectionsView()),
                  );
                },
              ),
              _statCard(
                title: "Incentive Earned",
                value: "₹0",
                icon: Icons.emoji_events,
                color: AppColors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IncentivesScreen()),
                  );
                },
              ),
              _statCard(
                title: "Active Loans",
                value: "3",
                icon: Icons.account_balance_wallet,
                color: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoansScreen()),
                  );
                },
              ),

              SizedBox(height: 24.h),

              Text(
                AppTexts.quickActions,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 12.h),

              SizedBox(
                height: 160.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _quickActionCard(
                      title: "Record Collection",
                      icon: Icons.add,
                      color: AppColors.green,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordCollectionView(),
                          ),
                        );
                      },
                    ),
                    _quickActionCard(
                      title: "Add Customer",
                      icon: Icons.person_add,
                      color: AppColors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCustomerView(),
                          ),
                        );
                      },
                    ),
                    _quickActionCard(
                      title: "New Loan",
                      icon: Icons.account_balance,
                      color: AppColors.orange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewLoanScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- STAT CARD ----------------
  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 14.sp)),
                  SizedBox(height: 4.h),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14.sp),
          ],
        ),
      ),
    );
  }

  /// ---------------- QUICK ACTION CARD ----------------
  Widget _quickActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 140.w,
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 30.sp),
            Spacer(),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
