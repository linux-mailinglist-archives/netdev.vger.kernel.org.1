Return-Path: <netdev+bounces-251500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAyUHg+ub2nxEwAAu9opvQ
	(envelope-from <netdev+bounces-251500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:32:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1534B479DF
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 264D950C06A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C9143C060;
	Tue, 20 Jan 2026 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieUEk/S1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A143D4FC
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917753; cv=none; b=a1dqVoN/4e/Iy4f2OJyhaPvsMOlH0nRfiIvXjNehpMSs3LyosJUGGTCHe9DgIRKfWQGGk+15dsrRpWRGxUdTaioGgS43W38eFNSKkRvut9nM3mYp9z1A1co08CqOgQ4Zxj2faHlljAIRxeyA0vfVFtPbQkK2NaAHUwL7Ge0WeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917753; c=relaxed/simple;
	bh=z8GGmLTECtep00RZrPAB9c3SqFgALCt0CpHkP7Co8pM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZ15mxavkeQ3Hp53oQzAXdFQQ39OkrwxHefGXZFUWuYO3hRNOsQeBJshk9W9sll13f2V4K+3rqOvrrivSZpDTr9h+wQS71QO0MCwHF3AcK2oAcHSKhGAtPRnJ8/pnX/ws1MC2at5ylF2GsCYtg6i2Attm7ZBnkguIpg8lPonbHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieUEk/S1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768917752; x=1800453752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z8GGmLTECtep00RZrPAB9c3SqFgALCt0CpHkP7Co8pM=;
  b=ieUEk/S1qvEsEeJ4lmZJK3zJcwZj2EIj8mguk5zdDklW1LlgrbzE/wvl
   JtmatbyimIwpN0E5qx/J0aDEgM2E6/mtnqTyfzS4/z3Dmeh2IUMR/lDK+
   bbC5TJSvlUPs0bllWSwJ134z4jzvcKn2UXOQdozc0L1l94cnmqANaId98
   bvFVscMfp3wjoyHmQ+VQzhXaIVKQg0zfYzHdDuOvoeLlpJOSjAusOXApo
   1sGdE0W0IaD1kTZHyu+04j/cfPfDThS2MiMnygH95z4ADJBuzgQigqcjB
   Jf0K10ODf0jZ7uE/Ld4LOrLcEMq2DvEj/0PsmpWpHpf2nOvKcJ7AbEufw
   Q==;
X-CSE-ConnectionGUID: 887ZJ9nhTJy8RUPzOk/vTw==
X-CSE-MsgGUID: ox5AzxBvSfeLPbwCGjKfbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="72711775"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="72711775"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:02:32 -0800
X-CSE-ConnectionGUID: aIUAD6DzTq6dCAQ/dscZKw==
X-CSE-MsgGUID: NIskrWJ3Thev5t2zVPzy7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210978940"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 06:02:30 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 4/6] ixgbe: E610: update ACI command structs with EEE fields
Date: Tue, 20 Jan 2026 14:44:32 +0100
Message-Id: <20260120134434.1931602-5-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
References: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251500-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1534B479DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 289a04183e03..8a3d8000a79c 100644
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
index db62281c9413..ea305863ba1b 100644
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


