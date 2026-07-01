Return-Path: <netdev+bounces-303837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O/XXEDiCRWpqBQsAu9opvQ
	(envelope-from <netdev+bounces-303837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:10:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 954EF6F1C1D
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:10:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=kolWTFXm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303837-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303837-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B48317302E
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C43B3C18;
	Wed,  1 Jul 2026 21:03:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BF3A5E70
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939806; cv=none; b=XUOyGJ/9EaqG1lHFTx4E/3RNlx1KRHIEcbNidJ4hmprwWLRLRp/iRlIu9nTSwwP9CExh/4lW2MfCzeh/uoJQjrvFGHJnNcPJgQ74V5C+/J03zSguLkglxIh74xakAsar2fi6fEtnT1a2l8wYsZ3GWS88cV+ypYMT8NU+Pl6DfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939806; c=relaxed/simple;
	bh=Q9JvpS9s3wET+AdyeVhFw+OgDMSDC/phnhxAXq6qtJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGB+bU8Oi5FnXdRV4Qf2g5SzcBnXVxviyzAE8HB6Fra/Em3L058padFVZseF/gnRu+Xrako6qtvNNlDlLP9r7h0gwNf5vcWI13nali02gi1ox6gdKstCQJJ7Ii1YA3+a5Y6Uqe8fW75s8oGf2Fk4GN90INdMqNX/yjMnrKBMruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kolWTFXm; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939804; x=1814475804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q9JvpS9s3wET+AdyeVhFw+OgDMSDC/phnhxAXq6qtJA=;
  b=kolWTFXmCMapb6/QXRPUrvNyPRxd2bwPU1coyQkQt0YHcv8LyBGtxFrY
   Tq8/ZlZ8G6Izo++nmOP0GPXqCHtp2jPHqMd26Rym+A93/Zv2SH0krfKy6
   7adB/eBMvu4v6NkfV5bAOYffI2dE5W+9EitGXSmqfBkrCixwg4t9ij1am
   plccJpyXihOlKWGh5rap7waZEQFgt63j2hWjHRqAwldQJJ+Baa1VXINOE
   Sjw3wHRJPU0mcAQWDS1dXyZ9JH+1wOJ+WeaB+2YzNDzarCoXmSIApD803
   /4S5YmL8NBceD8Ma0DVMXwGWZUlrrM66DzjH6k/VkKGim/WHNDMxxlRSh
   w==;
X-CSE-ConnectionGUID: spXu3EW5QMqR6uokvnzZpQ==
X-CSE-MsgGUID: F8FMsdFpRgSZjAf4TohCrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069159"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069159"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:14 -0700
X-CSE-ConnectionGUID: eQreUp+bTg6GVOM9K73CjA==
X-CSE-MsgGUID: OASIMeJ6R+yIjjlkiuZpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561437"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 14:03:14 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	khai.wen.tan@intel.com,
	khai.wen.tan@linux.intel.com,
	faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com,
	hector.blanco.alcaine@intel.com,
	dima.ruinskiy@intel.com,
	Simon Horman <horms@kernel.org>,
	Moriya Kadosh <moriyax.kadosh@intel.com>
Subject: [PATCH net-next 11/11] igc: add support for forcing link speed without autonegotiation
Date: Wed,  1 Jul 2026 14:03:00 -0700
Message-ID: <20260701210303.1745310-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303837-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:faizal.abdul.rahim@linux.intel.com,m:anthony.l.nguyen@intel.com,m:khai.wen.tan@intel.com,m:khai.wen.tan@linux.intel.com,m:faizal.abdul.rahim@intel.com,m:hong.aun.looi@intel.com,m:hector.blanco.alcaine@intel.com,m:dima.ruinskiy@intel.com,m:horms@kernel.org,m:moriyax.kadosh@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 954EF6F1C1D

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Allow users to force 10/100 Mb/s link speed and duplex via ethtool
when autonegotiation is disabled. Previously, the driver rejected
these requests with "Force mode currently not supported.".

Forcing at 1000 Mb/s and 2500 Mb/s is not supported.

Reviewed-by: Looi Hong Aun <hong.aun.looi@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Khai Wen Tan <khai.wen.tan@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c    |  35 ++++-
 drivers/net/ethernet/intel/igc/igc_defines.h |   9 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 138 ++++++++++++++-----
 drivers/net/ethernet/intel/igc/igc_hw.h      |   9 ++
 drivers/net/ethernet/intel/igc/igc_mac.c     |  12 ++
 drivers/net/ethernet/intel/igc/igc_main.c    |   2 +-
 drivers/net/ethernet/intel/igc/igc_phy.c     |  65 ++++++++-
 drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
 8 files changed, 220 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 1613b562d17c..ab9120a3127f 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -114,11 +114,35 @@ static s32 igc_setup_copper_link_base(struct igc_hw *hw)
 	u32 ctrl;
 
 	ctrl = rd32(IGC_CTRL);
-	ctrl |= IGC_CTRL_SLU;
-	ctrl &= ~(IGC_CTRL_FRCSPD | IGC_CTRL_FRCDPX);
-	wr32(IGC_CTRL, ctrl);
-
-	ret_val = igc_setup_copper_link(hw);
+	ctrl &= ~(IGC_CTRL_FRCSPD | IGC_CTRL_FRCDPX |
+		  IGC_CTRL_SPEED_MASK | IGC_CTRL_FD);
+
+	if (hw->mac.autoneg_enabled) {
+		ctrl |= IGC_CTRL_SLU;
+		wr32(IGC_CTRL, ctrl);
+		ret_val = igc_setup_copper_link(hw);
+	} else {
+		ctrl |= IGC_CTRL_SLU | IGC_CTRL_FRCSPD | IGC_CTRL_FRCDPX;
+
+		switch (hw->mac.forced_speed_duplex) {
+		case IGC_FORCED_10H:
+			ctrl |= IGC_CTRL_SPEED_10;
+			break;
+		case IGC_FORCED_10F:
+			ctrl |= IGC_CTRL_SPEED_10 | IGC_CTRL_FD;
+			break;
+		case IGC_FORCED_100H:
+			ctrl |= IGC_CTRL_SPEED_100;
+			break;
+		case IGC_FORCED_100F:
+			ctrl |= IGC_CTRL_SPEED_100 | IGC_CTRL_FD;
+			break;
+		default:
+			return -IGC_ERR_CONFIG;
+		}
+		wr32(IGC_CTRL, ctrl);
+		ret_val = igc_setup_copper_link(hw);
+	}
 
 	return ret_val;
 }
@@ -443,6 +467,7 @@ static const struct igc_phy_operations igc_phy_ops_base = {
 	.reset			= igc_phy_hw_reset,
 	.read_reg		= igc_read_phy_reg_gpy,
 	.write_reg		= igc_write_phy_reg_gpy,
+	.force_speed_duplex	= igc_force_speed_duplex,
 };
 
 const struct igc_info igc_base_info = {
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 9482ab11f050..3f504751c2d9 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -129,10 +129,13 @@
 #define IGC_ERR_SWFW_SYNC		13
 
 /* Device Control */
+#define IGC_CTRL_FD		BIT(0)  /* Full Duplex */
 #define IGC_CTRL_RST		0x04000000  /* Global reset */
-
 #define IGC_CTRL_PHY_RST	0x80000000  /* PHY Reset */
 #define IGC_CTRL_SLU		0x00000040  /* Set link up (Force Link) */
+#define IGC_CTRL_SPEED_MASK	GENMASK(10, 8)
+#define IGC_CTRL_SPEED_10	FIELD_PREP(IGC_CTRL_SPEED_MASK, 0)
+#define IGC_CTRL_SPEED_100	FIELD_PREP(IGC_CTRL_SPEED_MASK, 1)
 #define IGC_CTRL_FRCSPD		0x00000800  /* Force Speed */
 #define IGC_CTRL_FRCDPX		0x00001000  /* Force Duplex */
 #define IGC_CTRL_VME		0x40000000  /* IEEE VLAN mode enable */
@@ -673,6 +676,10 @@
 #define IGC_GEN_POLL_TIMEOUT	1920
 
 /* PHY Control Register */
+#define MII_CR_SPEED_MASK	(BIT(6) | BIT(13))
+#define MII_CR_SPEED_10		0x0000	/* SSM=0, SSL=0: 10 Mb/s */
+#define MII_CR_SPEED_100	BIT(13)	/* SSM=0, SSL=1: 100 Mb/s */
+#define MII_CR_DUPLEX_EN	BIT(8)	/* 0 = Half Duplex, 1 = Full Duplex */
 #define MII_CR_RESTART_AUTO_NEG	0x0200  /* Restart auto negotiation */
 #define MII_CR_POWER_DOWN	0x0800  /* Power down */
 #define MII_CR_AUTO_NEG_EN	0x1000  /* Auto Neg Enable */
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 7ee84c24dc4e..89fe2788a565 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1946,44 +1946,58 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
 	ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
 
-	/* advertising link modes */
-	if (hw->phy.autoneg_advertised & ADVERTISE_10_HALF)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, 10baseT_Half);
-	if (hw->phy.autoneg_advertised & ADVERTISE_10_FULL)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, 10baseT_Full);
-	if (hw->phy.autoneg_advertised & ADVERTISE_100_HALF)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, 100baseT_Half);
-	if (hw->phy.autoneg_advertised & ADVERTISE_100_FULL)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, 100baseT_Full);
-	if (hw->phy.autoneg_advertised & ADVERTISE_1000_FULL)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, 1000baseT_Full);
-	if (hw->phy.autoneg_advertised & ADVERTISE_2500_FULL)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, 2500baseT_Full);
-
 	/* set autoneg settings */
 	ethtool_link_ksettings_add_link_mode(cmd, supported, Autoneg);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+	if (hw->mac.autoneg_enabled) {
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, Autoneg);
+		cmd->base.autoneg = AUTONEG_ENABLE;
+
+		/* advertising link modes only apply when autoneg is on */
+		if (hw->phy.autoneg_advertised & ADVERTISE_10_HALF)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     10baseT_Half);
+		if (hw->phy.autoneg_advertised & ADVERTISE_10_FULL)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     10baseT_Full);
+		if (hw->phy.autoneg_advertised & ADVERTISE_100_HALF)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     100baseT_Half);
+		if (hw->phy.autoneg_advertised & ADVERTISE_100_FULL)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     100baseT_Full);
+		if (hw->phy.autoneg_advertised & ADVERTISE_1000_FULL)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     1000baseT_Full);
+		if (hw->phy.autoneg_advertised & ADVERTISE_2500_FULL)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     2500baseT_Full);
+
+		/* Set pause flow control advertising */
+		switch (hw->fc.requested_mode) {
+		case igc_fc_full:
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     Pause);
+			break;
+		case igc_fc_rx_pause:
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     Pause);
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     Asym_Pause);
+			break;
+		case igc_fc_tx_pause:
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     Asym_Pause);
+			break;
+		default:
+			break;
+		}
+	} else {
+		cmd->base.autoneg = AUTONEG_DISABLE;
+	}
 
-	/* Set pause flow control settings */
+	/* Pause is always supported */
 	ethtool_link_ksettings_add_link_mode(cmd, supported, Pause);
 
-	switch (hw->fc.requested_mode) {
-	case igc_fc_full:
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, Pause);
-		break;
-	case igc_fc_rx_pause:
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, Pause);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     Asym_Pause);
-		break;
-	case igc_fc_tx_pause:
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     Asym_Pause);
-		break;
-	default:
-		break;
-	}
-
 	status = pm_runtime_suspended(&adapter->pdev->dev) ?
 		 0 : rd32(IGC_STATUS);
 
@@ -2015,7 +2029,6 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 		cmd->base.duplex = DUPLEX_UNKNOWN;
 	}
 	cmd->base.speed = speed;
-	cmd->base.autoneg = AUTONEG_ENABLE;
 
 	/* MDI-X => 2; MDI =>1; Invalid =>0 */
 	if (hw->phy.media_type == igc_media_type_copper)
@@ -2032,6 +2045,37 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+/**
+ * igc_handle_autoneg_disabled - Configure forced speed/duplex settings
+ * @adapter: private driver structure
+ * @speed: requested speed (must be SPEED_10 or SPEED_100)
+ * @duplex: requested duplex
+ *
+ * Records forced speed/duplex when autoneg is disabled.
+ * Caller must validate speed before calling this function.
+ */
+static void igc_handle_autoneg_disabled(struct igc_adapter *adapter, u32 speed,
+					u8 duplex)
+{
+	struct igc_mac_info *mac = &adapter->hw.mac;
+
+	switch (speed) {
+	case SPEED_10:
+		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
+			IGC_FORCED_10F : IGC_FORCED_10H;
+		break;
+	case SPEED_100:
+		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
+			IGC_FORCED_100F : IGC_FORCED_100H;
+		break;
+	default:
+		WARN_ONCE(1, "Unsupported speed %u\n", speed);
+		return;
+	}
+
+	mac->autoneg_enabled = false;
+}
+
 /**
  * igc_handle_autoneg_enabled - Configure autonegotiation advertisement
  * @adapter: private driver structure
@@ -2070,6 +2114,7 @@ static void igc_handle_autoneg_enabled(struct igc_adapter *adapter,
 						  10baseT_Half))
 		advertised |= ADVERTISE_10_HALF;
 
+	hw->mac.autoneg_enabled = true;
 	hw->phy.autoneg_advertised = advertised;
 	if (adapter->fc_autoneg)
 		hw->fc.requested_mode = igc_fc_default;
@@ -2091,6 +2136,12 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 		return -EINVAL;
 	}
 
+	if (cmd->base.autoneg != AUTONEG_ENABLE &&
+	    cmd->base.autoneg != AUTONEG_DISABLE) {
+		netdev_info(dev, "Unsupported autoneg setting\n");
+		return -EINVAL;
+	}
+
 	/* MDI setting is only allowed when autoneg enabled because
 	 * some hardware doesn't allow MDI setting when speed or
 	 * duplex is forced.
@@ -2103,14 +2154,25 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 		}
 	}
 
+	if (cmd->base.autoneg == AUTONEG_DISABLE) {
+		if (cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
+			netdev_info(dev, "Unsupported speed for forced link\n");
+			return -EINVAL;
+		}
+		if (cmd->base.duplex != DUPLEX_HALF && cmd->base.duplex != DUPLEX_FULL) {
+			netdev_info(dev, "Duplex must be half or full for forced link\n");
+			return -EINVAL;
+		}
+	}
+
 	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
-	if (cmd->base.autoneg == AUTONEG_ENABLE) {
+	if (cmd->base.autoneg == AUTONEG_ENABLE)
 		igc_handle_autoneg_enabled(adapter, cmd);
-	} else {
-		netdev_info(dev, "Force mode currently not supported\n");
-	}
+	else
+		igc_handle_autoneg_disabled(adapter, cmd->base.speed,
+					    cmd->base.duplex);
 
 	/* MDI-X => 2; MDI => 1; Auto => 3 */
 	if (cmd->base.eth_tp_mdix_ctrl) {
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 86ab8f566f44..62aaee55668a 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -73,6 +73,13 @@ struct igc_info {
 
 extern const struct igc_info igc_base_info;
 
+enum igc_forced_speed_duplex {
+	IGC_FORCED_10H,
+	IGC_FORCED_10F,
+	IGC_FORCED_100H,
+	IGC_FORCED_100F,
+};
+
 struct igc_mac_info {
 	struct igc_mac_operations ops;
 
@@ -93,6 +100,8 @@ struct igc_mac_info {
 	bool arc_subsystem_valid;
 
 	bool get_link_status;
+	bool autoneg_enabled;
+	enum igc_forced_speed_duplex forced_speed_duplex;
 };
 
 struct igc_nvm_operations {
diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 0a3d3f357505..d6f3f6618469 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -446,6 +446,17 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	u16 speed, duplex;
 	s32 ret_val = 0;
 
+	/* Without autoneg, flow control capability is not exchanged with the
+	 * link partner. IEEE 802.3 prohibits flow control in half-duplex mode.
+	 */
+	if (!hw->mac.autoneg_enabled) {
+		if (hw->mac.forced_speed_duplex == IGC_FORCED_10H ||
+		    hw->mac.forced_speed_duplex == IGC_FORCED_100H)
+			hw->fc.current_mode = igc_fc_none;
+
+		goto force_fc;
+	}
+
 	/* In auto-neg, we need to check and see if Auto-Neg has completed,
 	 * and if so, how the PHY and link partner has flow control
 	 * configured.
@@ -607,6 +618,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	/* Now we call a subroutine to actually force the MAC
 	 * controller to use the correct flow control settings.
 	 */
+force_fc:
 	ret_val = igc_force_mac_fc(hw);
 	if (ret_val) {
 		hw_dbg("Error forcing flow control settings\n");
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 5ef229a5931f..e6e9441fc3d4 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7298,7 +7298,7 @@ static int igc_probe(struct pci_dev *pdev,
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg = true;
 	hw->phy.autoneg_advertised = 0xaf;
-
+	hw->mac.autoneg_enabled = true;
 	hw->fc.requested_mode = igc_fc_default;
 	hw->fc.current_mode = igc_fc_default;
 
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 6c4d204aecfa..4cf737fb3b21 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -494,12 +494,20 @@ s32 igc_setup_copper_link(struct igc_hw *hw)
 	s32 ret_val = 0;
 	bool link;
 
-	/* Setup autoneg and flow control advertisement and perform
-	 * autonegotiation.
-	 */
-	ret_val = igc_copper_link_autoneg(hw);
-	if (ret_val)
-		goto out;
+	if (hw->mac.autoneg_enabled) {
+		/* Setup autoneg and flow control advertisement and perform
+		 * autonegotiation.
+		 */
+		ret_val = igc_copper_link_autoneg(hw);
+		if (ret_val)
+			goto out;
+	} else {
+		ret_val = hw->phy.ops.force_speed_duplex(hw);
+		if (ret_val) {
+			hw_dbg("Error Forcing Speed/Duplex\n");
+			goto out;
+		}
+	}
 
 	/* Check link status. Wait up to 100 microseconds for link to become
 	 * valid.
@@ -778,3 +786,48 @@ u16 igc_read_phy_fw_version(struct igc_hw *hw)
 
 	return gphy_version;
 }
+
+/**
+ * igc_force_speed_duplex - Force PHY speed and duplex settings
+ * @hw: pointer to the HW structure
+ *
+ * Programs the GPY PHY control register to disable autonegotiation
+ * and force the speed/duplex indicated by hw->mac.forced_speed_duplex.
+ */
+s32 igc_force_speed_duplex(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	u16 phy_ctrl;
+	s32 ret_val;
+
+	ret_val = phy->ops.read_reg(hw, PHY_CONTROL, &phy_ctrl);
+	if (ret_val)
+		return ret_val;
+
+	phy_ctrl &= ~(MII_CR_SPEED_MASK | MII_CR_DUPLEX_EN |
+		      MII_CR_AUTO_NEG_EN | MII_CR_RESTART_AUTO_NEG);
+
+	switch (hw->mac.forced_speed_duplex) {
+	case IGC_FORCED_10H:
+		phy_ctrl |= MII_CR_SPEED_10;
+		break;
+	case IGC_FORCED_10F:
+		phy_ctrl |= MII_CR_SPEED_10 | MII_CR_DUPLEX_EN;
+		break;
+	case IGC_FORCED_100H:
+		phy_ctrl |= MII_CR_SPEED_100;
+		break;
+	case IGC_FORCED_100F:
+		phy_ctrl |= MII_CR_SPEED_100 | MII_CR_DUPLEX_EN;
+		break;
+	default:
+		return -IGC_ERR_CONFIG;
+	}
+
+	ret_val = phy->ops.write_reg(hw, PHY_CONTROL, phy_ctrl);
+	if (ret_val)
+		return ret_val;
+
+	hw->mac.get_link_status = true;
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.h b/drivers/net/ethernet/intel/igc/igc_phy.h
index 832a7e359f18..d37a89174826 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.h
+++ b/drivers/net/ethernet/intel/igc/igc_phy.h
@@ -18,5 +18,6 @@ void igc_power_down_phy_copper(struct igc_hw *hw);
 s32 igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data);
 s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data);
 u16 igc_read_phy_fw_version(struct igc_hw *hw);
+s32 igc_force_speed_duplex(struct igc_hw *hw);
 
 #endif
-- 
2.47.1


