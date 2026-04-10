Return-Path: <netdev+bounces-277294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOvaJVCs2GljgwgAu9opvQ
	(envelope-from <netdev+bounces-277294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 194BB3D39C4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79C3D304C112
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AAE3A4F34;
	Fri, 10 Apr 2026 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPJQApxj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B4355F43
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807378; cv=none; b=m/qSBz5qYCPZ8pvkmdWVEFNhR0HQt/oc5K6vdVQxnlqOZUyf8cR4X6gjomr9okn3Xnu/K4r6UbRnIDs7lZl/+kacJpYVLVrU+or+hXAkjJX164Em5YbzZc41a6/K9A1jEuqNHRS3MU6klR2n3isiGCxfoSrmYTRfm3dM+bfYJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807378; c=relaxed/simple;
	bh=Tl3EkNAWXZS7VSusaCuL0Eb4xS+3persYVF/W/GWM1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsOeuni6+vX9wBu7a+k/6RdIMk0wsAgJB4x5B1MHUslQaBB1kN5iCjoPfngoZg4rsTaIsaKtmUIE/YKyCZC/vFf7GuaX33KShYWaeZiTMhDQPhLmN11mX//nMXU5MOym0R/ZMv/FeTZkNb2g4OHR9NDHdDZei37bGxvoAxRB9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPJQApxj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775807377; x=1807343377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tl3EkNAWXZS7VSusaCuL0Eb4xS+3persYVF/W/GWM1w=;
  b=hPJQApxj0ob/wlnkioW41Mvu9tT68OjvOk7kjQ8fHMHTpkjqRGFGAEUT
   22Wp0B09kDnfPor6jq1v95iWhgpJX+KuOnpUzMBxlIgaKSKfKQPvWHxkc
   uFFk3bjMjECzjJRAhHrnwUmpjRyVQBmfboxBiMZlYkvu+7s6vnp/FTdoQ
   JOtZzNHstyqOolhw6WqBCMl3MCjl8TT1eWMZqkbKP2bjmeDVmdZRrZcyZ
   LlxFLFpiL2JMRYqp2wMiRd7Klllw8FyDKzyBRMQF3RlaUmLZq/4d2OV2C
   JdzM6r6cQmO9aLD1uCEGTypzFKx/gyGh+GCYcjJ39Zr7iAIhu02c09F+j
   g==;
X-CSE-ConnectionGUID: kBXvcS7hTNCooWw5S8nAKw==
X-CSE-MsgGUID: /SCA/6A5SQ60lscDqAH9nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007942"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77007942"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:49:36 -0700
X-CSE-ConnectionGUID: P2JMCbCZRdiv7CpQKluA+g==
X-CSE-MsgGUID: us4bh296TrO2QRq2vlpOcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228941899"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:35 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 8/10] ice: move ice_phy_get_speed_eth56g() from ice_ptp_hw.c to ice_common.c
Date: Fri, 10 Apr 2026 09:49:19 +0200
Message-ID: <20260410074921.1254213-9-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277294-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 194BB3D39C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ice_phy_get_speed_eth56g() is currently a file-local (static)
helper in ice_ptp_hw.c. Future users outside that compilation
unit require access to it.

Move the function to ice_common.c, add a declaration in
ice_common.h, and relocate the enum ice_eth56g_link_spd from
ice_ptp_hw.h to ice_type.h so it is visible to callers of the
new exported function.

Suggested-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 45 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h |  1 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 45 ---------------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 13 ------
 drivers/net/ethernet/intel/ice/ice_type.h   | 13 ++++++
 5 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ce11fea..2cebe4e 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3513,6 +3513,51 @@ u16 ice_get_link_speed_based_on_phy_type(u64 phy_type_low, u64 phy_type_high)
 		return speed_phy_type_high;
 }
 
+/**
+ * ice_phy_get_speed_eth56g - Get link speed based on PHY link type
+ * @li: pointer to link information struct
+ *
+ * Return: simplified ETH56G PHY speed
+ */
+enum ice_eth56g_link_spd ice_phy_get_speed_eth56g(struct ice_link_status *li)
+{
+	u16 speed = ice_get_link_speed_based_on_phy_type(li->phy_type_low,
+							 li->phy_type_high);
+
+	switch (speed) {
+	case ICE_AQ_LINK_SPEED_1000MB:
+		return ICE_ETH56G_LNK_SPD_1G;
+	case ICE_AQ_LINK_SPEED_2500MB:
+		return ICE_ETH56G_LNK_SPD_2_5G;
+	case ICE_AQ_LINK_SPEED_10GB:
+		return ICE_ETH56G_LNK_SPD_10G;
+	case ICE_AQ_LINK_SPEED_25GB:
+		return ICE_ETH56G_LNK_SPD_25G;
+	case ICE_AQ_LINK_SPEED_40GB:
+		return ICE_ETH56G_LNK_SPD_40G;
+	case ICE_AQ_LINK_SPEED_50GB:
+		switch (li->phy_type_low) {
+		case ICE_PHY_TYPE_LOW_50GBASE_SR:
+		case ICE_PHY_TYPE_LOW_50GBASE_FR:
+		case ICE_PHY_TYPE_LOW_50GBASE_LR:
+		case ICE_PHY_TYPE_LOW_50GBASE_KR_PAM4:
+		case ICE_PHY_TYPE_LOW_50G_AUI1_AOC_ACC:
+		case ICE_PHY_TYPE_LOW_50G_AUI1:
+			return ICE_ETH56G_LNK_SPD_50G;
+		default:
+			return ICE_ETH56G_LNK_SPD_50G2;
+		}
+	case ICE_AQ_LINK_SPEED_100GB:
+		if (li->phy_type_high ||
+		    li->phy_type_low == ICE_PHY_TYPE_LOW_100GBASE_SR2)
+			return ICE_ETH56G_LNK_SPD_100G2;
+		else
+			return ICE_ETH56G_LNK_SPD_100G;
+	default:
+		return ICE_ETH56G_LNK_SPD_1G;
+	}
+}
+
 /**
  * ice_update_phy_type
  * @phy_type_low: pointer to the lower part of phy_type
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index e700ac0..cc5cee8 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -342,6 +342,7 @@ ice_aq_get_gpio(struct ice_hw *hw, u16 gpio_ctrl_handle, u8 pin_idx,
 		bool *value, struct ice_sq_cd *cd);
 bool ice_is_100m_speed_supported(struct ice_hw *hw);
 u16 ice_get_link_speed_based_on_phy_type(u64 phy_type_low, u64 phy_type_high);
+enum ice_eth56g_link_spd ice_phy_get_speed_eth56g(struct ice_link_status *li);
 int
 ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
 		    struct ice_sq_cd *cd);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 61c0a0d..54a8afa 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1401,51 +1401,6 @@ static int ice_ptp_write_port_cmd_eth56g(struct ice_hw *hw, u8 port,
 	return 0;
 }
 
-/**
- * ice_phy_get_speed_eth56g - Get link speed based on PHY link type
- * @li: pointer to link information struct
- *
- * Return: simplified ETH56G PHY speed
- */
-static enum ice_eth56g_link_spd
-ice_phy_get_speed_eth56g(struct ice_link_status *li)
-{
-	u16 speed = ice_get_link_speed_based_on_phy_type(li->phy_type_low,
-							 li->phy_type_high);
-
-	switch (speed) {
-	case ICE_AQ_LINK_SPEED_1000MB:
-		return ICE_ETH56G_LNK_SPD_1G;
-	case ICE_AQ_LINK_SPEED_2500MB:
-		return ICE_ETH56G_LNK_SPD_2_5G;
-	case ICE_AQ_LINK_SPEED_10GB:
-		return ICE_ETH56G_LNK_SPD_10G;
-	case ICE_AQ_LINK_SPEED_25GB:
-		return ICE_ETH56G_LNK_SPD_25G;
-	case ICE_AQ_LINK_SPEED_40GB:
-		return ICE_ETH56G_LNK_SPD_40G;
-	case ICE_AQ_LINK_SPEED_50GB:
-		switch (li->phy_type_low) {
-		case ICE_PHY_TYPE_LOW_50GBASE_SR:
-		case ICE_PHY_TYPE_LOW_50GBASE_FR:
-		case ICE_PHY_TYPE_LOW_50GBASE_LR:
-		case ICE_PHY_TYPE_LOW_50GBASE_KR_PAM4:
-		case ICE_PHY_TYPE_LOW_50G_AUI1_AOC_ACC:
-		case ICE_PHY_TYPE_LOW_50G_AUI1:
-			return ICE_ETH56G_LNK_SPD_50G;
-		default:
-			return ICE_ETH56G_LNK_SPD_50G2;
-		}
-	case ICE_AQ_LINK_SPEED_100GB:
-		if (li->phy_type_high ||
-		    li->phy_type_low == ICE_PHY_TYPE_LOW_100GBASE_SR2)
-			return ICE_ETH56G_LNK_SPD_100G2;
-		else
-			return ICE_ETH56G_LNK_SPD_100G;
-	default:
-		return ICE_ETH56G_LNK_SPD_1G;
-	}
-}
 
 /**
  * ice_phy_cfg_parpcs_eth56g - Configure TUs per PAR/PCS clock cycle
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 9bfd3e7..a13256a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -50,19 +50,6 @@ enum eth56g_res_type {
 	NUM_ETH56G_PHY_RES
 };
 
-enum ice_eth56g_link_spd {
-	ICE_ETH56G_LNK_SPD_1G,
-	ICE_ETH56G_LNK_SPD_2_5G,
-	ICE_ETH56G_LNK_SPD_10G,
-	ICE_ETH56G_LNK_SPD_25G,
-	ICE_ETH56G_LNK_SPD_40G,
-	ICE_ETH56G_LNK_SPD_50G,
-	ICE_ETH56G_LNK_SPD_50G2,
-	ICE_ETH56G_LNK_SPD_100G,
-	ICE_ETH56G_LNK_SPD_100G2,
-	NUM_ICE_ETH56G_LNK_SPD /* Must be last */
-};
-
 /**
  * struct ice_phy_reg_info_eth56g - ETH56G PHY register parameters
  * @base_addr: base address for each PHY block
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 1e82f4c..4db235a 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -859,6 +859,19 @@ struct ice_mbx_data {
 #define ICE_PORTS_PER_QUAD	4
 #define ICE_GET_QUAD_NUM(port) ((port) / ICE_PORTS_PER_QUAD)
 
+enum ice_eth56g_link_spd {
+	ICE_ETH56G_LNK_SPD_1G,
+	ICE_ETH56G_LNK_SPD_2_5G,
+	ICE_ETH56G_LNK_SPD_10G,
+	ICE_ETH56G_LNK_SPD_25G,
+	ICE_ETH56G_LNK_SPD_40G,
+	ICE_ETH56G_LNK_SPD_50G,
+	ICE_ETH56G_LNK_SPD_50G2,
+	ICE_ETH56G_LNK_SPD_100G,
+	ICE_ETH56G_LNK_SPD_100G2,
+	NUM_ICE_ETH56G_LNK_SPD /* Must be last */
+};
+
 #define ATQBAL_FLAGS_INTR_IN_PROGRESS	BIT(0)
 
 struct ice_e810_params {
-- 
2.52.0


