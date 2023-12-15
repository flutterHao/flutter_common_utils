import '../common/exports/common_lib.dart';
import '../generated/r.dart';

class HomeBgWidget extends StatelessWidget {
  const HomeBgWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: ScreenUtil().screenWidth,
        child: Image.asset(R.homebgBgToubumokuai,
            fit: BoxFit.fitWidth, package: 'flutter_lib_shared'),
      ),
    );
  }
}
