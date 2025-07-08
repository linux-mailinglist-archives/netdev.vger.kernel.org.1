Return-Path: <netdev+bounces-204863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123DEAFC530
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476CB3AB786
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689BF29DB96;
	Tue,  8 Jul 2025 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcsvsQnN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E79184540;
	Tue,  8 Jul 2025 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962533; cv=none; b=Hv5KmJEej2x7r8l24CFpm0SJ9+A6zlUCW93se89/KcMNeZNbUu61rHJ2Eq9dLlL8RCXBvqDw3+09wgJFPANJlVmMwSX0RXHLvjXtto4qCq0Jtx3CVcuvr3f5bEWYikttr0ErWZ6GvpUpiDyPcPyUIlWGrVLxxnrV1xA0GG5plF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962533; c=relaxed/simple;
	bh=rYlFHlvjj1QePapukAiI/tzY5PooIzqMJ0D/NC0iFMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5netZntwyWdSfwyqtEr1Pg1+uoCHKHwVLEcjqGwHxMHj2ObIK5Ywlnk46BuaTOlywB8y44rd+SJoltjTtRlbAzJcggJ8H2tSEfrp9zIVZewX9Zfy7loYF9dAbFygSSgEDS7zzq5ig8PlmFSPh0LEXTz0LQBlTUQjJDyBxU+ou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcsvsQnN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751962532; x=1783498532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rYlFHlvjj1QePapukAiI/tzY5PooIzqMJ0D/NC0iFMI=;
  b=QcsvsQnNf2BGJ8TgQURxzXaQfvtYosUeOA9ONdWHw1gQxhCDjOnzC3N6
   wEnjU9G3k4xQYnOxKyqtRhTWQuO0OdkBZ0s+fjOP8eK9d9Fj5Zv/KSRnq
   uIDBhFKCFJ+jTcH1376Ux7AhO1fAM9Pg2aZnq1xKam7bV+uQGu1IIC8/e
   62fuCI/tK3Ums1riVOnwEj8ULQ2LukWkD4liOs47G10NDiJ7aHGzIoiuH
   n0ewgfMPnrjgqG7pW3VmyUim3KNek5sw+KxZm1IwNRutBmXcuKHZYjjQ1
   mxSD3Hcs7g7wrDUICeT17mbULMXwcTklarCS28b7OzjGb94qkWWtW0ChO
   A==;
X-CSE-ConnectionGUID: xWLD/eb7TNeh8qr2dSYUGw==
X-CSE-MsgGUID: UJv/0a2PT726jDOW2FrdzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64440584"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="64440584"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 01:15:32 -0700
X-CSE-ConnectionGUID: VVE8yAZxRRiXIaLhf4YU3A==
X-CSE-MsgGUID: NygHuXbBR32HQw2wSj3eeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="179106015"
Received: from ubuntu.bj.intel.com ([10.238.156.109])
  by fmviesa002.fm.intel.com with ESMTP; 08 Jul 2025 01:15:29 -0700
From: Jun Miao <jun.miao@intel.com>
To: o.rempel@pengutronix.de,
	kuba@kernel.org,
	oneukum@suse.com,
	qiang.zhang@linux.dev
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: enable the work after stop usbnet by ip down/up
Date: Tue,  8 Jul 2025 16:16:53 +0800
Message-Id: <20250708081653.307815-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

Oleksij reported that:
The smsc95xx driver fails after one down/up cycle, like this:
 $ nmcli device set enu1u1 managed no
 $ p a a 10.10.10.1/24 dev enu1u1
 $ ping -c 4 10.10.10.3
 $ ip l s dev enu1u1 down
 $ ip l s dev enu1u1 up
 $ ping -c 4 10.10.10.3
The second ping does not reach the host. Networking also fails on other interfaces.

Enable the work by replacing the disable_work_sync() with cancel_work_sync().

[Jun Miao: completely write the commit changelog]

Fixes: 2c04d279e857 ("net: usb: Convert tasklet API to new bottom half workqueue mechanism")
Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Jun Miao <jun.miao@intel.com>
---
 drivers/net/usb/usbnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 9564478a79cc..6a3cca104af9 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -861,14 +861,14 @@ int usbnet_stop (struct net_device *net)
 	/* deferred work (timer, softirq, task) must also stop */
 	dev->flags = 0;
 	timer_delete_sync(&dev->delay);
-	disable_work_sync(&dev->bh_work);
+	cancel_work_sync(&dev->bh_work);
 	cancel_work_sync(&dev->kevent);
 
 	/* We have cyclic dependencies. Those calls are needed
 	 * to break a cycle. We cannot fall into the gaps because
 	 * we have a flag
 	 */
-	disable_work_sync(&dev->bh_work);
+	cancel_work_sync(&dev->bh_work);
 	timer_delete_sync(&dev->delay);
 	cancel_work_sync(&dev->kevent);
 
-- 
2.32.0


