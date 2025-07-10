import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/apptext_styles.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final AppointmentModel appointment;

  const BookingConfirmationScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        title: const Text(
          'Booking Confirmed',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        elevation: ResponsiveSize.width(2),
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ResponsiveSize.width(20)),
        child: Column(
          children: [
            SizedBox(height: ResponsiveSize.height(20)),

            // Success Animation
            Container(
              width: ResponsiveSize.width(200),
              height: ResponsiveSize.width(200),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: ResponsiveSize.width(20),
                    offset: Offset(0, ResponsiveSize.height(10)),
                  ),
                ],
              ),
              child: Icon(
                Icons.check_circle,
                size: ResponsiveSize.width(120),
                color: Colors.green,
              ),
            ),

            SizedBox(height: ResponsiveSize.height(30)),

            // Success Message
            Text(
              'Booking Confirmed!',
              style: AppTextStyles.size24w600Blue.copyWith(
                fontSize: ResponsiveSize.width(28),
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: ResponsiveSize.height(12)),

            Text(
              'Your appointment has been successfully booked.',
              style: TextStyle(
                fontSize: ResponsiveSize.width(16),
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: ResponsiveSize.height(30)),

            // Appointment Details Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ResponsiveSize.width(20)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: ResponsiveSize.width(10),
                    offset: Offset(0, ResponsiveSize.height(4)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appointment Details',
                    style: AppTextStyles.size24w600Blue.copyWith(
                      fontSize: ResponsiveSize.width(20),
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveSize.height(20)),

                  // Service
                  _buildDetailRow(
                    icon: Icons.medical_services,
                    label: 'Service',
                    value: appointment.name,
                  ),

                  // Doctor
                  _buildDetailRow(
                    icon: Icons.person,
                    label: 'Doctor',
                    value: 'Dr. ${appointment.doctorName}',
                  ),

                  // Speciality
                  _buildDetailRow(
                    icon: Icons.local_hospital,
                    label: 'Speciality',
                    value: appointment.doctorSpeciality,
                  ),

                  // Date
                  _buildDetailRow(
                    icon: Icons.calendar_today,
                    label: 'Date',
                    value: _formatDate(appointment.date),
                  ),

                  // Time
                  _buildDetailRow(
                    icon: Icons.access_time,
                    label: 'Time',
                    value: appointment.time,
                  ),

                  // Duration
                  _buildDetailRow(
                    icon: Icons.timer,
                    label: 'Duration',
                    value: appointment.duration,
                  ),

                  // Location
                  _buildDetailRow(
                    icon: Icons.location_on,
                    label: 'Location',
                    value: appointment.location,
                  ),

                  // Price
                  _buildDetailRow(
                    icon: Icons.currency_rupee,
                    label: 'Total Amount',
                    value: '₹${appointment.price}',
                    valueColor: AppColors.primaryBlue,
                    valueWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveSize.height(30)),

            // Important Notes Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ResponsiveSize.width(16)),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(ResponsiveSize.width(12)),
                border:
                    Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.primaryBlue,
                        size: ResponsiveSize.width(20),
                      ),
                      SizedBox(width: ResponsiveSize.width(8)),
                      Text(
                        'Important Notes',
                        style: TextStyle(
                          fontSize: ResponsiveSize.width(16),
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveSize.height(12)),
                  Text(
                    '• Please arrive 15 minutes before your appointment time\n'
                    '• Bring a valid ID and any relevant medical documents\n'
                    '• For online consultations, ensure stable internet connection\n'
                    '• You can reschedule up to 24 hours before the appointment',
                    style: TextStyle(
                      fontSize: ResponsiveSize.width(14),
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveSize.height(30)),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ResponsiveSize.width(12)),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: ResponsiveSize.height(16)),
                    ),
                    child: Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: ResponsiveSize.width(16),
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ResponsiveSize.width(16)),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement add to calendar functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Add to calendar feature coming soon!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ResponsiveSize.width(12)),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: ResponsiveSize.height(16)),
                    ),
                    child: Text(
                      'Add to Calendar',
                      style: TextStyle(
                        fontSize: ResponsiveSize.width(16),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: ResponsiveSize.height(20)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    FontWeight? valueWeight,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveSize.height(16)),
      child: Row(
        children: [
          Icon(
            icon,
            size: ResponsiveSize.width(20),
            color: AppColors.primaryBlue,
          ),
          SizedBox(width: ResponsiveSize.width(12)),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: ResponsiveSize.width(14),
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: ResponsiveSize.width(14),
                color: valueColor ?? Colors.black87,
                fontWeight: valueWeight ?? FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      final weekdays = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
      return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
