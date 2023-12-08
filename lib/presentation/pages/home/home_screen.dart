import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/business_logic/blocs/home/bloc/post_bloc.dart';
import 'package:linkedin_clone/data/model/post_data.dart';
import 'package:linkedin_clone/presentation/common_widgets/custom_divider.dart';
import 'package:linkedin_clone/presentation/pages/home/widgets/post_card.dart';
import 'package:linkedin_clone/presentation/utils/sample_data/post_data.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';
import 'package:quickalert/quickalert.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({
    super.key,
  });

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  final ScrollController _controller = ScrollController();

  bool _isShow = true;

  List<PostData> postData = postListData;

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.pixels > 3) {
        setState(() {
          _isShow = false;
        });
      } else {
        setState(() {
          _isShow = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<PostBloc, PostState>(
      bloc: BlocProvider.of<PostBloc>(context),
      listener: (context, state) {
        if (state is PostLoadingerror) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: state.errorMessage,
          );
        }
      },
      child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
        if (state is PostLoading) {
          return SizedBox(
            height: ScreenUtils.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is PostLoadingerror || state is NoPostsFound) {
          return SizedBox(
            height: ScreenUtils.height,
            child: const Center(
              child: Text('No Posts found, Please try again !'),
            ),
          );
        }

        if (state is PostLoaded) {
          return Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              _isShow
                  ? const CustomDivider(
                      dividerHeight: 8.0,
                      isNormalDivider: true,
                      dividerColor: AppColors.linkedInLightGrey,
                    )
                  : Container(),
              Expanded(
                child: ListView.builder(
                  controller: _controller,
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return SinglePostCardWidget(post: post);
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      }),
    ));
  }
}
