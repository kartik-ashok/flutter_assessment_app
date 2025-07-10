import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/apptext_styles.dart';
import 'package:flutter_assessment_app/domain/repository/appointment_service.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';
import 'package:flutter_assessment_app/provider/provider.dart';
import 'package:provider/provider.dart';

class ListOfAppointments extends StatefulWidget {
  final List<AppointmentModel> appointments;

  const ListOfAppointments({super.key, required this.appointments});

  @override
  State<ListOfAppointments> createState() => _ListOfAppointmentsState();
}

class _ListOfAppointmentsState extends State<ListOfAppointments> {
  final AppointmentService appointmentService = AppointmentService();

  @override
  Widget build(BuildContext context) {
    return Consumer<AssessmentCardProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: AppColors.primaryBlue,
              title: Text(
                "Appointments",
                style: AppTextStyles.size24w400Grey
                    .copyWith(color: AppColors.white),
              )),
          body: Column(
            children: [
              // Show booking message if available
              if (provider.bookingMessage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: provider.bookingMessage!.contains('successfully')
                        ? Colors.green[100]
                        : Colors.red[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: provider.bookingMessage!.contains('successfully')
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        provider.bookingMessage!.contains('successfully')
                            ? Icons.check_circle
                            : Icons.error,
                        color: provider.bookingMessage!.contains('successfully')
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          provider.bookingMessage!,
                          style: TextStyle(
                            color: provider.bookingMessage!
                                    .contains('successfully')
                                ? Colors.green[800]
                                : Colors.red[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => provider.clearBookingMessage(),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),

              // Appointments list
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: provider.appointmentCard.length,
                    itemBuilder: (context, index) {
                      final appointment = provider.appointmentCard[index];
                      final isBooked = appointment.isBooked;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isBooked ? Colors.grey[200] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16),
                                const SizedBox(width: 6),
                                Text(appointment.date),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 16),
                                const SizedBox(width: 6),
                                Text(appointment.time),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.person, size: 16),
                                const SizedBox(width: 6),
                                Text(appointment.doctorName),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16),
                                const SizedBox(width: 6),
                                Text(appointment.location),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.monetization_on, size: 16),
                                const SizedBox(width: 6),
                                Text('₹${appointment.price}'),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.info_outline, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  isBooked ? 'Booked' : 'Available',
                                  style: TextStyle(
                                    color: isBooked ? Colors.red : Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isBooked
                                    ? null
                                    : provider.isBookingAppointment(
                                            appointment.id)
                                        ? null
                                        : () async {
                                            // Book appointment using provider
                                            await provider.bookAppointment(
                                                appointment.id);
                                          },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isBooked
                                      ? Colors.grey[400]
                                      : provider.isBookingAppointment(
                                              appointment.id)
                                          ? Colors.grey[400]
                                          : Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                ),
                                child: provider
                                        .isBookingAppointment(appointment.id)
                                    ? const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text('Booking...'),
                                        ],
                                      )
                                    : Text(isBooked
                                        ? 'Already Booked'
                                        : 'Book Now'),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
