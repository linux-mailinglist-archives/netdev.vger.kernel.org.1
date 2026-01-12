Return-Path: <netdev+bounces-249048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B48FD13192
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52FA830AA6D0
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81FD25A659;
	Mon, 12 Jan 2026 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJX3B44m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8F25B1FC
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227524; cv=none; b=t8/I9gaJNvSXihAzi8IKVH18MPm6RYWdjfh1lMl++FNAycHaU7T05+aDGfy/VWxsWqRKIUN2GXyVa2LluLh25lyQ/OHJ32bYHUAZe+hdDKhH+iEy30rOfxOsUPGt5aYvH9fgFBLuWlcIZSL+ozaFC5IObEy3WBKNIOvfK7Rzuz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227524; c=relaxed/simple;
	bh=Db2Hdgge48JGuy8qCHZIzSL/1URNsiaA8fMzQrcP3v8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B0uJnITXn7ayHoEvlm2qNx7oLPirpdQAVsK+2VPXoCBEgUkJclsCTa2ozkxhRV9fKUKQCf/Xah2usAcSK9Feyi4PFAskPyisWlyfcIHW+ZLAPoDkjMfZGIILImRcJspAqLgjufApV6m4yUfDxbVBBSOJbT1J9rKKuRlcp1gLMQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJX3B44m; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768227523; x=1799763523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Db2Hdgge48JGuy8qCHZIzSL/1URNsiaA8fMzQrcP3v8=;
  b=CJX3B44mqkhK18u4+uCzCXCNYSZxstwiLAP6dAXRwzZz+8M3UvP39RPk
   f8u96cF/wLigwRZxfRb4Ylby8zeXuoWcqBvsk2roB/b7cGJ8J+d1s8Xz/
   tRomEvupKzP/GKRmY9RXjEsQsqyLxhOyZCw+2hCGb40sulAOqumLpdfSf
   ba8CEmJmwe+JM2c0f7xWuIWuvR9f4s1dl91NQSbwsyYbEgJIRey8n5VMZ
   50T1M1aXQx3HxBMCyAcaml1YYQ6mj4sCwrWPDJmfRqstr3HNIIs9S0ITG
   6CQiO2A7bmddtNlEjkdEz3LUcMbvGqtz+U110u4BKyccKl3wwroQiZc7X
   Q==;
X-CSE-ConnectionGUID: HDfJnrOxSD2rPGJinm3sow==
X-CSE-MsgGUID: Wt3k3jv3SaCR8hvkBxC4Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73352289"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73352289"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 06:18:43 -0800
X-CSE-ConnectionGUID: L5T3XLv2S5CaZ+BxoaWxJg==
X-CSE-MsgGUID: ToUo+3LAQ02ZhbFnMXf90g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="227355638"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jan 2026 06:18:42 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 4/7] ixgbe: E610: update ACI command structs with EEE fields
Date: Mon, 12 Jan 2026 15:01:05 +0100
Message-Id: <20260112140108.1173835-5-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were recent changes in some of the ACI commands,
which have been extended with EEE related fields.
Set PHY Config, Get PHY Caps and Get Link Info have been
affected.

Align SW structs to the recent FW changes.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c    |  2 ++
 .../net/ethernet/intel/ixgbe/ixgbe_type_e610.h   | 16 +++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index bd0345ae863a..6818504a25f6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1076,6 +1076,7 @@ void ixgbe_copy_phy_caps_to_cfg(struct ixgbe_aci_cmd_get_phy_caps_data *caps,
 	cfg->link_fec_opt = caps->link_fec_options;
 	cfg->module_compliance_enforcement =
 		caps->module_compliance_enforcement;
+	cfg->eee_entry_delay = caps->eee_entry_delay;
 }
 
 /**
@@ -1404,6 +1405,7 @@ int ixgbe_aci_get_link_info(struct ixgbe_hw *hw, bool ena_lse,
 	li->topo_media_conflict = link_data.topo_media_conflict;
 	li->pacing = link_data.cfg & (IXGBE_ACI_CFG_PACING_M |
 				      IXGBE_ACI_CFG_PACING_TYPE_M);
+	li->eee_status = link_data.eee_status;
 
 	/* Update fc info. */
 	tx_pause = !!(link_data.an_info & IXGBE_ACI_LINK_PAUSE_TX);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index e790974bc3d3..5622ba0c7acb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -323,10 +323,8 @@ struct ixgbe_aci_cmd_get_phy_caps_data {
 #define IXGBE_ACI_PHY_EEE_EN_100BASE_TX			BIT(0)
 #define IXGBE_ACI_PHY_EEE_EN_1000BASE_T			BIT(1)
 #define IXGBE_ACI_PHY_EEE_EN_10GBASE_T			BIT(2)
-#define IXGBE_ACI_PHY_EEE_EN_1000BASE_KX		BIT(3)
-#define IXGBE_ACI_PHY_EEE_EN_10GBASE_KR			BIT(4)
-#define IXGBE_ACI_PHY_EEE_EN_25GBASE_KR			BIT(5)
-#define IXGBE_ACI_PHY_EEE_EN_10BASE_T			BIT(11)
+#define IXGBE_ACI_PHY_EEE_EN_5GBASE_T			BIT(11)
+#define IXGBE_ACI_PHY_EEE_EN_2_5GBASE_T			BIT(12)
 	__le16 eeer_value;
 	u8 phy_id_oui[4]; /* PHY/Module ID connected on the port */
 	u8 phy_fw_ver[8];
@@ -356,7 +354,9 @@ struct ixgbe_aci_cmd_get_phy_caps_data {
 #define IXGBE_ACI_MOD_TYPE_BYTE2_SFP_PLUS		0xA0
 #define IXGBE_ACI_MOD_TYPE_BYTE2_QSFP_PLUS		0x86
 	u8 qualified_module_count;
-	u8 rsvd2[7];	/* Bytes 47:41 reserved */
+	u8 rsvd2;
+	__le16 eee_entry_delay;
+	u8 rsvd3[4];
 #define IXGBE_ACI_QUAL_MOD_COUNT_MAX			16
 	struct {
 		u8 v_oui[3];
@@ -512,8 +512,9 @@ struct ixgbe_aci_cmd_get_link_status_data {
 #define IXGBE_ACI_LINK_SPEED_200GB		BIT(11)
 #define IXGBE_ACI_LINK_SPEED_UNKNOWN		BIT(15)
 	__le16 reserved3;
-	u8 ext_fec_status;
-#define IXGBE_ACI_LINK_RS_272_FEC_EN	BIT(0) /* RS 272 FEC enabled */
+	u8 eee_status;
+#define IXGBE_ACI_LINK_EEE_ENABLED		BIT(2)
+#define IXGBE_ACI_LINK_EEE_ACTIVE		BIT(3)
 	u8 reserved4;
 	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
 	__le64 phy_type_high; /* Use values from ICE_PHY_TYPE_HIGH_* */
@@ -816,6 +817,7 @@ struct ixgbe_link_status {
 	 * of ixgbe_aci_get_phy_caps structure
 	 */
 	u8 module_type[IXGBE_ACI_MODULE_TYPE_TOTAL_BYTE];
+	u8 eee_status;
 };
 
 /* Common HW capabilities for SW use */
-- 
2.31.1


