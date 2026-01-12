import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/event_controller.dart';
import '../models/event_model.dart';

/// Home screen with quick record button and recent events
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EventController eventController = Get.find<EventController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('撸了么'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (eventController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // Statistics Summary Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primaryContainer,
                    colorScheme.secondaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '统计概览',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        context,
                        '本周',
                        eventController.weeklyCount.toString(),
                        Icons.calendar_view_week,
                      ),
                      _buildStatItem(
                        context,
                        '本月',
                        eventController.monthlyCount.toString(),
                        Icons.calendar_month,
                      ),
                      _buildStatItem(
                        context,
                        '总计',
                        eventController.totalCount.toString(),
                        Icons.all_inclusive,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Record Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () => _showRecordDialog(context, eventController),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 8,
                  shadowColor: colorScheme.primary.withOpacity(0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, size: 28),
                    const SizedBox(width: 12),
                    Text(
                      '快速记录',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Recent Events List
            Expanded(
              child: eventController.events.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 80,
                            color: colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '暂无记录',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: colorScheme.outline,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '点击上方按钮开始记录',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.outline,
                                ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: eventController.events.length,
                      itemBuilder: (context, index) {
                        final event = eventController.events[index];
                        return _buildEventCard(context, event, eventController);
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        Icon(icon, size: 32, color: colorScheme.onPrimaryContainer),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimaryContainer.withOpacity(0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context, EventModel event, EventController controller) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(
            Icons.check_circle_outline,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          dateFormat.format(event.timestamp),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (event.durationMinutes != null)
              Text('时长: ${event.durationMinutes} 分钟'),
            if (event.feeling != null) Text('感受: ${event.feeling}'),
            if (event.notes != null && event.notes!.isNotEmpty)
              Text('备注: ${event.notes}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: colorScheme.error),
          onPressed: () => _confirmDelete(context, event.id, controller),
        ),
      ),
    );
  }

  void _showRecordDialog(BuildContext context, EventController controller) {
    final TextEditingController durationController = TextEditingController();
    final TextEditingController notesController = TextEditingController();
    String? selectedFeeling;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加记录'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: durationController,
                decoration: const InputDecoration(
                  labelText: '时长 (分钟，可选)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: '感受 (可选)',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: '放松', child: Text('放松')),
                  DropdownMenuItem(value: '愉悦', child: Text('愉悦')),
                  DropdownMenuItem(value: '正常', child: Text('正常')),
                  DropdownMenuItem(value: '压力', child: Text('压力')),
                  DropdownMenuItem(value: '内疚', child: Text('内疚')),
                ],
                onChanged: (value) => selectedFeeling = value,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(
                  labelText: '备注 (可选)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              final duration = durationController.text.isEmpty
                  ? null
                  : int.tryParse(durationController.text);

              controller.addEvent(
                durationMinutes: duration,
                feeling: selectedFeeling,
                notes: notesController.text.isEmpty ? null : notesController.text,
              );

              Navigator.of(context).pop();
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id, EventController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这条记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteEvent(id);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}
