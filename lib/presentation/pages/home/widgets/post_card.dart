import 'package:flutter/material.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/assets.dart';
import 'package:linkedin_clone/data/model/post_data.dart';
import 'package:linkedin_clone/presentation/common_widgets/custom_divider.dart';

class SinglePostCardWidget extends StatefulWidget {
  final PostData post;
  const SinglePostCardWidget({super.key, required this.post});

  @override
  State<SinglePostCardWidget> createState() => _SinglePostCardWidgetState();
}

class _SinglePostCardWidgetState extends State<SinglePostCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.linkedInWhite,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _postTitle(),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${widget.post.postDescription}",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: widget.post.tags!.map((tag) {
                  return Text(
                    "$tag ",
                    style: const TextStyle(
                      color: AppColors.linkedInBlue,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
        _imageView(),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Positioned(
                child: _reactionWidget(
                  bgColor: Colors.blue.shade200,
                  image: appleIcon,
                ),
              ),
              Positioned(
                left: 16,
                child: _reactionWidget(
                  bgColor: Colors.red.shade200,
                  image: appleIcon,
                ),
              ),
              Positioned(
                left: 34,
                child: _reactionWidget(
                  bgColor: Colors.amber.shade200,
                  image: appleIcon,
                ),
              ),
              Positioned(
                left: 70,
                child: Text("${widget.post.totalReactions}"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${widget.post.totalComments} comments - ",
                    style: const TextStyle(
                        color: AppColors.mediumGrey, fontSize: 15),
                  ),
                  Text(
                    "${widget.post.totalReposts} reposts",
                    style: const TextStyle(
                        color: AppColors.mediumGrey, fontSize: 15),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const CustomDivider(
          dividerHeight: 1.0,
          isNormalDivider: true,
          dividerColor: AppColors.linkedInLightGrey,
        ),
        const SizedBox(
          height: 10,
        ),
        _actions(),
        const SizedBox(
          height: 10,
        ),
        const CustomDivider(
          dividerHeight: 8.0,
          isNormalDivider: true,
          dividerColor: AppColors.linkedInLightGrey,
        )
      ],
    );
  }

  Widget _actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _actionItemWidget(
          icon: Icons.thumb_up_alt_outlined,
          title: "Like",
        ),
        _actionItemWidget(
          icon: Icons.comment,
          title: "Comment",
        ),
        _actionItemWidget(
          icon: Icons.report_gmailerrorred_sharp,
          title: "Repost",
        ),
        _actionItemWidget(
          icon: Icons.send,
          title: "Send",
        ),
      ],
    );
  }

  Widget _postTitle() {
    return Row(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset(
                googleIcon,
              )),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${widget.post.username}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.more_vert,
                    ),
                  )
                ],
              ),
              Text(
                "${widget.post.userDescription}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.mediumGrey,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    "${widget.post.createdAt} ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.mediumGrey,
                    ),
                  ),
                  const Icon(
                    Icons.timelapse,
                    size: 15,
                    color: AppColors.mediumGrey,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _imageView() {
    return (widget.post.postImages?.isEmpty ?? true)
        ? Container(
            width: double.infinity,
            color: AppColors.mediumGrey,
            child: Image.asset("${widget.post.postImage}"),
          )
        : SizedBox(
            height: 400,
            child: Stack(
              children: [
                PageView(
                  children: widget.post.postImages!.map((image) {
                    return Container(
                      width: double.infinity,
                      color: AppColors.mediumGrey,
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
                Positioned(
                    right: 15,
                    top: 15,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.linkedInWhite,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image,
                        ),
                      ),
                    ))
              ],
            ),
          );
  }

  _actionItemWidget({IconData? icon, String? title}) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.mediumGrey,
          ),
          Text(
            "$title",
            style: const TextStyle(
              color: AppColors.mediumGrey,
            ),
          )
        ],
      ),
    );
  }

  Widget _reactionWidget({String? image, Color? bgColor}) {
    return Container(
      padding: const EdgeInsets.all(
        5.0,
      ),
      decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: AppColors.linkedInWhite,
          )),
      child: Image.asset(
        "$image",
        width: 10,
        height: 10,
      ),
    );
  }
}
