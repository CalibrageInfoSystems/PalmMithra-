// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:akshaya_flutter/Services/GodownSelectionScreen.dart';
import 'package:akshaya_flutter/Services/plots_screen.dart';
import 'package:akshaya_flutter/common_utils/api_config.dart';
import 'package:akshaya_flutter/common_utils/common_styles.dart';
import 'package:akshaya_flutter/common_utils/shared_prefs_keys.dart';
import 'package:akshaya_flutter/gen/assets.gen.dart';
import 'package:akshaya_flutter/localization/locale_keys.dart';
import 'package:akshaya_flutter/models/banner_model.dart';
import 'package:akshaya_flutter/models/learning_model.dart';
import 'package:akshaya_flutter/models/service_model.dart';
import 'package:akshaya_flutter/screens/home_screen/Learning/EncyclopediaActivity.dart';
import 'package:akshaya_flutter/screens/home_screen/home_screen.dart';
import 'package:akshaya_flutter/screens/home_screen/screens/farmer_passbook.dart';
import 'package:akshaya_flutter/screens/home_screen/screens/ffb_collection_screen.dart';
import 'package:akshaya_flutter/screens/home_screen/screens/loan_request_screen.dart';
import 'package:akshaya_flutter/screens/home_screen/screens/plot_selection_screen.dart';
import 'package:akshaya_flutter/screens/home_screen/screens/quick_pay_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  late Future<List<int>> servicesData;
  late Future<List<String?>> learningsData;
  late Future<List<BannerModel>> bannersAndMarqueeTextData;
  String greeting = "Good Morning";
  String location = "";
  String temperature = "";
  @override
  void initState() {
    super.initState();
    servicesData = getServicesData();
    learningsData = getLearningsData();
    bannersAndMarqueeTextData = getBannersAndMarqueeText();
    _initializeGreetingWeather();
  }

  Future<List<int>> getServicesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final statecode = prefs.getString(SharedPrefsKeys.statecode);
    final apiUrl = '$baseUrl$getServices$statecode';

    try {
      final jsonResponse = await http.get(Uri.parse(apiUrl));
      print('getServicesData: $apiUrl');
      print('getServicesData: ${jsonResponse.body}');
      if (jsonResponse.statusCode == 200) {
        final response = jsonDecode(jsonResponse.body);
        List<dynamic> servicesList = response['listResult'];

        List<int> serviceTypeIds = servicesList
            .map((item) => ServiceModel.fromJson(item))
            .map((service) => service.serviceTypeId)
            .where((serviceTypeId) => serviceTypeId != 108)
            .map((id) => id!)
            .toList();
        return serviceTypeIds;
      } else {
        throw Exception(
            'We encountered an issue while retrieving the services data. Please try again later');
        // throw Exception('Failed to get learning data');
      }
    } on SocketException {
      /*  ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            tr(LocaleKeys.Internet),
          ),
        ),
      ); */
      throw Exception(
        tr(LocaleKeys.Internet),
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<List<String?>> getLearningsData() async {
    final apiUrl = '$baseUrl$getlearning';
    try {
      final jsonResponse = await http.get(Uri.parse(apiUrl));
      if (jsonResponse.statusCode == 200) {
        final response = jsonDecode(jsonResponse.body);
        List<dynamic> learningList = response['listResult'];
        List<LearningModel> result =
            learningList.map((item) => LearningModel.fromJson(item)).toList();
        Locale currentLocale =
            EasyLocalization.of(context)?.locale ?? const Locale('en');

        // Map names based on the locale
        return result.map((item) {
          switch (currentLocale.toString()) {
            case 'te_IN': // Telugu
              return item.teluguName ?? item.name;
            case 'hi_IN': // Hindi
              return item.hindiName ?? item.name;
            case 'kn_IN': // Kannada
              return item.kannadaName ?? item.name;
            default: // Default to English
              return item.name;
          }
        }).toList();
      } else {
        throw Exception('Failed to get learning data');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<BannerModel>> getBannersAndMarqueeText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final statecode = prefs.getString(SharedPrefsKeys.statecode);
    final apiUrl = '$baseUrl$getbanners/$statecode';
    try {
      final jsonResponse = await http.get(Uri.parse(apiUrl));
      if (jsonResponse.statusCode == 200) {
        List<dynamic> response = json.decode(jsonResponse.body)['listResult'];
        return response.map((item) => BannerModel.fromJson(item)).toList();
      } else {
        throw Exception(
            'Request failed with status: ${jsonResponse.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
/* 
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      learningsData = getLearningsData();
    });
  } */

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    EasyLocalization.of(context)?.locale;
    setState(() {
      learningsData = getLearningsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: CommonStyles.homeBgColor,
        body: Column(
          children: [
            // header(),
            SizedBox(height: isTablet ? 20 : 12),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header(isTablet),
                      const SizedBox(height: 12),
             /*         SizedBox(
                        height: isTablet ? 50 : 40,
                        child: marqueeText(),
                      ),*/
                      banners(size),

                      const SizedBox(height: 12),
                      sectionLabel(tr(LocaleKeys.view)),
                      const SizedBox(height: 6),
                      viewGrid(size),
                      // overViewSection(size),
                      const SizedBox(height: 10),
                      sectionLabel(tr(LocaleKeys.req_services)),
                      const SizedBox(height: 6),
                      servicesSection(size),
                      const SizedBox(height: 10),
                      sectionLabel(tr(LocaleKeys.learning)),
                      const SizedBox(height: 6),
                      learningSection(size),
                      // learningRourcesSection(size),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> views = [
    {
      'title': tr(LocaleKeys.collection),
      'widget': const FfbCollectionScreen(),
      'assetName': Assets.images.ffbcollection.path,
    },
    {
      'title': tr(LocaleKeys.payments),
      'widget': const FarmerPassbookScreen(),
      'assetName': Assets.images.bill.path,
    },
    {
      'title': tr(LocaleKeys.recommendationss),
      'widget': const PlotSelectionScreen(
        serviceTypeId: 101,
      ),
      'assetName': Assets.images.cropmain.path,
    },
  ];

  Container header(bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 30 : 25,
        vertical: isTablet ? 25 : 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: CommonStyles.themeTextColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$greeting',
            style: CommonStyles.txStyF20CbFcF5.copyWith(
              fontWeight: FontWeight.bold,
              color: CommonStyles.whiteColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            location.isNotEmpty && temperature.isNotEmpty
                ? "Sunny, $temperature in $location"
                : "Fetching weather...",
            style: CommonStyles.txStyF20CbFcF5.copyWith(
              fontSize: 13,
              color: CommonStyles.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Text sectionLabel(String title) {
    return Text(
      ' $title',
      style: CommonStyles.txStyF20CbFcF5.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: CommonStyles.themeTextColor,
      ),
    );
  }

  Row overViewSection(Size size) {
    final isTablet = size.width > 600;
    return Row(
      children: [
        customLayout(
          size: size,
          assetName: 'assets/pl.svg',
          title: tr(LocaleKeys.collection),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FfbCollectionScreen(),
              ),
            );
          },
        ),
        SizedBox(width: isTablet ? 20 : 12),
        customLayout(
          size: size,
          assetName: 'assets/pl.svg',
          title: tr(LocaleKeys.payments),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FarmerPassbookScreen(),
              ),
            );
          },
        ),
        SizedBox(width: isTablet ? 20 : 12),
        customLayout(
          size: size,
          assetName: 'assets/pl.svg',
          title: tr(LocaleKeys.recommendationss),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PlotSelectionScreen(
                  serviceTypeId: 101,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget servicesSection(Size size) {
    return FutureBuilder(
      future: servicesData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Skeletonizer(
            enabled: true,
            child: serviceGrid([1, 2, 3, 4, 5, 6], size),
          );
        } else if (snapshot.hasError) {
          return const SizedBox();
        }
        final services = snapshot.data as List<int>;
        if (services.isEmpty) {
          return Center(
            child: Text(
              tr(LocaleKeys.no_services),
              style: CommonStyles.txStyF20CbFcF5.copyWith(
                fontSize: 16,
                color: CommonStyles.themeTextColor,
              ),
            ),
          );
        }
        return serviceGrid(services, size);
      },
    );
  }

  GridView viewGrid(Size size) {
    return GridView.builder(
      itemCount: views.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = views[index];
        return customLayout(
          size: size,
          title: getServiceName(index),
          // title: item['title'],
          padding: EdgeInsets.zero,
          assetName: item['assetName'],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => item['widget'],
              ),
            );
          },
        );
      },
    );
  }

  GridView serviceGrid(List<int> services, Size size) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: services.map((serviceTypeId) {
        return customLayout(
          size: size,
          title: getServiceName(serviceTypeId),
          assetName: getServiceAssetImg(serviceTypeId),
          padding: EdgeInsets.zero,
          onTap: () => navigateToSelectedServiceScreen(serviceTypeId),
        );
      }).toList(),
    );
  }

  Widget learningSection(Size size) {
    return FutureBuilder(
      future: learningsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Skeletonizer(
            enabled: true,
            child: learningGrid(['1', '2', '3'], size),
          );
        } else if (snapshot.hasError) {
          return const SizedBox();
        }
        final learnings = snapshot.data as List<String?>;
        if (learnings.isEmpty) {
          return Center(
            child: Text(
              tr(LocaleKeys.learning),
              style: CommonStyles.txStyF20CbFcF5.copyWith(
                fontSize: 16,
                color: CommonStyles.themeTextColor,
              ),
            ),
          );
        }
        return learningGrid(learnings, size);
      },
    );
  }

  String getServiceName(int serviceTypeId) {
    switch (serviceTypeId) {
      case 0: // Collection
        return tr(LocaleKeys.collection);
      case 1: // Passbook
        return tr(LocaleKeys.payments);
      case 2: // Recommendations
        return tr(LocaleKeys.recommendationss);
      case 10: // Pole Request
        return tr(LocaleKeys.pole);
      case 11: // Labour Request
        return tr(LocaleKeys.labour_lable);
      case 12: // Fertilizer Request
        return tr(LocaleKeys.fertilizer);
      case 13: // QuickPay Request
        return tr(LocaleKeys.quick);
      case 14: // Visit Request
        return tr(LocaleKeys.visit);
      case 28: // Loan Request
        return tr(LocaleKeys.loan);
      case 107: // Bio Lab Request
        return tr(LocaleKeys.labproducts);
      case 108: // Transport Request
        return tr(LocaleKeys.App_version);
      case 116: // Edible Oils Request
        return tr(LocaleKeys.edibleoils);

      default:
        return tr(LocaleKeys.my3F);
    }
  }

  String getServiceAssetImg(int serviceTypeId) {
    switch (serviceTypeId) {
      case 10: // Pole Request
        return Assets.images.equipmentAsset.path;
      case 11: // Labour Request
        return Assets.images.labourAsset.path;
      case 12: // Fertilizer Request
        return Assets.images.fertilizerAsset.path;
      case 13: // QuickPay Request
        return Assets.images.quickPayAsset.path;
      case 14: // Visit Request
        return Assets.images.visitAsset.path;
      case 28: // Loan Request
        return Assets.images.loanAsset.path;
      case 107: // Bio Lab Request
        return Assets.images.bioLabAsset.path;
      case 108: // Transport Request
        return Assets.images.progressComplete.path;
      case 116: // Edible Oils Request
        return Assets.images.edibleOilAsset.path;
      case 501: // Pest and Disease
        return Assets.images.pestanddiseasesAsset.path;
      case 502: // Oil Palm Management
        return Assets.images.oilPlamAsset.path;
      case 503: // General
        return Assets.images.generalAsset.path;

      default:
        return Assets.images.progressComplete.path;
    }
  }

  String getLearningsAssetImg(int serviceTypeId) {
    switch (serviceTypeId) {
      case 0: // Fertilizers
        return Assets.images.fertilizerAsset.path;
      case 1: // Harversting
        return Assets.images.equipmentAsset.path;
      case 2: // Pest and Disease
        return Assets.images.pestanddiseasesAsset.path;
      case 3: // Oil Palm Management
        return Assets.images.oilPlamAsset.path;
      case 4: // General
        return Assets.images.generalAsset.path;

      default:
        return Assets.images.progressComplete.path;
    }
  }

  Row learningRourcesSection(Size size) {
    final isTablet = size.width > 600;
    return Row(
      children: [
        customLayout(
          size: size,
          assetName: 'assets/pl.svg',
          title: 'Fertilizer',
          onTap: () {},
        ),
        SizedBox(width: isTablet ? 20 : 12),
        customLayout(
          size: size,
          assetName: 'assets/pl.svg',
          title: 'Harvesting',
          onTap: () {},
        ),
        SizedBox(width: isTablet ? 20 : 12),
        customLayout(
          size: size,
          assetName: 'assets/pl.svg',
          title: 'Pests',
          onTap: () {},
        ),
      ],
    );
  }

/*   Widget _buildUserProfile(String userName) {
    String initials = _getInitials(userName);

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: CommonStyles.themeTextColor, width: 2),
      ),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: CommonStyles.homeBgColor,
        child: Text(
          initials,
          style: CommonStyles.txStyF20CbFcF5.copyWith(
            fontWeight: FontWeight.bold,
            color: CommonStyles.themeTextColor,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    if (name.trim().isEmpty) return '';
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
  } */

  IconData getIconForTitle(String? title) {
    switch (title?.toLowerCase()) {
      case 'leads':
        return Icons.person_add_alt_1;
      case 'attendance':
        return Icons.calendar_today;
      case 'reports':
        return Icons.bar_chart;
      case 'settings':
        return Icons.settings;
      case 'logout':
        return Icons.logout;
      default:
        return Icons.help_outline;
    }
  }

  Widget customLayout({
    String? title,
    String? assetName,
    void Function()? onTap,
    required Size size,
    EdgeInsetsGeometry? padding,
  }) {
    final isTablet = size.width > 600;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
          // padding: padding ??
          //     EdgeInsets.symmetric(vertical: isTablet ? 20 : 16, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: CommonStyles.homeBorderColor),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(isTablet ? 18 : 14),
                decoration: const BoxDecoration(
                  color: CommonStyles.homeBgColor,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  assetName ?? '',
                  width: 25,
                  height: 25,
                  fit: BoxFit.contain,
                  color: CommonStyles.themeTextColor,
                ),

                /*  Icon(
                  getIconForTitle(title),
                  color: CommonStyles.themeTextColor,
                  size: isTablet ? 40 : 30,
                ), */
              ),
              const SizedBox(height: 5),
              Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: CommonStyles.txStyF14CbFF6.copyWith(
                  fontSize: isTablet ? 16 : 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToSelectedServiceScreen(int serviceTypeId) {
    switch (serviceTypeId) {
      case 12:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const GodownSelectionScreen(keyName: 'Fertilizer')),
        );
        break;
      case 10: // Pole Request
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const GodownSelectionScreen(keyName: 'Pole')),
        );
        break;
      case 107: // Bio Lab Request
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const GodownSelectionScreen(keyName: 'BioLab')),
        );
        break;
      case 116: // Edibleoils Request
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const GodownSelectionScreen(keyName: 'edibleoils')),
        );
        break;
      case 13: // Quick Pay Request
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QuickPayScreen()),
        );

      case 14: // Visit Request
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PlotSelectionScreen(
                    serviceTypeId: 14,
                  )),
        );
        break;
      case 28: // Loan Request
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoanRequestScreen(
                    clusterId: 28,
                  )),
        );
        break;
      case 11: // Labour Request
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PlotSelection()),
        );
        break;

      default:
        break;
    }
  }

  Widget banners(Size size) {
    return FutureBuilder(
      future: bannersAndMarqueeTextData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final banners = snapshot.data as List<BannerModel>;
          return bannerTemplate(size, banners);
        } else if (snapshot.hasError) {
          return const SizedBox();
        }
        return Skeletonizer(
          enabled: true,
          child: bannerTemplate(size, []),
        );
      },
    );
  }

  ClipRRect bannerTemplate(Size size, List<BannerModel> banners) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: FlutterCarousel(
        options: FlutterCarouselOptions(
          floatingIndicator: true,
          height: size.height * 0.18,
          viewportFraction: 1.0,
          enlargeCenterPage: true,
          autoPlay: banners.length > 1,
          enableInfiniteScroll: banners.length > 1,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          slideIndicator: CircularSlideIndicator(
            slideIndicatorOptions: const SlideIndicatorOptions(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
              itemSpacing: 12,
              indicatorRadius: 4,
            ),
          ),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
        items: banners.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  item.imageName!,
                  height: 200,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  },
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget learningGrid(List<String?> learnings, Size size) {
    return GridView.builder(
      itemCount: learnings.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return customLayout(
          size: size,
          title: learnings[index],
          assetName: getLearningsAssetImg(index),
          padding: EdgeInsets.zero,
          onTap: () =>
              navigateToSelectedLearningScreen(learnings[index], index),
        );
      },
    );
  }

  void navigateToSelectedLearningScreen(String? appBarTitle, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EncyclopediaActivity(
          appBarTitle: appBarTitle ?? '',
          index: (index + 1),
        ),
      ),
    );
  }

  Widget marqueeText() {
    return FutureBuilder(
      future: bannersAndMarqueeTextData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final marquee = snapshot.data as List<BannerModel>;
          return Marquee(
            text:
                "${marquee[0].description!}                                        ${marquee[0].description!}                                        ",
            style: CommonStyles.txStyF12CbFF6,
          );
        } else if (snapshot.hasError) {
          return const ShimmerWidn();
        }
        return const ShimmerWidn();
      },
    );
  }

  Future<void> _initializeGreetingWeather() async {
    await _determinePositionAndFetchWeather();
    _setGreetingMessage();
  }

  Future<void> _setGreetingMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? farmerName = prefs.getString(SharedPrefsKeys.farmerName);
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greeting = "Good Morning $farmerName!";
    } else if (hour < 17) {
      greeting = "Good Afternoon $farmerName!";
    } else {
      greeting = "Good Evening $farmerName!";
    }
    setState(() {});
  }

  Future<void> _determinePositionAndFetchWeather() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check location service
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      return;
    }

    // Get location
    final position = await Geolocator.getCurrentPosition();
    final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    final city = placemarks.first.locality ?? "your location";

    // Fetch weather
    const apiKey = "4755e93e3d4db57175e81d1e1d10d111"; // Replace with your OpenWeatherMap API key
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=$apiKey';
print('weather url===$url');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final temp = data['main']['temp'].toString();
      setState(() {
        location = city;
        temperature = "$temp°C";
      });
    }
  }
}
