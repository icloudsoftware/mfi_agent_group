import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';

class RecordCollectionView extends StatefulWidget {
  const RecordCollectionView({super.key});

  @override
  State<RecordCollectionView> createState() => _RecordCollectionViewState();
}

class _RecordCollectionViewState extends State<RecordCollectionView> {
  int selectedLoan = 0;
  int paymentMode = 0;
  TextEditingController amount = TextEditingController();
  TextEditingController penalty = TextEditingController();
  TextEditingController remarks = TextEditingController();
  double totalAmount = 0.0;


  void calculateTotal (){
    final double collected = double.tryParse(amount.text) ?? 0.0;
    final double penaltyAmount = double.tryParse(penalty.text) ?? 0.0;
    setState(() {
      totalAmount = collected + penaltyAmount ;
    });
  }
  @override
  void initState() {
    super.initState();
    amount.addListener(calculateTotal);
    penalty.addListener(calculateTotal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Record Collection",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Select Loan",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),

            _loanCard(
              index: 0,
              name: "Lakshmi Devi",
              loanId: "LOAN001",
              due: "₹220",
              outstanding: "₹5,280",
            ),
            _loanCard(
              index: 1,
              name: "Savitri Bai",
              loanId: "LOAN002",
              due: "₹265",
              outstanding: "₹10,630",
            ),
            _loanCard(
              index: 2,
              name: "Anita Kumari",
              loanId: "LOAN003",
              due: "₹150",
              outstanding: "₹7,980",
            ),

            SizedBox(height: 24.h),

            /// Collection Details
            Text(
              "Collection Details",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            _input("Collected Amount", "",amount),
            _input("Penalty (if any)", "",penalty),
            SizedBox(height: 12.h),
            Text(
              "Payment Mode ",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                _paymentButton("Cash", 0),
                SizedBox(width: 10.w),
                _paymentButton("UPI", 1),
                SizedBox(width: 10.w),
                _paymentButton("Bank\nTransfer", 2),
              ],
            ),

            SizedBox(height: 16.h),

            _input("Remarks (Optional)", "Add any notes",remarks, maxLines: 3),

            SizedBox(height: 20.h),

            /// Total Amount
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "₹${totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Bottom Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.w),
        child: SizedBox(
          height: 35.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              minimumSize: Size(double.infinity, 20.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10.w),
                Text(
                  "Record Collection",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ---------------- LOAN CARD ----------------
  Widget _loanCard({
    required int index,
    required String name,
    required String loanId,
    required String due,
    required String outstanding,
  }) {
    final selected = selectedLoan == index;
    return GestureDetector(
      onTap: () => setState(() => selectedLoan = index),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: selected ? Colors.grey[100] : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? Colors.blue : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  loanId,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              "Due: $due     Outstanding: $outstanding",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- INPUT ----------------
  Widget _input(String label, String hint, TextEditingController? controller,{int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6.h),
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- PAYMENT BUTTON ----------------
  Widget _paymentButton(String text, int index) {
    final selected = paymentMode == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => paymentMode = index),
        child: Container(
          height: 56.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    amount.dispose();
    penalty.dispose();
    remarks.dispose();
    super.dispose();
  }
}
