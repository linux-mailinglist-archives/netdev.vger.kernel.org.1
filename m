Return-Path: <netdev+bounces-120601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B298959EDD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A55281626
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C990D1B1D45;
	Wed, 21 Aug 2024 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hl1bz3hC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068241ACDF9
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247465; cv=none; b=gYt0yPXHUsNq0j8VCveUAH7qI94DDHYYGSC2TMA2uS6KQfCp98tVIwJV1BnFlzi6j/PM7ulmauob/GPduK4Y9vcxXppsCSdiUBV64P/pymC38IIafdMcjpcUNxysC7dA0n67jDuyZ4ec5Mdf7QbeOZz/kgmVfYGsw3FgY0frVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247465; c=relaxed/simple;
	bh=mFPXl/q79lOeWvFuLlYuGgUCK3FfoNFy+V5ehUucfeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CsxxNoAC9j6sjF5qIxXZscGlZAVk7xe0vtD4MuDc03zYG08128E7BYQnMnrYNMWGEvnEY6yVicE5gOEXBeKRPSX4W/LEc8jwR49CpLk+XuFJh36Y+SQNtRAFyEaCGWnMQc0EULoCMXsxl9wkUnVedUh/1iKzxPTQz00mPvvmf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hl1bz3hC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724247464; x=1755783464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mFPXl/q79lOeWvFuLlYuGgUCK3FfoNFy+V5ehUucfeE=;
  b=hl1bz3hC1Gm7L4+gl3Nl/5Ob9bPvdl1tzcW9GPkWRuKmgyA9kI8UHgaf
   6ZXURQKbXw1o5FyqghTaEonvr53HLlCrNBXSMxk3Hg3a4hVjbfiLEH2X5
   uR3du1pLFZjsL5e+JLZzyu+sRfWRg2FjvNuEcZk/gmmYw/JyrQrDTXRSC
   gN5Lo7u9tFhdC7sCssYiGWj0F2pMHTqPfH54EPv/Vrguppm+TBdUbaDGu
   vES8bSvFj6Tf9RALnFEfIDdZvmCqt+W5/gEmrRQI8JCq423WDfu7e9nBW
   sZfufC2jlYc/daP37Ci+fvANSvadTQqkM8JY+JKlfum5M8VTFN61PEG1p
   Q==;
X-CSE-ConnectionGUID: jpUfPP3DSIGc6El4lM50eQ==
X-CSE-MsgGUID: ly+qzYlvS6abJCnM/Y5PNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="45131502"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="45131502"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:37:40 -0700
X-CSE-ConnectionGUID: 4q48cYtRQLOV/dce3Je44w==
X-CSE-MsgGUID: CLZM7ciGSEytKBwPPRCSZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61071294"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 21 Aug 2024 06:37:36 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BAB842878C;
	Wed, 21 Aug 2024 14:37:33 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Jiri Pirko <jiri@resnulli.us>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH iwl-next v3 5/6] ice: dump ethtool stats and skb by Tx hang devlink health reporter
Date: Wed, 21 Aug 2024 15:37:13 +0200
Message-Id: <20240821133714.61417-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
References: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print the ethtool stats and skb diagnostic information as part of Tx hang
devlink health dump.

Move the declarations of ethtool functions that devlink health uses out
to a new file: ice_ethtool_common.h

To utilize our existing ethtool code in this context, convert it to
non-static.

Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  2 +
 .../ethernet/intel/ice/ice_ethtool_common.h   | 19 ++++++++++
 .../intel/ice/devlink/devlink_health.c        | 37 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 10 ++---
 4 files changed, 63 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool_common.h

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
index 9acccae38625..fd021d2813f8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
@@ -4,6 +4,8 @@
 #ifndef _ICE_ETHTOOL_H_
 #define _ICE_ETHTOOL_H_
 
+#include "ice_ethtool_common.h"
+
 struct ice_phy_type_to_ethtool {
 	u64 aq_link_speed;
 	u8 link_mode;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_common.h b/drivers/net/ethernet/intel/ice/ice_ethtool_common.h
new file mode 100644
index 000000000000..0c772056f006
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_common.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024, Intel Corporation. */
+
+#ifndef _ICE_ETHTOOL_COMMON_H_
+#define _ICE_ETHTOOL_COMMON_H_
+
+/**
+ * DOC: ice_ethtool_common.h
+ *
+ * This header is for ethtool related code that is reused in other places.
+ */
+
+void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data);
+int ice_get_sset_count(struct net_device *netdev, int sset);
+void ice_get_ethtool_stats(struct net_device *netdev,
+			   struct ethtool_stats __always_unused *stats,
+			   u64 *data);
+
+#endif /* _ICE_ETHTOOL_COMMON_H_ */
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_health.c b/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
index 193dd4d00578..086042260235 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
@@ -3,6 +3,7 @@
 
 #include "devlink_health.h"
 #include "ice.h"
+#include "ice_ethtool_common.h"
 
 #define ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, obj, name) \
 	devlink_fmsg_put(fmsg, #name, (obj)->name)
@@ -26,6 +27,36 @@ static void ice_devlink_health_report(struct devlink_health_reporter *reporter,
 	devlink_health_report(reporter, msg, priv_ctx);
 }
 
+static void ice_dump_ethtool_stats_to_fmsg(struct devlink_fmsg *fmsg,
+					   struct net_device *netdev)
+{
+	const u32 string_set = ETH_SS_STATS;
+	u64 *stats;
+	u8 *names;
+	int scnt;
+
+	scnt = ice_get_sset_count(netdev, string_set);
+	devlink_fmsg_put(fmsg, "stats-cnt", (u32)scnt);
+	if (scnt <= 0)
+		return;
+
+	names = kcalloc(scnt, ETH_GSTRING_LEN, GFP_KERNEL);
+	stats = kcalloc(scnt, sizeof(*stats), GFP_KERNEL);
+	if (!names || !stats)
+		goto out;
+
+	ice_get_strings(netdev, string_set, names);
+	ice_get_ethtool_stats(netdev, NULL, stats);
+
+	devlink_fmsg_obj_nest_start(fmsg);
+	for (int i = 0; i < scnt; ++i)
+		devlink_fmsg_put(fmsg, &names[i * ETH_GSTRING_LEN], stats[i]);
+	devlink_fmsg_obj_nest_end(fmsg);
+out:
+	kfree(names);
+	kfree(stats);
+}
+
 /**
  * ice_fmsg_put_ptr - put hex value of pointer into fmsg
  *
@@ -57,6 +88,9 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 				     struct netlink_ext_ack *extack)
 {
 	struct ice_tx_hang_event *event = priv_ctx;
+	struct sk_buff *skb;
+
+	skb = event->tx_ring->tx_buf->skb;
 
 	if (!event)
 		return 0;
@@ -71,8 +105,11 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 	devlink_fmsg_put(fmsg, "irq-mapping", event->tx_ring->q_vector->name);
 	ice_fmsg_put_ptr(fmsg, "desc-ptr", event->tx_ring->desc);
 	ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)(long)event->tx_ring->dma);
+	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
 	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
 				     event->tx_ring->count * sizeof(struct ice_tx_desc));
+	devlink_fmsg_dump_skb(fmsg, skb);
+	ice_dump_ethtool_stats_to_fmsg(fmsg, event->tx_ring->vsi->netdev);
 	devlink_fmsg_obj_nest_end(fmsg);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 143c8b9e58fe..8c6bc94a0ed3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1529,7 +1529,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 	}
 }
 
-static void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+void ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 
@@ -1909,7 +1909,7 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 	return ret;
 }
 
-static int ice_get_sset_count(struct net_device *netdev, int sset)
+int ice_get_sset_count(struct net_device *netdev, int sset)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
@@ -2012,9 +2012,9 @@ __ice_get_ethtool_stats(struct net_device *netdev,
 	}
 }
 
-static void
-ice_get_ethtool_stats(struct net_device *netdev,
-		      struct ethtool_stats __always_unused *stats, u64 *data)
+void ice_get_ethtool_stats(struct net_device *netdev,
+			   struct ethtool_stats __always_unused *stats,
+			   u64 *data)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 
-- 
2.39.3


