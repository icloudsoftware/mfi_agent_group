import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            /// PROFILE HEADER
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: const Color(0xFFDCE3F0)),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 44.r,
                    backgroundColor: const Color(0xFF2F6FED),
                    child: Text(
                      "A",
                      style: TextStyle(
                        fontSize: 32.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Agent Name",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "agent001",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            /// PROFILE DETAILS
            _profileTile(Icons.phone, "Mobile Number", "9876543210"),
            _profileTile(Icons.email, "Email", "agent@mail.com"),
            _profileTile(Icons.location_on, "Area", "Chennai"),
            _profileTile(Icons.badge, "Agent ID", "AGT001"),

            SizedBox(height: 24.h),

            /// ACTIONS
            _actionTile(
              icon: Icons.edit,
              title: "Edit Profile",
              onTap: () {},
            ),
            _actionTile(
              icon: Icons.lock,
              title: "Change Password",
              onTap: () {},
            ),
            _actionTile(
              icon: Icons.logout,
              title: "Logout",
              color: Colors.red,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- PROFILE INFO TILE ----------------

  Widget _profileTile(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFDCE3F0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2F6FED)),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- ACTION TILE ----------------

  Widget _actionTile({
    required IconData icon,
    required String title,
    Color color = const Color(0xFF2F6FED),
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFDCE3F0)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: color),
          ],
        ),
      ),
    );
  }
}
