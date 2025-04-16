import 'package:flutter/material.dart';

class ConfirmOverlay extends StatelessWidget {
  final bool loading;
  final String? address;
  final VoidCallback onConfirm;

  const ConfirmOverlay({
    super.key,
    required this.loading,
    required this.address,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: loading
                ? const CircularProgressIndicator()
                : Text(
                    address ?? 'جارٍ تحديد العنوان...',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onConfirm,
            child: const Text("تأكيد الموقع"),
          ),
        ],
      ),
    );
  }
}
