import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/common/greeting_header.dart';
import 'package:flutter_assessment_app/domain/repository/assessment_cardstofirestore.dart';
import 'package:flutter_assessment_app/presentation/screens/my_appointment.dart';
import 'package:flutter_assessment_app/presentation/screens/my_assessment.dart';
import 'package:flutter_assessment_app/provider/provider.dart';
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

  final double cardRadius = 12.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssessmentCardProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: const GreetingAppBar(name: 'Jane'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Container(
                height: 47,
                width: 338,
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f6),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor:
                        Colors.transparent, // 👈 This removes the line
                    indicatorWeight: 0,

                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffdadada),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    labelColor: const Color(0xff2a70f4),
                    unselectedLabelColor: const Color(0xffa8a8b3),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    tabs: const [
                      Tab(text: 'My Assessments'),
                      Tab(text: 'My Appointments'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
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
