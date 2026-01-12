import 'package:flutter/material.dart';

class AdviceScreen extends StatelessWidget {
  const AdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('健康建议'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildHeaderSection(context),
          const SizedBox(height: 24),
          _buildAdviceCard(
            context,
            '保持适度',
            '适度的频率对身心健康有益，但过度则可能带来负面影响。建议每周控制在2-3次为宜。',
            Icons.balance,
            Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildAdviceCard(
            context,
            '规律作息',
            '保持良好的作息习惯，充足的睡眠有助于身体恢复和激素平衡。避免熬夜和过度劳累。',
            Icons.bedtime,
            Colors.purple,
          ),
          const SizedBox(height: 16),
          _buildAdviceCard(
            context,
            '健康饮食',
            '均衡饮食，多摄入富含锌、维生素E的食物，如坚果、海鲜、蔬菜等，有助于维持生殖系统健康。',
            Icons.restaurant,
            Colors.green,
          ),
          const SizedBox(height: 16),
          _buildAdviceCard(
            context,
            '适度运动',
            '规律的运动可以提升身体素质，增强体力和精力。建议每周进行3-4次有氧运动。',
            Icons.fitness_center,
            Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildAdviceCard(
            context,
            '心理健康',
            '保持积极乐观的心态，如有焦虑、内疚等负面情绪，可以尝试冥想、运动或寻求专业帮助。',
            Icons.psychology,
            Colors.pink,
          ),
          const SizedBox(height: 16),
          _buildAdviceCard(
            context,
            '私密保护',
            '注意个人卫生，使用安全私密的环境。本应用所有数据仅存储在您的设备上，完全保护隐私。',
            Icons.lock,
            Colors.teal,
          ),
          const SizedBox(height: 24),
          _buildWarningSection(context),
          const SizedBox(height: 24),
          _buildResourcesSection(context),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            Icons.health_and_safety,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            '健康生活指南',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '保持身心健康，享受美好生活',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceCard(
    BuildContext context,
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, color: Colors.amber.shade700, size: 28),
              const SizedBox(width: 12),
              Text(
                '注意事项',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildBulletPoint('如出现频率过高（每天多次）的情况，建议寻求专业帮助'),
          _buildBulletPoint('如感到身体不适、疼痛或异常，请及时就医'),
          _buildBulletPoint('避免影响正常工作、学习和社交生活'),
          _buildBulletPoint('未成年人应在家长指导下正确认识生理健康'),
        ],
      ),
    );
  }

  Widget _buildResourcesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                '更多资源',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '• 如需更多健康建议，建议咨询专业医生或心理咨询师\n'
            '• 本应用仅供个人健康追踪使用，不构成医疗建议\n'
            '• 保持积极健康的生活方式最为重要',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
