import 'package:flutter/material.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    super.key,
    this.loading = false,
    required this.bodyWidget,
    this.verticalPadding,
  });
  final bool loading;
  final Widget bodyWidget;
  final double? verticalPadding;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: ScreenUtils.width,
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: verticalPadding ?? ScreenUtils.height * 0.08,
        ),
        child: Stack(
          children: [
            bodyWidget,
            Visibility(
              visible: loading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
