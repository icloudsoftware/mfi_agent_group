import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:group_agent/controllers/ui_controller.dart';
import 'package:group_agent/models/ui_model.dart';
import 'package:group_agent/views/new_group_screen.dart';
import '../../theme/app_colors.dart';


class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContectController());

    final customers = [
      ContectModel(
        name: "Lakshmi Devi",
        customerId: "CUST001",
        phone: "8765432100",
        group: "Lakshmi Self Help Group",
        location: "Erode",
        status: "Verified",
      ),
      ContectModel(
        name: "Savitri Bai",
        customerId: "CUST002",
        phone: "8765432101",
        group: "Lakshmi Self Help Group",
        location: "Sitapur",
        status: "Verified",
      ),
      ContectModel(
        name: "Anita Kumari",
        customerId: "CUST003",
        phone: "8765432102",
        group: "Mahila Group",
        location: "Kurnool",
        status: "Pending",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Customers",
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewGroupScreen()));
                    }, icon: const Icon(Icons.person_add,color: Colors.white),),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText:
                  "Search by name, mobile, or ID",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),


            Obx(() => Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  _filter("All", 0, controller),
                  _filter("Active", 1, controller),
                  _filter("Inactive", 2, controller),
                ],
              ),
            )),

            SizedBox(height: 16.h),

            /// List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: customers.length,
                itemBuilder: (_, index) {
                  return CustomerCard(
                      customer: customers[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _filter(
      String text, int index, ContectController c) {
    final bool selected = c.selectedFilter.value == index;
    return GestureDetector(
      onTap: () => c.changeFilter(index),
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding:
        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: selected
                  ? Colors.white
                  : Colors.black),
        ),
      ),
    );
  }
}


class CustomerCard extends StatelessWidget {
  final ContectModel customer;
  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final bool isVerified = customer.status == "Verified";

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          /// Top Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26.r,
                backgroundColor: AppColors.primary.withOpacity(0.15),
                child: Text(
                  customer.name[0],
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
              ),
              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          customer.name,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        _statusChip(isVerified),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      customer.customerId,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        const Icon(Icons.call,
                            size: 16, color: Colors.grey),
                        SizedBox(width: 6.w),
                        Text(customer.phone),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),

          Divider(height: 24.h),

          /// Bottom Info
          Row(
            children: [
              _infoChip(Icons.group, customer.group),
              SizedBox(width: 10.w),
              _infoChip(Icons.location_on, customer.location),
            ],
          )
        ],
      ),
    );
  }

  Widget _statusChip(bool verified) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: verified
            ? Colors.green.withOpacity(0.15)
            : Colors.orange.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        verified ? "Verified" : "Pending",
        style: TextStyle(
          color: verified ? Colors.green : Colors.orange,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          SizedBox(width: 6.w),
          Text(text),
        ],
      ),
    );
  }
}
