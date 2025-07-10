import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/common/greeting_header.dart';
import 'package:flutter_assessment_app/domain/repository/assessment_cardstofirestore.dart';
import 'package:flutter_assessment_app/presentation/screens/my_appointment.dart';
import 'package:flutter_assessment_app/presentation/screens/my_assessment.dart';
import 'package:flutter_assessment_app/provider/provider.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';
import 'package:provider/provider.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyAssessmentsState();
}

class _MyAssessmentsState extends State<MyDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  AddAssessmentCardstofirestore addAssessmentCardstofirestore =
      AddAssessmentCardstofirestore();

  final double cardRadius = ResponsiveSize.width(12);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Initialize provider with favorites
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<AssessmentCardProvider>(context, listen: false);
      provider.initializeProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssessmentCardProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: const GreetingAppBar(name: 'Jane'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.width(18)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveSize.height(12)),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f6),
                  borderRadius: BorderRadius.circular(ResponsiveSize.width(40)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(ResponsiveSize.width(4)),
                  child: TabBar(
                    dividerColor: Colors.transparent,

                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor:
                        Colors.transparent, // 👈 This removes the line
                    indicatorWeight: 0,

                    indicator: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ResponsiveSize.width(40)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xffdadada),
                          blurRadius: ResponsiveSize.width(8),
                          offset: Offset(0, ResponsiveSize.height(3)),
                        )
                      ],
                    ),
                    labelColor: const Color(0xff2a70f4),
                    unselectedLabelColor: const Color(0xffa8a8b3),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: ResponsiveSize.width(14),
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ResponsiveSize.width(14),
                    ),
                    tabs: const [
                      Tab(text: 'My Assessments'),
                      Tab(text: 'My Appointments'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ResponsiveSize.height(12)),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [const MyAssessment(), MyAppointment()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
