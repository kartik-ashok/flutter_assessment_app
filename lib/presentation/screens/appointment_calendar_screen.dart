import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/apptext_styles.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';
import 'package:flutter_assessment_app/presentation/screens/appointment_detail_screen.dart';
import 'package:flutter_assessment_app/provider/provider.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentCalendarScreen extends StatefulWidget {
  const AppointmentCalendarScreen({super.key});

  @override
  State<AppointmentCalendarScreen> createState() =>
      _AppointmentCalendarScreenState();
}

class _AppointmentCalendarScreenState extends State<AppointmentCalendarScreen> {
  late final ValueNotifier<List<AppointmentModel>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<AppointmentModel> _getEventsForDay(DateTime day) {
    final provider =
        Provider.of<AssessmentCardProvider>(context, listen: false);
    return provider.appointmentCard.where((appointment) {
      try {
        final appointmentDate = DateTime.parse(appointment.date);
        return isSameDay(appointmentDate, day);
      } catch (e) {
        return false;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        title: const Text(
          'Appointment Calendar',
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
          return Column(
            children: [
              // Calendar Widget
              Container(
                margin: EdgeInsets.all(ResponsiveSize.width(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ResponsiveSize.width(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: ResponsiveSize.width(10),
                      offset: Offset(0, ResponsiveSize.height(4)),
                    ),
                  ],
                ),
                child: TableCalendar<AppointmentModel>(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    weekendTextStyle: TextStyle(
                      color: Colors.red,
                      fontSize: ResponsiveSize.width(14),
                    ),
                    holidayTextStyle: TextStyle(
                      color: Colors.red,
                      fontSize: ResponsiveSize.width(14),
                    ),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 3,
                    markerSize: ResponsiveSize.width(6),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                    titleCentered: true,
                    formatButtonShowsNext: false,
                    formatButtonDecoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius:
                          BorderRadius.circular(ResponsiveSize.width(12)),
                    ),
                    formatButtonTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: ResponsiveSize.width(18),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      _selectedEvents.value = _getEventsForDay(selectedDay);
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),

              // Selected Day Appointments
              Expanded(
                child: ValueListenableBuilder<List<AppointmentModel>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    if (value.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: ResponsiveSize.width(64),
                              color: Colors.grey,
                            ),
                            SizedBox(height: ResponsiveSize.height(16)),
                            Text(
                              'No appointments for this day',
                              style: TextStyle(
                                fontSize: ResponsiveSize.width(16),
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: ResponsiveSize.height(8)),
                            Text(
                              'Select another date to view appointments',
                              style: TextStyle(
                                fontSize: ResponsiveSize.width(14),
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(ResponsiveSize.width(16)),
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        final appointment = value[index];
                        final isBooked = appointment.isBooked;

                        return Container(
                          margin: EdgeInsets.only(
                              bottom: ResponsiveSize.height(12)),
                          decoration: BoxDecoration(
                            color: isBooked ? Colors.grey[200] : Colors.white,
                            borderRadius:
                                BorderRadius.circular(ResponsiveSize.width(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: ResponsiveSize.width(5),
                                offset: Offset(0, ResponsiveSize.height(4)),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.all(ResponsiveSize.width(16)),
                            leading: Container(
                              width: ResponsiveSize.width(50),
                              height: ResponsiveSize.width(50),
                              decoration: BoxDecoration(
                                color: isBooked
                                    ? Colors.grey
                                    : AppColors.primaryBlue,
                                borderRadius: BorderRadius.circular(
                                    ResponsiveSize.width(8)),
                              ),
                              child: Icon(
                                Icons.medical_services,
                                color: Colors.white,
                                size: ResponsiveSize.width(24),
                              ),
                            ),
                            title: Text(
                              appointment.name,
                              style: AppTextStyles.size14w500Blue.copyWith(
                                fontSize: ResponsiveSize.width(16),
                                color: isBooked ? Colors.grey : Colors.black87,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: ResponsiveSize.height(4)),
                                Text(
                                  'Dr. ${appointment.doctorName}',
                                  style: TextStyle(
                                    fontSize: ResponsiveSize.width(14),
                                    color:
                                        isBooked ? Colors.grey : Colors.black54,
                                  ),
                                ),
                                Text(
                                  '${appointment.time} • ${appointment.duration}',
                                  style: TextStyle(
                                    fontSize: ResponsiveSize.width(12),
                                    color:
                                        isBooked ? Colors.grey : Colors.black45,
                                  ),
                                ),
                                if (isBooked)
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ResponsiveSize.height(4)),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveSize.width(8),
                                      vertical: ResponsiveSize.height(2),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(
                                          ResponsiveSize.width(4)),
                                    ),
                                    child: Text(
                                      'BOOKED',
                                      style: TextStyle(
                                        fontSize: ResponsiveSize.width(10),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            trailing: Text(
                              '₹${appointment.price}',
                              style: TextStyle(
                                fontSize: ResponsiveSize.width(16),
                                fontWeight: FontWeight.bold,
                                color: isBooked
                                    ? Colors.grey
                                    : AppColors.primaryBlue,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: AppointmentDetailScreen(
                                      appointment: appointment),
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 300),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
