import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/apptext_styles.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';
import 'package:flutter_assessment_app/presentation/screens/appointment_calendar_screen.dart';
import 'package:flutter_assessment_app/presentation/screens/appointment_detail_screen.dart';
import 'package:flutter_assessment_app/provider/provider.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EnhancedAppointmentList extends StatefulWidget {
  const EnhancedAppointmentList({super.key});

  @override
  State<EnhancedAppointmentList> createState() => _EnhancedAppointmentListState();
}

class _EnhancedAppointmentListState extends State<EnhancedAppointmentList> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<String> _filterOptions = ['All', 'Available', 'Booked', 'Online', 'In-clinic'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AppointmentModel> _getFilteredAppointments(List<AppointmentModel> appointments) {
    List<AppointmentModel> filtered = appointments;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((appointment) {
        return appointment.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               appointment.doctorName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               appointment.doctorSpeciality.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Apply category filter
    switch (_selectedFilter) {
      case 'Available':
        filtered = filtered.where((appointment) => !appointment.isBooked).toList();
        break;
      case 'Booked':
        filtered = filtered.where((appointment) => appointment.isBooked).toList();
        break;
      case 'Online':
        filtered = filtered.where((appointment) => appointment.location.toLowerCase() == 'online').toList();
        break;
      case 'In-clinic':
        filtered = filtered.where((appointment) => appointment.location.toLowerCase() == 'in-clinic').toList();
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        title: const Text(
          'Appointments',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        elevation: ResponsiveSize.width(2),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const AppointmentCalendarScreen(),
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
            tooltip: 'Calendar View',
          ),
        ],
      ),
      body: Consumer<AssessmentCardProvider>(
        builder: (context, provider, child) {
          final filteredAppointments = _getFilteredAppointments(provider.appointmentCard);

          return Column(
            children: [
              // Search and Filter Section
              Container(
                padding: EdgeInsets.all(ResponsiveSize.width(16)),
                color: Colors.white,
                child: Column(
                  children: [
                    // Search Bar
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search appointments, doctors...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(ResponsiveSize.width(12)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ResponsiveSize.width(16),
                          vertical: ResponsiveSize.height(12),
                        ),
                      ),
                    ),
                    SizedBox(height: ResponsiveSize.height(12)),
                    
                    // Filter Chips
                    SizedBox(
                      height: ResponsiveSize.height(40),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _filterOptions.length,
                        itemBuilder: (context, index) {
                          final option = _filterOptions[index];
                          final isSelected = _selectedFilter == option;
                          
                          return Container(
                            margin: EdgeInsets.only(right: ResponsiveSize.width(8)),
                            child: FilterChip(
                              label: Text(option),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedFilter = option;
                                });
                              },
                              backgroundColor: Colors.grey[200],
                              selectedColor: AppColors.primaryBlue.withOpacity(0.2),
                              checkmarkColor: AppColors.primaryBlue,
                              labelStyle: TextStyle(
                                color: isSelected ? AppColors.primaryBlue : Colors.grey[700],
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Results Count
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSize.width(16),
                  vertical: ResponsiveSize.height(8),
                ),
                color: Colors.grey[100],
                child: Text(
                  '${filteredAppointments.length} appointment${filteredAppointments.length != 1 ? 's' : ''} found',
                  style: TextStyle(
                    fontSize: ResponsiveSize.width(14),
                    color: Colors.grey[600],
                  ),
                ),
              ),

              // Appointments List
              Expanded(
                child: filteredAppointments.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: EdgeInsets.all(ResponsiveSize.width(16)),
                        itemCount: filteredAppointments.length,
                        itemBuilder: (context, index) {
                          final appointment = filteredAppointments[index];
                          return _buildAppointmentCard(appointment, provider);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: ResponsiveSize.width(64),
            color: Colors.grey,
          ),
          SizedBox(height: ResponsiveSize.height(16)),
          Text(
            'No appointments found',
            style: TextStyle(
              fontSize: ResponsiveSize.width(18),
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: ResponsiveSize.height(8)),
          Text(
            'Try adjusting your search or filter criteria',
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

  Widget _buildAppointmentCard(AppointmentModel appointment, AssessmentCardProvider provider) {
    final isBooked = appointment.isBooked;
    final isBooking = provider.isBookingAppointment(appointment.id);

    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveSize.height(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: ResponsiveSize.width(8),
            offset: Offset(0, ResponsiveSize.height(4)),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              child: AppointmentDetailScreen(appointment: appointment),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 300),
            ),
          );
        },
        borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
        child: Padding(
          padding: EdgeInsets.all(ResponsiveSize.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  // Service Icon
                  Container(
                    width: ResponsiveSize.width(50),
                    height: ResponsiveSize.width(50),
                    decoration: BoxDecoration(
                      color: isBooked ? Colors.grey : AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(ResponsiveSize.width(12)),
                    ),
                    child: Icon(
                      Icons.medical_services,
                      color: Colors.white,
                      size: ResponsiveSize.width(24),
                    ),
                  ),
                  SizedBox(width: ResponsiveSize.width(12)),
                  
                  // Service Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.name,
                          style: AppTextStyles.size14w500Blue.copyWith(
                            fontSize: ResponsiveSize.width(16),
                            color: isBooked ? Colors.grey : Colors.black87,
                          ),
                        ),
                        SizedBox(height: ResponsiveSize.height(2)),
                        Text(
                          'Dr. ${appointment.doctorName}',
                          style: TextStyle(
                            fontSize: ResponsiveSize.width(14),
                            color: isBooked ? Colors.grey : AppColors.primaryBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Price
                  Text(
                    '₹${appointment.price}',
                    style: TextStyle(
                      fontSize: ResponsiveSize.width(16),
                      fontWeight: FontWeight.bold,
                      color: isBooked ? Colors.grey : AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: ResponsiveSize.height(12)),
              
              // Details Row
              Row(
                children: [
                  _buildDetailChip(Icons.calendar_today, _formatDate(appointment.date)),
                  SizedBox(width: ResponsiveSize.width(8)),
                  _buildDetailChip(Icons.access_time, appointment.time),
                  SizedBox(width: ResponsiveSize.width(8)),
                  _buildDetailChip(Icons.location_on, appointment.location),
                ],
              ),
              
              if (isBooked) ...[
                SizedBox(height: ResponsiveSize.height(12)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveSize.width(12),
                    vertical: ResponsiveSize.height(6),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(ResponsiveSize.width(8)),
                  ),
                  child: Text(
                    'BOOKED',
                    style: TextStyle(
                      fontSize: ResponsiveSize.width(12),
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(8),
        vertical: ResponsiveSize.height(4),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(ResponsiveSize.width(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: ResponsiveSize.width(12),
            color: Colors.grey[600],
          ),
          SizedBox(width: ResponsiveSize.width(4)),
          Text(
            text,
            style: TextStyle(
              fontSize: ResponsiveSize.width(12),
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}';
    } catch (e) {
      return dateString;
    }
  }
}
