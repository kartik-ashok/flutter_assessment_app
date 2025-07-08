import 'package:flutter/material.dart';

class HealthRiskAssessment extends StatelessWidget {
  const HealthRiskAssessment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const topHeight = 320.0;

    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Container(
              height: topHeight,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.green, // Changed to white
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color:
                              Colors.black), // Changed to black for visibility
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Health Risk\nAssessment',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Changed to black for visibility
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 16,
                          color: Colors
                              .black54), // Changed to black for visibility
                      const SizedBox(width: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent, // Changed to red
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: const Text(
                          '4 min',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                Colors.white, // Changed to white for visibility
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 100,
                      child: Image.network(
                        'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/ec5ccba5-39f7-4515-ba20-9d441bf1504b.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Text('Image\nUnavailable',
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Scrollable Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white, // Changed to red
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24)), // Curved border
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What do you get ?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF242C54),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 110,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            IconLabelCard(
                              iconUrl:
                                  'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/f41986bb-8918-44bb-86dc-9de3c4f80db9.png',
                              label: 'Key Body Vitals',
                            ),
                            SizedBox(width: 12),
                            IconLabelCard(
                              iconUrl:
                                  'https://placehold.co/64x64/png?text=Posture',
                              label: 'Posture Analysis',
                            ),
                            SizedBox(width: 12),
                            IconLabelCard(
                              iconUrl:
                                  'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/b6ec404f-5b22-43f4-8a3a-1103c06012c6.png',
                              label: 'Body Composition',
                            ),
                            SizedBox(width: 12),
                            IconLabelCard(
                              iconUrl:
                                  'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/9b67ca32-754b-4f9a-960d-33b6141b9e22.png',
                              label: 'Instant Reports',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'How we do it?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF242C54),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/13547c17-20e2-438d-8e9e-5ac761071078.png',
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: double.infinity,
                                  height: 180,
                                  color: Colors.grey.shade300,
                                  child: const Center(
                                    child: Text('Image\nUnavailable',
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9F0E7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.shield_outlined,
                                color: Color(0xFF27AE60)),
                            SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                'We do not store or share your personal data',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF27AE60),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const InstructionList(
                        instructions: [
                          "Ensure that you are in a well-lit space",
                          "Allow camera access and place your device against a stable object or wall",
                          "Avoid wearing baggy clothes",
                          "Make sure you exercise as per the instruction provided by the trainer",
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Icon Card Widget
class IconLabelCard extends StatelessWidget {
  final String iconUrl;
  final String label;

  const IconLabelCard({Key? key, required this.iconUrl, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF647DEE), Color(0xFF4E54C8)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade200.withOpacity(0.5),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                iconUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error_outline, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF242C54),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Instruction List
class InstructionList extends StatelessWidget {
  final List<String> instructions;

  const InstructionList({Key? key, required this.instructions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        instructions.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            '${index + 1}. ${instructions[index]}',
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF444444),
            ),
          ),
        ),
      ),
    );
  }
}
