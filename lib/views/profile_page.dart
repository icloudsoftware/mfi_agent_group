import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

  final TextEditingController nameCtrl =
  TextEditingController(text: "Agent Name");
  final TextEditingController mobileCtrl =
  TextEditingController(text: "9876543210");
  final TextEditingController emailCtrl =
  TextEditingController(text: "agent@mail.com");
  final TextEditingController areaCtrl =
  TextEditingController(text: "Chennai");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.check : Icons.edit_outlined,
              color: const Color(0xFF2F6FED),
            ),
            onPressed: () {
              setState(() => isEditing = !isEditing);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [

            /// PROFILE CARD (PROFESSIONAL)
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE0E6ED)),
              ),
              child: Column(
                children: [

                  /// AVATAR + CAMERA
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 46.r,
                        backgroundColor: const Color(0xFFEDF1F7),
                        child: Text(
                          "A",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2F6FED),
                          ),
                        ),
                      ),
                      if (isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              // Image picker
                            },
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.r),
                                border:
                                Border.all(color: const Color(0xFFE0E6ED)),
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                size: 18,
                                color: Color(0xFF2F6FED),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  _field(
                    Icons.person_outline,
                    const Color(0xFF2F6FED),
                    "Name",
                    nameCtrl,
                  ),

                  _field(
                    Icons.phone_outlined,
                    Colors.green,
                    "Mobile Number",
                    mobileCtrl,
                    keyboard: TextInputType.phone,
                  ),

                  _field(
                    Icons.email_outlined,
                    Colors.deepPurple,
                    "Email",
                    emailCtrl,
                    keyboard: TextInputType.emailAddress,
                  ),

                  _field(
                    Icons.location_on_outlined,
                    Colors.orange,
                    "Area",
                    areaCtrl,
                  ),

                ],
              ),
            ),

            SizedBox(height: 24.h),

            /// LOGOUT
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE0E6ED)),
              ),
              child: ListTile(
                onTap: () {},
                leading:
                const Icon(Icons.logout_outlined, color: Colors.redAccent),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing:
                const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// PROFESSIONAL INPUT FIELD
  Widget _field(
      IconData icon,
      Color iconColor,
      String label,
      TextEditingController controller, {
        TextInputType keyboard = TextInputType.text,
      }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LABEL
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8.h),

          /// FIELD CONTAINER
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isEditing
                    ? const Color(0xFF2F6FED)
                    : const Color(0xFFE3E7EE),
              ),
              boxShadow: isEditing
                  ? [
                BoxShadow(
                  color: const Color(0xFF2F6FED).withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ]
                  : [],
            ),
            child: Row(
              children: [
                /// ICON WITH BACKGROUND (PRO LOOK)
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: iconColor,
                  ),
                ),

                SizedBox(width: 14.w),

                /// TEXT / INPUT
                Expanded(
                  child: isEditing
                      ? TextFormField(
                    controller: controller,
                    keyboardType: keyboard,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  )
                      : Text(
                    controller.text,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
