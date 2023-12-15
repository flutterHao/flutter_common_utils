import 'package:flutter_lib_shared/common/exports/common_lib.dart';

import '../generated/r.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Container(
          height: 240.0.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(250, 255, 255, 1),
                  Color.fromRGBO(241, 245, 255, 1)
                ]),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0.w),
              bottomRight: Radius.circular(50.0.w),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40.0.w,
                    height: 40.0.h,
                    margin: EdgeInsets.only(
                      top: 10.0.h,
                      left: 10.0.w,
                      bottom: 30.0.h,
                    ),
                    color: const Color.fromRGBO(248, 248, 248, 0.5),
                    child: Image.asset(R.regIconClosTitle, package: 'flutter_lib_shared'),
                  ),
                ],
              ),
              Container(
                height: 72.w,
                width: 72.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(240.0.h);
}
