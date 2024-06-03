Return-Path: <netdev+bounces-100397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A43E8FA5D9
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BA51F24FE0
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 22:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D8141987;
	Mon,  3 Jun 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEx6ptZt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FC1411C8
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454309; cv=none; b=D2oN0hogoWV4YVX6pEzIYdVEmAbgC8TDkr38yTcDtB1L2JVK3pdTj//iD+LBxKAnI0chPzfVoB7w2ebbd37yjSpTI7xFmaFmYQ5oxH0acBos8JcvGGyrkF2gQRE+4ZP95XiyIwRUb5BUJnzLEf7PedtmccgiBl3S6MT9JWY40ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454309; c=relaxed/simple;
	bh=2kjzUB8na2cN4OBQvNPcjvOEQpeAh1YQfpxhoGDNjck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QuKIBlCP9VAKyDhg3WkjTus8klx0apbA4DtbQaHE9skGyRokzAtOPdqJCvouBwsn3CIMsRa0efcwc4S0HwK9XPzPlrWCU0hAX6L8lBpQnOY4PxBBnFT8sDRlOOj5AJbkn7Lo+1+hzsQs/rBAFJr8JcMG7p/AgqDsljzMzn4ZF+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEx6ptZt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717454308; x=1748990308;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2kjzUB8na2cN4OBQvNPcjvOEQpeAh1YQfpxhoGDNjck=;
  b=UEx6ptZtZFtP/ahoqo9pkxj9HT1GRyh14NcfFl9VJUn4Q0g6b5C77A51
   LrKq/iwZ4L5CVSJvoRmiN5YYGZzYk+l9FOg/eLaF+hCIo1i01HhHADyZ4
   H5+MwQOj4+8xp+eLV9guE4nxaTEzPpwnt+p1+ZNKSJEf5WwXTkjsmJtc1
   O9g/mEyTULDQXzQmXhDUN3yvHIx2NHskv+rr6dEX9UaToF5zc+7eT+MzJ
   HbdxRvShGL0G9TN1xRmmr3Ad/NNC9CZqTe6ere+LIw1wsr68erZoPfynP
   a4VRWWWSQXIsTE+JJN2lK7Sx/s1AWNVbAqaYGsfDa2obi1CnLtQDE7FjG
   A==;
X-CSE-ConnectionGUID: Q5QfyT0QTwCvuXHeOZ0suQ==
X-CSE-MsgGUID: F15ntv/RQHGxruY86iJHbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13780134"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13780134"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:23 -0700
X-CSE-ConnectionGUID: lqLXdgxlQCyd49Q8qWZl6g==
X-CSE-MsgGUID: ww1Y1VBORQmkmDhNE2N4CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41471208"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:22 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 15:38:21 -0700
Subject: [PATCH 9/9] igc: add support for ethtool.set_phys_id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-next-2024-06-03-intel-next-batch-v1-9-e0523b28f325@intel.com>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
In-Reply-To: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
To: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 Menachem Fogel <menachem.fogel@intel.com>, 
 Naama Meir <naamax.meir@linux.intel.com>
X-Mailer: b4 0.13.0

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Add support for ethtool.set_phys_id callback to initiate LED blinking
and stopping them by the ethtool interface.
This is done by storing the initial LEDCTL register value and restoring
it when LED blinking is terminated.

In addition, moved IGC_LEDCTL related defines from igc_leds.c to
igc_defines.h where they can be included by all of the igc module
files.

Co-developed-by: Menachem Fogel <menachem.fogel@intel.com>
Signed-off-by: Menachem Fogel <menachem.fogel@intel.com>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 22 +++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 32 ++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_hw.h      |  2 ++
 drivers/net/ethernet/intel/igc/igc_leds.c    | 21 +-----------------
 drivers/net/ethernet/intel/igc/igc_main.c    |  2 ++
 5 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 5f92b3c7c3d4..664d49f10427 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -686,4 +686,26 @@
 #define IGC_LTRMAXV_LSNP_REQ		0x00008000 /* LTR Snoop Requirement */
 #define IGC_LTRMAXV_SCALE_SHIFT		10
 
+/* LED ctrl defines */
+#define IGC_NUM_LEDS			3
+
+#define IGC_LEDCTL_GLOBAL_BLINK_MODE	BIT(5)
+#define IGC_LEDCTL_LED0_MODE_SHIFT	0
+#define IGC_LEDCTL_LED0_MODE_MASK	GENMASK(3, 0)
+#define IGC_LEDCTL_LED0_BLINK		BIT(7)
+#define IGC_LEDCTL_LED1_MODE_SHIFT	8
+#define IGC_LEDCTL_LED1_MODE_MASK	GENMASK(11, 8)
+#define IGC_LEDCTL_LED1_BLINK		BIT(15)
+#define IGC_LEDCTL_LED2_MODE_SHIFT	16
+#define IGC_LEDCTL_LED2_MODE_MASK	GENMASK(19, 16)
+#define IGC_LEDCTL_LED2_BLINK		BIT(23)
+
+#define IGC_LEDCTL_MODE_ON		0x00
+#define IGC_LEDCTL_MODE_OFF		0x01
+#define IGC_LEDCTL_MODE_LINK_10		0x05
+#define IGC_LEDCTL_MODE_LINK_100	0x06
+#define IGC_LEDCTL_MODE_LINK_1000	0x07
+#define IGC_LEDCTL_MODE_LINK_2500	0x08
+#define IGC_LEDCTL_MODE_ACTIVITY	0x0b
+
 #endif /* _IGC_DEFINES_H_ */
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index f2c4f1966bb0..82ece5f95f1e 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1975,6 +1975,37 @@ static void igc_ethtool_diag_test(struct net_device *netdev,
 	msleep_interruptible(4 * 1000);
 }
 
+static int igc_ethtool_set_phys_id(struct net_device *netdev,
+				   enum ethtool_phys_id_state state)
+{
+	struct igc_adapter *adapter = netdev_priv(netdev);
+	struct igc_hw *hw = &adapter->hw;
+	u32 ledctl;
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		ledctl = rd32(IGC_LEDCTL);
+
+		/* initiate LED1 blinking */
+		ledctl &= ~(IGC_LEDCTL_GLOBAL_BLINK_MODE |
+			   IGC_LEDCTL_LED1_MODE_MASK |
+			   IGC_LEDCTL_LED2_MODE_MASK);
+		ledctl |= IGC_LEDCTL_LED1_BLINK;
+		wr32(IGC_LEDCTL, ledctl);
+		break;
+
+	case ETHTOOL_ID_INACTIVE:
+		/* restore LEDCTL default value */
+		wr32(IGC_LEDCTL, hw->mac.ledctl_default);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops igc_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.get_drvinfo		= igc_ethtool_get_drvinfo,
@@ -2013,6 +2044,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.get_link_ksettings	= igc_ethtool_get_link_ksettings,
 	.set_link_ksettings	= igc_ethtool_set_link_ksettings,
 	.self_test		= igc_ethtool_diag_test,
+	.set_phys_id		= igc_ethtool_set_phys_id,
 };
 
 void igc_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index e1c572e0d4ef..45b68695bdb7 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -95,6 +95,8 @@ struct igc_mac_info {
 	bool autoneg;
 	bool autoneg_failed;
 	bool get_link_status;
+
+	u32 ledctl_default;
 };
 
 struct igc_nvm_operations {
diff --git a/drivers/net/ethernet/intel/igc/igc_leds.c b/drivers/net/ethernet/intel/igc/igc_leds.c
index 3929b25b6ae6..e5eeef240802 100644
--- a/drivers/net/ethernet/intel/igc/igc_leds.c
+++ b/drivers/net/ethernet/intel/igc/igc_leds.c
@@ -8,26 +8,7 @@
 #include <uapi/linux/uleds.h>
 
 #include "igc.h"
-
-#define IGC_NUM_LEDS			3
-
-#define IGC_LEDCTL_LED0_MODE_SHIFT	0
-#define IGC_LEDCTL_LED0_MODE_MASK	GENMASK(3, 0)
-#define IGC_LEDCTL_LED0_BLINK		BIT(7)
-#define IGC_LEDCTL_LED1_MODE_SHIFT	8
-#define IGC_LEDCTL_LED1_MODE_MASK	GENMASK(11, 8)
-#define IGC_LEDCTL_LED1_BLINK		BIT(15)
-#define IGC_LEDCTL_LED2_MODE_SHIFT	16
-#define IGC_LEDCTL_LED2_MODE_MASK	GENMASK(19, 16)
-#define IGC_LEDCTL_LED2_BLINK		BIT(23)
-
-#define IGC_LEDCTL_MODE_ON		0x00
-#define IGC_LEDCTL_MODE_OFF		0x01
-#define IGC_LEDCTL_MODE_LINK_10		0x05
-#define IGC_LEDCTL_MODE_LINK_100	0x06
-#define IGC_LEDCTL_MODE_LINK_1000	0x07
-#define IGC_LEDCTL_MODE_LINK_2500	0x08
-#define IGC_LEDCTL_MODE_ACTIVITY	0x0b
+#include "igc_defines.h"
 
 #define IGC_SUPPORTED_MODES						 \
 	(BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK_1000) | \
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 12f004f46082..d0db302aa3eb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7070,6 +7070,8 @@ static int igc_probe(struct pci_dev *pdev,
 			goto err_register;
 	}
 
+	hw->mac.ledctl_default = rd32(IGC_LEDCTL);
+
 	return 0;
 
 err_register:

-- 
2.44.0.53.g0f9d4d28b7e6


