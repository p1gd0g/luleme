import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../controllers/event_controller.dart';
import '../models/event_model.dart';

/// Statistics screen showing weekly, monthly, and total frequency charts
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EventController eventController = Get.find<EventController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('统计分析'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Cards
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      '本周',
                      eventController.weeklyCount.toString(),
                      Icons.calendar_view_week,
                      colorScheme.primaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      '本月',
                      eventController.monthlyCount.toString(),
                      Icons.calendar_month,
                      colorScheme.secondaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      '总计',
                      eventController.totalCount.toString(),
                      Icons.all_inclusive,
                      colorScheme.tertiaryContainer,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Weekly Chart
              _buildChartSection(
                context,
                '本周趋势',
                _buildWeeklyChart(context, eventController),
              ),

              const SizedBox(height: 24),

              // Monthly Chart
              _buildChartSection(
                context,
                '本月趋势',
                _buildMonthlyChart(context, eventController),
              ),

              const SizedBox(height: 24),

              // Feeling Distribution
              if (eventController.events.isNotEmpty)
                _buildChartSection(
                  context,
                  '感受分布',
                  _buildFeelingPieChart(context, eventController),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color backgroundColor,
  ) {
    return Card(
      elevation: 4,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection(BuildContext context, String title, Widget chart) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: chart,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyChart(BuildContext context, EventController controller) {
    final colorScheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    
    // Count events per day for the current week
    final Map<int, int> dailyCounts = {};
    for (int i = 0; i < 7; i++) {
      dailyCounts[i] = 0;
    }

    for (var event in controller.getWeeklyEvents()) {
      final dayIndex = event.timestamp.weekday - 1;
      dailyCounts[dayIndex] = (dailyCounts[dayIndex] ?? 0) + 1;
    }

    final List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < 7; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: dailyCounts[i]!.toDouble(),
              color: colorScheme.primary,
              width: 20,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            ),
          ],
        ),
      );
    }

    // Safely calculate max Y value
    final maxCount = dailyCounts.values.isEmpty 
        ? 0 
        : dailyCounts.values.reduce((a, b) => a > b ? a : b);
    final maxY = (maxCount + 2).toDouble();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barGroups: barGroups,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const days = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
                final index = value.toInt();
                // Bounds checking
                if (index < 0 || index >= days.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    days[index],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  Widget _buildMonthlyChart(BuildContext context, EventController controller) {
    final colorScheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    
    // Group events by day of month
    final Map<int, int> dailyCounts = {};
    for (var event in controller.getMonthlyEvents()) {
      final day = event.timestamp.day;
      dailyCounts[day] = (dailyCounts[day] ?? 0) + 1;
    }

    final List<FlSpot> spots = [];
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    
    for (int day = 1; day <= daysInMonth; day++) {
      spots.add(FlSpot(day.toDouble(), (dailyCounts[day] ?? 0).toDouble()));
    }

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: colorScheme.primary,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 3,
                  color: colorScheme.primary,
                  strokeWidth: 0,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: colorScheme.primary.withOpacity(0.2),
            ),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    value.toInt().toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
        ),
        borderData: FlBorderData(show: false),
        minY: 0,
      ),
    );
  }

  Widget _buildFeelingPieChart(BuildContext context, EventController controller) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Count feelings
    final Map<String, int> feelingCounts = {};
    for (var event in controller.events) {
      if (event.feeling != null && event.feeling!.isNotEmpty) {
        feelingCounts[event.feeling!] = (feelingCounts[event.feeling!] ?? 0) + 1;
      }
    }

    if (feelingCounts.isEmpty) {
      return Center(
        child: Text(
          '暂无感受数据',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.outline,
              ),
        ),
      );
    }

    final List<PieChartSectionData> sections = [];
    final colors = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.tertiary,
      Colors.orange,
      Colors.purple,
    ];

    int colorIndex = 0;
    feelingCounts.forEach((feeling, count) {
      sections.add(
        PieChartSectionData(
          value: count.toDouble(),
          title: feeling,
          color: colors[colorIndex % colors.length],
          radius: 80,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
      colorIndex++;
    });

    return PieChart(
      PieChartData(
        sections: sections,
        centerSpaceRadius: 40,
        sectionsSpace: 2,
      ),
    );
  }
}
