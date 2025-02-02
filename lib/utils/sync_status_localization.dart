import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:matrix/matrix.dart';

import 'package:fluffychat/utils/localized_exception_extension.dart';

extension SyncStatusLocalization on SyncStatusUpdate {
  IconData get icon {
    switch (status) {
      case SyncStatus.waitingForResponse:
        return Icons.hourglass_empty_outlined;
      case SyncStatus.error:
        return Icons.cloud_off_outlined;
      case SyncStatus.processing:
        return Icons.hourglass_top_outlined;
      case SyncStatus.cleaningUp:
        return Icons.hourglass_bottom_outlined;
      case SyncStatus.finished:
        return Icons.hourglass_full_outlined;
    }
  }

  String calcLocalizedString(BuildContext context) {
    final progress = this.progress;
    switch (status) {
      case SyncStatus.waitingForResponse:
        return L10n.of(context).waitingForServer;
      case SyncStatus.error:
        return ((error?.exception ?? Object()) as Object)
            .toLocalizedString(context);
      case SyncStatus.processing:
      case SyncStatus.cleaningUp:
      case SyncStatus.finished:
        return progress == null
            ? L10n.of(context).synchronizingPleaseWait
            : L10n.of(context).synchronizingPleaseWaitCounter(
                (progress * 100).round().toString(),
              );
    }
  }
}
