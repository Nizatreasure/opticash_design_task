import 'package:design_task/helpers/constants.dart';
import 'package:design_task/screens/landing/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/landing-page';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const HomePage(),
                Container(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 19,
                      offset: Offset(4, 8),
                      spreadRadius: 4,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _bottomNavBarIcons(
                      assetName: 'home',
                      navIndex: 0,
                      size: const Size(30, 30),
                    ),
                    _bottomNavBarIcons(
                      assetName: 'card',
                      navIndex: 1,
                      size: const Size(26, 25),
                    ),
                    const SizedBox(width: 60),
                    _bottomNavBarIcons(
                      assetName: 'swap',
                      navIndex: 3,
                      size: const Size(35, 22),
                    ),
                    _bottomNavBarIcons(
                      assetName: 'account',
                      navIndex: 4,
                      size: const Size(35, 22),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -20,
                child: GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(2);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        padding: const EdgeInsets.fromLTRB(7, 7, 7, 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: const Color(0xFF2C3E02),
                        ),
                        child: Image.asset(
                          'assets/images/opticash-icon.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        'Send',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: index == 2
                                  ? oliveGreen
                                  : const Color(0xffA7A7A7),
                              fontWeight: index == 2
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBarIcons(
      {required String assetName, required int navIndex, required Size size}) {
    return GestureDetector(
      onTap: () {
        _pageController.jumpToPage(navIndex);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SvgPicture.asset(
              'assets/svg/landing/$assetName.svg',
              width: size.width,
              height: size.height,
              colorFilter: ColorFilter.mode(
                index == navIndex ? oliveGreen : const Color(0xffA7A7A7),
                BlendMode.srcIn,
              ),
            ),
          ),
          Text(
            '${assetName[0].toUpperCase()}${assetName.substring(1)}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color:
                      index == navIndex ? oliveGreen : const Color(0xffA7A7A7),
                  fontWeight:
                      index == navIndex ? FontWeight.w600 : FontWeight.normal,
                ),
          )
        ],
      ),
    );
  }
}
