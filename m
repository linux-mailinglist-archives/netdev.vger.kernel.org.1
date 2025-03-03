Return-Path: <netdev+bounces-171226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A60A4C02A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E021892FC8
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6206B211462;
	Mon,  3 Mar 2025 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiT2X8ay"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C46210F4B
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004437; cv=none; b=jIcVdKe0Eon4vYF4zdmwQSoD1N1l54jwaZ5R+XwGPRIrc9fqsiE/HR0rsFiaZRH7i744ZfiMPccaJrpEsROPMWivCgqUQF45yFsOdawjvr7tvQxucJkamPe90g/fckWZuXMsEn4S7O+bEY4NrLEhzF9kT/URwn+gKJgsg/BSgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004437; c=relaxed/simple;
	bh=lxVDAkGGuTFeMA/Z9ZhlF1DbWFEZWkwlVgtu7I5oRcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQaG6qRagFKV99DhEmvHj/5rdE+nndKCNpM22DPVSED+GSSXTkyXmqmeIShGjhKqOyqztEttNGQHopuEmg4E+VqNefYqSAm8ebr15eD2weepC5Z17/3805sPgoor/35WEgy+EZkhksq3UroFqjYh8g5Y/G1ZovQFzGstGOIgKMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiT2X8ay; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741004436; x=1772540436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lxVDAkGGuTFeMA/Z9ZhlF1DbWFEZWkwlVgtu7I5oRcU=;
  b=MiT2X8aywYXTbjEQSfayInK9o4u4g+oGVdw1tf8ta6CobN10Eo7YyXMf
   GafeK8gxxq4BQxsFjaifTd6m/k20/0yq+0gzHmuQSoV4EFpZ2+eyl5LBv
   Ztu5B8j6DnKn2EkeZggi1poW19YnomWuWdKNFqyf8xM49cKU15Xlk08py
   h3DUrWeDIqz0rc5cuajom34RhJlvMERT95CWN45Zr/i1/5pXy9W9Jp+iR
   V/EM7tRJ6XpD9AIu1JtYI+0JpMLikwkxltZ84DDIE/ADO/tH5npGnfDp+
   gkvzoswBh7G9iz9GfKKgFrHLzAIXMX1aq0hoJAgGnzwhhywz1667sCzOh
   w==;
X-CSE-ConnectionGUID: TxHpUhpJSty7rRZZlLze4w==
X-CSE-MsgGUID: W3hBE4CURGmdzbYEhdqzAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41052439"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41052439"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:20:35 -0800
X-CSE-ConnectionGUID: 9gLn7UO2SCmS2hRUIKr5qA==
X-CSE-MsgGUID: f/7JmsJYQqG9If6XXUIInw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117976121"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa007.fm.intel.com with ESMTP; 03 Mar 2025 04:20:33 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	pmenzel@molgen.mpg.de,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v3 3/4] ixgbe: apply different rules for setting FC on E610
Date: Mon,  3 Mar 2025 13:06:29 +0100
Message-Id: <20250303120630.226353-4-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303120630.226353-1-jedrzej.jagielski@intel.com>
References: <20250303120630.226353-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E610 device doesn't support disabling FC autonegotiation.

Create dedicated E610 .set_pauseparam() implementation and assign
it to ixgbe_ethtool_ops_e610.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 57 ++++++++++++++++---
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index abc8c279192a..17d937f672dc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -564,6 +564,22 @@ static void ixgbe_get_pauseparam(struct net_device *netdev,
 	}
 }
 
+static void ixgbe_set_pauseparam_finalize(struct net_device *netdev,
+					  struct ixgbe_fc_info *fc)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	/* If the thing changed then we'll update and use new autoneg. */
+	if (memcmp(fc, &hw->fc, sizeof(*fc))) {
+		hw->fc = *fc;
+		if (netif_running(netdev))
+			ixgbe_reinit_locked(adapter);
+		else
+			ixgbe_reset(adapter);
+	}
+}
+
 static int ixgbe_set_pauseparam(struct net_device *netdev,
 				struct ethtool_pauseparam *pause)
 {
@@ -592,15 +608,40 @@ static int ixgbe_set_pauseparam(struct net_device *netdev,
 	else
 		fc.requested_mode = ixgbe_fc_none;
 
-	/* if the thing changed then we'll update and use new autoneg */
-	if (memcmp(&fc, &hw->fc, sizeof(struct ixgbe_fc_info))) {
-		hw->fc = fc;
-		if (netif_running(netdev))
-			ixgbe_reinit_locked(adapter);
-		else
-			ixgbe_reset(adapter);
+	ixgbe_set_pauseparam_finalize(netdev, &fc);
+
+	return 0;
+}
+
+static int ixgbe_set_pauseparam_e610(struct net_device *netdev,
+				     struct ethtool_pauseparam *pause)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+	struct ixgbe_fc_info fc = hw->fc;
+
+	if (!ixgbe_device_supports_autoneg_fc(hw))
+		return -EOPNOTSUPP;
+
+	if (pause->autoneg == AUTONEG_DISABLE) {
+		netdev_info(netdev,
+			"Cannot disable autonegotiation on this device.\n");
+		return -EOPNOTSUPP;
 	}
 
+	fc.disable_fc_autoneg = false;
+
+	if (pause->rx_pause && pause->tx_pause)
+		fc.requested_mode = ixgbe_fc_full;
+	else if (pause->rx_pause)
+		fc.requested_mode = ixgbe_fc_rx_pause;
+	else if (pause->tx_pause)
+		fc.requested_mode = ixgbe_fc_tx_pause;
+	else
+		fc.requested_mode = ixgbe_fc_none;
+
+	ixgbe_set_pauseparam_finalize(netdev, &fc);
+
 	return 0;
 }
 
@@ -3710,7 +3751,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.set_ringparam          = ixgbe_set_ringparam,
 	.get_pause_stats	= ixgbe_get_pause_stats,
 	.get_pauseparam         = ixgbe_get_pauseparam,
-	.set_pauseparam         = ixgbe_set_pauseparam,
+	.set_pauseparam         = ixgbe_set_pauseparam_e610,
 	.get_msglevel           = ixgbe_get_msglevel,
 	.set_msglevel           = ixgbe_set_msglevel,
 	.self_test              = ixgbe_diag_test,
-- 
2.31.1


