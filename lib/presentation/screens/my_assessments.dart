import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/presentation/screens/my_appointment.dart';

class MyAssessments extends StatefulWidget {
  const MyAssessments({super.key});

  @override
  State<MyAssessments> createState() => _MyAssessmentsState();
}

class _MyAssessmentsState extends State<MyAssessments>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final double cardRadius = 12.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // Custom blue play icon circle widget
  Widget bluePlayIcon() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff2a70f4),
        shape: BoxShape.circle,
      ),
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Icon(
          Icons.play_arrow_rounded,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  // Assessment card widget
  Widget assessmentCard({
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffeeeeee),
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Image with rounded left corners
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(cardRadius),
              bottomLeft: Radius.circular(cardRadius),
            ),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 116,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 116,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image,
                    color: Colors.grey, size: 40),
              ),
            ),
          ),
          // Text content and start play icon
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xff505050),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      bluePlayIcon(),
                      const SizedBox(width: 8),
                      const Text(
                        'Start',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xff2a70f4),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Challenge card widget
  Widget challengeCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffdff6e7),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Left text column
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Challenge!",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xff23742d),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff23742d).withOpacity(0.15),
                  ),
                  child: const Text(
                    'Push Up 20x',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff23742d),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Progress bar with text below
                Stack(
                  children: [
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x44707070),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      // 50% progress - 10/20 complete
                      final width = constraints.maxWidth * 0.5;
                      return Container(
                        height: 8,
                        width: width,
                        decoration: BoxDecoration(
                          color: const Color(0xff23742d),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  '10/20 Complete',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Color(0xff23742d),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff23742d),
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Continue',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xff23742d),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          // Right image of person doing push-ups
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/8225cc0d-c2ee-4b28-a7e2-7690e775afb3.png',
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image,
                      color: Colors.grey, size: 40),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Workout routine card widget
  Widget workoutCard({
    required String imageUrl,
    required String title,
    required String subtitle,
    required String tagText,
    required Color tagColor,
    required String difficulty,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffeeeeee),
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
            child: Image.network(
              imageUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 90,
                height: 90,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image,
                    color: Colors.grey, size: 40),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff505050),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        decoration: BoxDecoration(
                          color: tagColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tagText,
                          style: TextStyle(
                            fontSize: 12,
                            color: tagColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        'Difficulty : $difficulty',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: difficulty.toLowerCase() == 'medium'
                              ? Colors.orange
                              : Colors.grey[700],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Section header with title and "View All" on right
  Widget sectionHeader(
      {required String title, required VoidCallback onViewAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          GestureDetector(
            onTap: onViewAll,
            child: Row(
              children: const [
                Text(
                  'View All',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xff2a70f4),
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Color(0xff2a70f4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting top row with hello and icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Hello ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text: 'Jane',
                          style: TextStyle(
                            color: Color(0xff2a70f4),
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xfff1f1f6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_circle_rounded,
                      color: Color(0xffb2b2b5),
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Tab bar for "My Assessments" and "My Appointments"
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f6),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TabBar(
                  controller: _tabController,
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
              const SizedBox(height: 12),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // My Assessments tab content
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Assessment cards
                          assessmentCard(
                            imageUrl:
                                'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/0e3c8f2d-f25e-4e50-8662-cd7043a531c2.png',
                            title: 'Fitness Assessment',
                            description:
                                'Get Started On Your Fitness Goals With Our Physical Assessment And Vital Scan',
                          ),
                          assessmentCard(
                            imageUrl:
                                'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png',
                            title: 'Health Risk Assessment',
                            description:
                                'Identify And Mitigate Health Risks With Precise, Proactive Assessments',
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                              onPressed: () {
                                // Implement View all functionality
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff2a70f4),
                                minimumSize: const Size(90, 28),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'View all',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Challenges Section header
                          sectionHeader(
                            title: 'Challenges',
                            onViewAll: () {
                              // Implement Challenges View All
                            },
                          ),
                          challengeCard(),
                          const SizedBox(height: 24),
                          // Workout Routines Section header
                          sectionHeader(
                            title: 'Workout Routines',
                            onViewAll: () {
                              // Implement Workout Routines View All
                            },
                          ),
                          workoutCard(
                            imageUrl:
                                'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/ac2a53ba-d701-48af-a851-3d6e37454e46.png',
                            title: 'Sweat Starter',
                            subtitle: 'Full Body',
                            tagText: 'Lose Weight',
                            tagColor: const Color(0xff71aadf),
                            difficulty: 'Medium',
                          ),
                          workoutCard(
                            imageUrl:
                                'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/91e988bf-1140-4937-bf4e-620ca60992d6.png',
                            title: 'Strength Builder',
                            subtitle: 'Upper Body',
                            tagText: 'Build Muscle',
                            tagColor: const Color(0xff70c19e),
                            difficulty: 'Hard',
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    // My Appointments tab content (empty placeholder)
                    MyAppointment()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
