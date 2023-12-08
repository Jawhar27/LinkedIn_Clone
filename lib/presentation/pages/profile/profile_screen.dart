import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_clone/app_colors.dart';
import 'package:linkedin_clone/assets.dart';
import 'package:linkedin_clone/business_logic/blocs/profile/user_info_bloc.dart';
import 'package:linkedin_clone/data/data_provider/user_info_data_provider.dart';
import 'package:linkedin_clone/data/model/category_item.dart';
import 'package:linkedin_clone/data/model/user_info.dart';
import 'package:linkedin_clone/data/repository/user_info_repository.dart';
import 'package:linkedin_clone/presentation/common_widgets/custom_divider.dart';
import 'package:linkedin_clone/presentation/common_widgets/main_button.dart';
import 'package:linkedin_clone/presentation/pages/profile/widgets/custom_tab_bar.dart';
import 'package:linkedin_clone/presentation/pages/profile/widgets/linear_percent_with_title.dart';
import 'package:linkedin_clone/presentation/pages/profile/widgets/main_title.dart';
import 'package:linkedin_clone/presentation/utils/print_logs.dart';
import 'package:linkedin_clone/presentation/utils/screen_util.dart';
import 'package:linkedin_clone/presentation/widgets/custom_appbar.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserInfoDataProvider _userInfoDataProvider = UserInfoDataProvider();
  late UserInfoBloc _userInfoBloc;
  late UserInfoRepository userInfoRepository;
  @override
  void initState() {
    super.initState();
    userInfoRepository = UserInfoRepository(
      userInfoDataProvider: _userInfoDataProvider,
    );
    _userInfoBloc = UserInfoBloc(
      userInfoRepository: userInfoRepository,
    );
    _userInfoBloc.add(FetchUserDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userInfoBloc,
      child: Scaffold(
        appBar: appBarWidget(
          context,
          isBackArrowNeeded: true,
          hintText: 'Jawhar Sivagnanam',
          isProfileScreen: true,
        ),
        body: BlocListener<UserInfoBloc, UserInfoState>(
          listener: (context, state) {
            if (state is UserInfoLoading) {
              printLogs('USER INFO LOADING');
            }
            if (state is UserInfoLoadingerror) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: state.errorMessage,
              );
            }
          },
          child: BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              if (state is UserInfoLoading) {
                return SizedBox(
                  height: ScreenUtils.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is UserInfoLoadingerror) {
                return SizedBox(
                  height: ScreenUtils.height,
                  child: const Center(
                    child:
                        Text('user information not found, Please try again !'),
                  ),
                );
              }
              if (state is UserInfoLoaded) {
                final UserInfoData userInfoData = state.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            profileCoverIImage,
                            height: ScreenUtils.height * 0.14,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: ScreenUtils.height * 0.04,
                            left: 20,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 65,
                                  backgroundColor: AppColors.white,
                                  child: CircleAvatar(
                                    radius: 60,
                                    child: Image.asset(
                                      person,
                                    ),
                                  ),
                                ),
                                const Positioned(
                                    bottom: 1,
                                    right: 1,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColors.blue,
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.create_outlined,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 11.0,
                          vertical: ScreenUtils.height * 0.04,
                        ),
                        child: Column(
                          children: [
                            _profileContent(userInfoData),
                            _mainDivider(),
                            _suggestedForYouContent(),
                            _mainDivider(),
                            _analyticsContent(
                              profileViews: (userInfoData.noOfProfileViews ?? 0)
                                  .toString(),
                              postImpressions:
                                  (userInfoData.noOfPostImpressions ?? 0)
                                      .toString(),
                              searchAppearances:
                                  (userInfoData.noOfSearchAppearances ?? 0)
                                      .toString(),
                            ),
                            _mainDivider(),
                            _resourcesContent(
                              creatorMode: userInfoData.creatorMode ?? false,
                            ),
                            _mainDivider(),
                            _activityContent(),
                            _mainDivider(),
                            _customListView(
                              height: ScreenUtils.height * 0.4,
                              items: userInfoData.workExperience!,
                              mainTitle: 'Work Experience',
                              mainPrefixIcon: Icons.house,
                            ),
                            _mainDivider(),
                            _customListView(
                              height: ScreenUtils.height * 0.4,
                              items: userInfoData.education!,
                              mainTitle: 'Education',
                              mainPrefixIcon: Icons.house,
                            ),
                            _mainDivider(),
                            _customListView(
                              height: ScreenUtils.height * 0.33,
                              items: userInfoData.skills!,
                              additionlRowButtonText: 'Demonstrate Skills',
                              mainTitle: 'Skills',
                              subTextPreficIcon: Icons.grid_view_rounded,
                              showAllFuntionText: 'Show all 20 Skills',
                            ),
                            _mainDivider(),
                            _customListView(
                              height: ScreenUtils.height * 0.36,
                              items: userInfoData.courses!,
                              mainTitle: 'Courses',
                              showAllFuntionText: 'Show all 10 Courses',
                            ),
                            _mainDivider(),
                            _interestsContent(userInfoData.interestCompanies!),
                            _mainDivider(),
                            _customListView(
                              height: ScreenUtils.height * 0.41,
                              items: userInfoData.viewedPeopleList!,
                              mainTitle: 'People also viewed',
                              bottomButtonText: 'Connect',
                              bottomButtonIcon: Icons.person_add,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _peopleAlsoViewed() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        MainTitle(
          title: 'People also viewed',
        ),
        SizedBox(
          height: 10,
        ),
        MainTitle(
          title: 'Virat Kohli',
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          mainPrefixIcon: Icons.person_2,
          subTitle: 'Student at Sabaragamuwa University',
          bottomButtonText: 'Connect',
          bottomButtonIcon: Icons.person_add,
        ),
        SizedBox(
          height: 10,
        ),
        CustomDivider(
          dividerHeight: 1.0,
          dividerColor: AppColors.linkedInLightGrey,
          isNormalDivider: true,
        ),
        SizedBox(
          height: 10,
        ),
        MainTitle(
          title: 'Hardik pandya',
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          mainPrefixIcon: Icons.person_2,
          subTitle: 'Student at Sabaragamuwa University',
          bottomButtonText: 'Connect',
          bottomButtonIcon: Icons.person_add,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _interestsContent(List<CategoryItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const MainTitle(
          title: 'Interests',
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTabBar(
          tab1Text: 'Companies',
          tab2Text: 'Groups',
          tab3Text: 'News Letters',
          tab4Text: 'Schools',
          child1: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: ScreenUtils.height * 0.33,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        MainTitle(
                          title: items[index].itemTitle ?? '',
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                          mainPrefixIcon: Icons.house,
                          subTitle: items[index].subText1,
                          bottomButtonText: 'Following',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomDivider(
                          dividerHeight: 1.0,
                          dividerColor: AppColors.linkedInLightGrey,
                          isNormalDivider: true,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // To-do Navigate to resources screen
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show all companies',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mediumGrey,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.mediumGrey,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          child2: Container(),
          child3: Container(),
          child4: Container(),
        ),
      ],
    );
  }

  Widget _customListView({
    required List<CategoryItem> items,
    required String mainTitle,
    IconData? mainPrefixIcon,
    IconData? subTextPreficIcon,
    double? height,
    String? showAllFuntionText,
    String? additionlRowButtonText,
    String? bottomButtonText,
    IconData? bottomButtonIcon,
    void Function()? onAdditionalRowButtonTap,
    void Function()? onAddIconPressed,
    void Function()? onEditIconPressed,
    void Function()? onShowAllFunctionTap,
  }) {
    return SizedBox(
        height: height ?? ScreenUtils.height * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainTitle(
                  title: mainTitle,
                  subTitleStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.linkedInBlue,
                  ),
                ),
                Row(
                  children: [
                    Visibility(
                      visible: additionlRowButtonText != null,
                      child: SizedBox(
                        width: ScreenUtils.width * 0.45,
                        height: ScreenUtils.height * 0.04,
                        child: MainButton(
                          onTap: onAdditionalRowButtonTap,
                          buttonText: additionlRowButtonText ?? '',
                          borderColor: AppColors.linkedInBlue,
                          buttonTextStyle: const TextStyle(
                            color: AppColors.linkedInBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onAddIconPressed,
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: onEditIconPressed,
                      icon: const Icon(
                        Icons.create_outlined,
                      ),
                    )
                  ],
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Visibility(
                        visible: index != 0,
                        child: const SizedBox(
                          height: 10,
                        ),
                      ),
                      MainTitle(
                        title: items[index].itemTitle ?? '',
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                        mainPrefixIcon: mainPrefixIcon,
                        subWidgetPrefixIcon: subTextPreficIcon,
                        subTitle: items[index].subText1 ?? '',
                        subTitle2: items[index].subText2,
                        bottomButtonText: bottomButtonText,
                        bottomButtonIcon: bottomButtonIcon,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: showAllFuntionText != null ||
                            index != (items.length - 1),
                        child: const CustomDivider(
                          dividerHeight: 1.0,
                          dividerColor: AppColors.linkedInLightGrey,
                          isNormalDivider: true,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Visibility(
              visible: showAllFuntionText != null,
              child: GestureDetector(
                onTap: onShowAllFunctionTap,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        showAllFuntionText ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mediumGrey,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.mediumGrey,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _mainDivider() {
    return const CustomDivider(
      dividerHeight: 8.0,
      dividerColor: AppColors.linkedInLightGrey,
      isNormalDivider: true,
    );
  }

  Widget _activityContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MainTitle(
              title: 'Activity',
              subTitle: '209 followers',
              subTitleStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.linkedInBlue,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: ScreenUtils.width * 0.4,
                  height: ScreenUtils.height * 0.04,
                  child: MainButton(
                    onTap: () {
                      // To-do CREATE NEW POST
                    },
                    buttonText: 'Create a post',
                    borderColor: AppColors.linkedInBlue,
                    buttonTextStyle: const TextStyle(
                      color: AppColors.linkedInBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.create_outlined,
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const MainTitle(
          title: 'Jawhar Sivagnanam commented on a post - 5 mo',
          titleStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          subTitle: 'Congratulations',
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomDivider(
          dividerHeight: 1.0,
          dividerColor: AppColors.linkedInLightGrey,
          isNormalDivider: true,
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            // To-do Navigate to resources screen
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Show all comments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mediumGrey,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Icon(
                Icons.arrow_forward,
                color: AppColors.mediumGrey,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _resourcesContent({
    bool creatorMode = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const MainTitle(
          title: 'Resources',
          subWidgetPrefixIcon: Icons.visibility,
          subTitle: ' Private to you',
        ),
        const SizedBox(
          height: 10,
        ),
        MainTitle(
          title: 'Creator Mode - ${creatorMode ? 'ON' : 'OFF'}',
          titleStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          mainPrefixIcon: Icons.celebration_outlined,
          subTitle:
              'Get discovered, showcase content on your profile, and get access to create tools',
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomDivider(
          dividerHeight: 1.0,
          dividerColor: AppColors.linkedInLightGrey,
          isNormalDivider: true,
        ),
        const SizedBox(
          height: 10,
        ),
        const MainTitle(
          title: 'My network',
          titleStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          mainPrefixIcon: Icons.grid_view_rounded,
          subTitle: 'See and manage your connections and interests.',
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomDivider(
          dividerHeight: 1.0,
          dividerColor: AppColors.linkedInLightGrey,
          isNormalDivider: true,
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            // To-do Navigate to resources screen
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Show all 3 resources',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mediumGrey,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Icon(
                Icons.arrow_forward,
                color: AppColors.mediumGrey,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _analyticsContent({
    String? profileViews,
    String? postImpressions,
    String? searchAppearances,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const MainTitle(
          title: 'Analytics',
          subWidgetPrefixIcon: Icons.visibility,
          subTitle: ' Private to you',
        ),
        const SizedBox(
          height: 10,
        ),
        MainTitle(
          title: '$profileViews profile views',
          titleStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          mainPrefixIcon: Icons.grid_view_rounded,
          subTitle: 'Discover who\'s viewed your profile',
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomDivider(
          dividerHeight: 1.0,
          dividerColor: AppColors.linkedInLightGrey,
          isNormalDivider: true,
        ),
        const SizedBox(
          height: 10,
        ),
        MainTitle(
          title: '$postImpressions, post impressions',
          titleStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          mainPrefixIcon: Icons.stacked_bar_chart,
          subTitle: 'Discover who\'s viewed your profile',
        ),
        const SizedBox(
          height: 10,
        ),
        const CustomDivider(
          dividerHeight: 1.0,
          dividerColor: AppColors.linkedInLightGrey,
          isNormalDivider: true,
        ),
        const SizedBox(
          height: 10,
        ),
        MainTitle(
          title: '$searchAppearances, search appearances',
          titleStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          mainPrefixIcon: Icons.search,
          subTitle: 'Discover who\'s viewed your profile',
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _suggestedForYouContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        MainTitle(
          title: 'Suggested for you',
          subWidgetPrefixIcon: Icons.visibility,
          subTitle: ' Private to you',
        ),
        SizedBox(
          height: 10,
        ),
        TitlewithPercentIndicator(
          title: 'Intermediate',
          percentage: 0.7,
          subtitleWidget: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Complete 2 steps to achieve ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: 'All-star',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _profileContent(UserInfoData userData) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitle(
            title: userData.name ?? '',
            subTitle: userData.workPosition,
          ),
          const SizedBox(
            height: 10,
          ),
          MainTitle(
            title: userData.workPlace ?? '',
            subTitle: userData.country,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
            subTitleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.mediumGrey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${userData.noOfConnections} connections',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.linkedInBlue,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: ScreenUtils.width * 0.4,
                height: ScreenUtils.height * 0.05,
                child: const MainButton(
                  buttonText: 'Open to',
                  buttonColor: AppColors.linkedInBlue,
                  buttonTextStyle: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtils.width * 0.4,
                height: ScreenUtils.height * 0.05,
                child: const MainButton(
                  buttonText: 'Add section',
                  borderColor: AppColors.linkedInBlue,
                  buttonTextStyle: TextStyle(
                    color: AppColors.linkedInBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: ScreenUtils.height * 0.05,
                width: ScreenUtils.height * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: AppColors.mediumGrey,
                      width: 1.0,
                    )),
                child: const Icon(
                  Icons.more_horiz_rounded,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
