import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/apptext_styles.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';
import 'package:flutter_assessment_app/presentation/screens/booking_confirmation_screen.dart';
import 'package:flutter_assessment_app/provider/provider.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentDetailScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        title: const Text(
          'Appointment Details',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        elevation: ResponsiveSize.width(2),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<AssessmentCardProvider>(
        builder: (context, provider, child) {
          final isBooked = appointment.isBooked;
          final isBooking = provider.isBookingAppointment(appointment.id);

          return SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveSize.width(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Info Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(ResponsiveSize.width(20)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ResponsiveSize.width(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: ResponsiveSize.width(10),
                        offset: Offset(0, ResponsiveSize.height(4)),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Doctor Avatar
                      Container(
                        width: ResponsiveSize.width(80),
                        height: ResponsiveSize.width(80),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          size: ResponsiveSize.width(40),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: ResponsiveSize.height(16)),

                      // Doctor Name
                      Text(
                        'Dr. ${appointment.doctorName}',
                        style: AppTextStyles.size24w600Blue.copyWith(
                          fontSize: ResponsiveSize.width(20),
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: ResponsiveSize.height(4)),

                      // Speciality
                      Text(
                        appointment.doctorSpeciality,
                        style: TextStyle(
                          fontSize: ResponsiveSize.width(16),
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: ResponsiveSize.height(8)),

                      // Rating (placeholder)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    size: ResponsiveSize.width(16),
                                    color: Colors.amber,
                                  )),
                          SizedBox(width: ResponsiveSize.width(8)),
                          Text(
                            '4.8 (120 reviews)',
                            style: TextStyle(
                              fontSize: ResponsiveSize.width(14),
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ResponsiveSize.height(20)),

                // Appointment Details Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(ResponsiveSize.width(20)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ResponsiveSize.width(16)),
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
                          fontSize: ResponsiveSize.width(18),
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: ResponsiveSize.height(16)),

                      // Service Name
                      _buildDetailRow(
                        icon: Icons.medical_services,
                        label: 'Service',
                        value: appointment.name,
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

                      // Type
                      _buildDetailRow(
                        icon: Icons.category,
                        label: 'Type',
                        value: appointment.type,
                      ),

                      // Price
                      _buildDetailRow(
                        icon: Icons.currency_rupee,
                        label: 'Price',
                        value: '₹${appointment.price}',
                        valueColor: AppColors.primaryBlue,
                        valueWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ResponsiveSize.height(20)),

                // Description Card
                if (appointment.description.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(ResponsiveSize.width(20)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(ResponsiveSize.width(16)),
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
                          'Description',
                          style: AppTextStyles.size24w600Blue.copyWith(
                            fontSize: ResponsiveSize.width(18),
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: ResponsiveSize.height(12)),
                        Text(
                          appointment.description,
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

                // Book Appointment Button
                SizedBox(
                  width: double.infinity,
                  height: ResponsiveSize.height(56),
                  child: ElevatedButton(
                    onPressed: isBooked || isBooking
                        ? null
                        : () async {
                            final success =
                                await provider.bookAppointment(appointment.id);
                            if (success && context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  child: BookingConfirmationScreen(
                                      appointment: appointment),
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 300),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isBooked
                          ? Colors.grey[400]
                          : isBooking
                              ? Colors.grey[400]
                              : AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ResponsiveSize.width(16)),
                      ),
                      elevation: isBooked || isBooking ? 0 : 4,
                    ),
                    child: isBooking
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: ResponsiveSize.width(20),
                                height: ResponsiveSize.width(20),
                                child: CircularProgressIndicator(
                                  strokeWidth: ResponsiveSize.width(2),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                ),
                              ),
                              SizedBox(width: ResponsiveSize.width(12)),
                              Text(
                                'Booking...',
                                style: TextStyle(
                                  fontSize: ResponsiveSize.width(16),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            isBooked ? 'Already Booked' : 'Book Appointment',
                            style: TextStyle(
                              fontSize: ResponsiveSize.width(16),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: ResponsiveSize.height(20)),
              ],
            ),
          );
        },
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
      padding: EdgeInsets.only(bottom: ResponsiveSize.height(12)),
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
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${date.day} ${months[date.month - 1]}, ${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
