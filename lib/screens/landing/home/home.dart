import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../helpers/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  bool showBalance = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 76,
        elevation: 2,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Row(
              children: [
                const SizedBox(width: 20),
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/svg/home/profile.png'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${userData['first_name']}!',
                        style: themeData.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: const Color(0xFF090606),
                        ),
                      ),
                      Text(
                        '@${userData['user_name']}',
                        style: themeData.textTheme.bodyMedium!
                            .copyWith(fontSize: 12),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 17),
                _actionButtons(assetName: 'history'),
                _actionButtons(assetName: 'bell', number: 2),
                const SizedBox(width: 17),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/authentication/money-pattern.png'),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      _balanceContainer(),
                      Container(
                        height: 72,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            _quickActions(
                              assetName: 'send-money',
                              title: 'Send Money',
                              alignment: const Alignment(-0.1, 0.1),
                            ),
                            const VerticalDivider(
                              indent: 10,
                              endIndent: 10,
                              color: Color(0xFFE9E9E9),
                              width: 0,
                              thickness: 1,
                            ),
                            _quickActions(
                              assetName: 'add-money',
                              title: 'Top Up',
                              alignment: const Alignment(0.05, 0),
                            ),
                            const VerticalDivider(
                              indent: 10,
                              endIndent: 10,
                              color: Color(0xFFE9E9E9),
                              width: 0,
                              thickness: 1,
                            ),
                            _quickActions(
                              assetName: 'bank',
                              title: 'Account Details',
                              alignment: const Alignment(0.1, -0.05),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      _sliderActionContainer(
                        color: const Color(0xff366543),
                        assetName: 'coins',
                        text: 'Refer a friend and earn \$3 per referral',
                        size: const Size(88, 88),
                      ),
                      _sliderActionContainer(
                        color: const Color(0xff4b4940),
                        usePadding: false,
                        assetName: 'virtual-card',
                        text: 'Create Virtual Card and pay online with ease',
                        size: const Size(90, 90),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    'Today, ${DateFormat('dd MMMM yyyy').format(DateTime.now())}',
                    style: themeData.textTheme.bodyLarge!.copyWith(
                      fontSize: 16,
                      color: const Color(0xFF273240),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                sliver: SliverList.builder(
                    itemCount: _users.length,
                    itemBuilder: (_, index) {
                      return _transactionContainer(
                          name: _users[index]['name'],
                          amount: _users[index]['amount']);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButtons({
    int? number,
    required String assetName,
  }) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 21,
            backgroundColor: const Color(0xFFF5F5F5),
            child: SvgPicture.asset('assets/svg/home/$assetName.svg'),
          ),
          Positioned(
            top: -4,
            right: 4,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: const Color(0xFFFF3F3F),
              child: number == null
                  ? null
                  : Text(
                      '$number',
                      textAlign: TextAlign.center,
                      style: themeData.textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget _balanceContainer() {
    ThemeData themeData = Theme.of(context);
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 10,
          child: Container(
            color: const Color(0xFFF4F4F4),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 24, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: const DecorationImage(
              image: AssetImage('assets/images/home/card-design.png'),
              fit: BoxFit.cover,
            ),
            color: Colors.black,
          ),
          child: Column(
            children: [
              Container(
                width: 185,
                height: 31,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: oliveGreen,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/home/coin.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Opticash Balance',
                        style: themeData.textTheme.bodyLarge!.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(2, 3, 2, 2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        weight: 10,
                        color: oliveGreen,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '\$${!showBalance ? '******' : NumberFormat().format(243998)}',
                style: themeData.textTheme.bodyLarge!.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '123848492920304.234 (OPCH)',
                style: themeData.textTheme.bodyLarge!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFCDFF00),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showBalance = !showBalance;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Icon(
                    showBalance
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _quickActions(
      {required String assetName,
      required String title,
      required AlignmentGeometry alignment}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 19,
            backgroundColor: oliveGreen,
            child: Align(
              alignment: alignment,
              child: SvgPicture.asset('assets/svg/home/$assetName.svg'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2B3503),
                ),
          ),
        ],
      ),
    );
  }

  Widget _sliderActionContainer({
    required Color color,
    bool usePadding = true,
    required String assetName,
    required String text,
    required Size size,
  }) {
    return Container(
      width: 250,
      height: 112,
      margin: EdgeInsets.only(right: usePadding ? 10 : 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
        image: const DecorationImage(
          image: AssetImage('assets/images/home/layer.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/home/$assetName.png',
            width: size.width,
            height: size.height,
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
          ))
        ],
      ),
    );
  }

  Widget _transactionContainer({required String name, required int amount}) {
    ThemeData themeData = Theme.of(context);
    return Container(
      height: 66,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.50,
          color: const Color(0xFFF4F4F4),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/home/flag.png',
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transfer to $name',
                      style: themeData.textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF273240),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '-N${NumberFormat().format(amount)}',
                      style: themeData.textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFFD82C0D),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 4,
                          backgroundColor: Color(0xFFC98115),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'Pending',
                          style: themeData.textTheme.bodyMedium!.copyWith(
                            color: const Color(0xFFC98115),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      DateFormat("d'th' MMMM yyyy").format(DateTime.now()),
                      style: themeData.textTheme.bodyMedium!.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> _users = [
    {'name': 'John', 'amount': 1850},
    {'name': 'Peter', 'amount': 2500},
  ];

  @override
  bool get wantKeepAlive => true;
}
