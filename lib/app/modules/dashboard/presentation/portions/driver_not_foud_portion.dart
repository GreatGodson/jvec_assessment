import 'package:flutter/material.dart';

import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../../../../shared/presentation/components/button_component.dart';

class DriverNotFoundPortion extends StatelessWidget {
  const DriverNotFoundPortion({
    super.key,
    required this.onCancel,
    required this.onRetry,
  });

  final VoidCallback onCancel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Oops! No drivers are available at the moment"),
        SizedBox(
          height: Spacings.spacing30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ButtonComponent(
                expanded: true,
                text: "Cancel Request",
                onPressed: onCancel,
              ),
            ),
            SizedBox(
              width: Spacings.spacing30,
            ),
            Expanded(
              child: ButtonComponent(
                expanded: true,
                text: "Retry",
                onPressed: onRetry,
              ),
            ),
          ],
        )
      ],
    );
  }
}
