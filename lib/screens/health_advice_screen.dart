import 'package:flutter/material.dart';

/// Health advice screen with health tips and self-management guidance
class HealthAdviceScreen extends StatelessWidget {
  const HealthAdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('健康建议'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Introduction Card
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
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
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.favorite,
                    size: 48,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '关注健康，理性对待',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '自慰是一种正常的生理行为，但适度很重要',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Health Tips Section
          _buildAdviceSection(
            context,
            '健康提示',
            Icons.health_and_safety,
            [
              '适度频率：医学专家建议，每周2-3次是比较健康的频率',
              '倾听身体：感到疲劳、不适或影响日常生活时，应适当减少频率',
              '心理健康：如果感到内疚或焦虑，可能需要调整心态或寻求专业帮助',
              '身体清洁：保持个人卫生，避免感染',
              '避免成瘾：如果发现难以控制，影响了工作、学习或社交，建议寻求帮助',
            ],
          ),

          const SizedBox(height: 16),

          // Benefits Section
          _buildAdviceSection(
            context,
            '适度益处',
            Icons.thumb_up,
            [
              '释放压力：帮助缓解日常压力和紧张情绪',
              '改善睡眠：有助于放松身心，改善睡眠质量',
              '了解自己：帮助了解自己的身体和性需求',
              '预防问题：适度的性活动有助于维持生殖系统健康',
            ],
          ),

          const SizedBox(height: 16),

          // Self-Management Section
          _buildAdviceSection(
            context,
            '自我管理',
            Icons.psychology,
            [
              '设定目标：为自己设定合理的频率目标，并使用此应用追踪',
              '培养兴趣：多参与其他活动，培养健康的兴趣爱好',
              '运动锻炼：定期运动能释放多巴胺，减少对其的依赖',
              '社交互动：多与朋友、家人交流，减少独处时间',
              '寻求支持：如果遇到困难，不要犹豫寻求专业心理咨询',
            ],
          ),

          const SizedBox(height: 16),

          // Warning Signs Section
          _buildAdviceSection(
            context,
            '警示信号',
            Icons.warning_amber,
            [
              '频率过高，影响日常生活和工作',
              '感到强烈的内疚、羞耻或焦虑',
              '无法控制冲动，即使想停止也做不到',
              '出现身体不适或疼痛',
              '影响人际关系或社交生活',
            ],
            isWarning: true,
          ),

          const SizedBox(height: 16),

          // Resources Section
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: colorScheme.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '寻求帮助',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '如果你感到困扰或需要支持，以下资源可能对你有帮助：',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  _buildResourceItem(
                    context,
                    '心理咨询热线',
                    '提供免费的心理健康咨询服务',
                    Icons.phone,
                  ),
                  _buildResourceItem(
                    context,
                    '专业心理医生',
                    '如需深入帮助，可预约心理医生',
                    Icons.medical_services,
                  ),
                  _buildResourceItem(
                    context,
                    '在线支持社区',
                    '与有相似经历的人交流（匿名）',
                    Icons.forum,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Disclaimer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '免责声明：本应用提供的信息仅供参考，不能替代专业医疗建议。如有健康问题，请咨询专业医疗人员。',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.outline,
                    fontStyle: FontStyle.italic,
                  ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAdviceSection(
    BuildContext context,
    String title,
    IconData icon,
    List<String> points, {
    bool isWarning = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final sectionColor = isWarning ? colorScheme.errorContainer : colorScheme.surfaceContainerHighest;
    final iconColor = isWarning ? colorScheme.error : colorScheme.primary;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: sectionColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...points.map((point) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: iconColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          point,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
