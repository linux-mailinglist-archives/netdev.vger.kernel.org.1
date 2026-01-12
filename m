Return-Path: <netdev+bounces-249046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F342FD13136
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08B04300BFAF
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5BB252292;
	Mon, 12 Jan 2026 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlWJ706p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855D25D1E9
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227523; cv=none; b=oa+m6EqX09sPFIsfNzeqldMI+9dyvbyjPDm4kVq+wg59rMKPFQyszhRUVyCMeRffh/slqUJFQQddFgg/hYHhEn4rhWGhxP052RO6LeoK09tT8WP145hsB9ZztVVakSRQnlEijRRCEfjQG9BnTGoUqIIdvXjJEkNoSMRFitqkoZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227523; c=relaxed/simple;
	bh=WiCA5KWXATI3ZzkvYpNlDieIhtSPhjJAOOUIJgDP6BU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UAEL9DAiczmtJBCUdZ7uSLUBD6orfrM73vEeiMjUD+ImDS+n3s6Icrtt21vkW7O9LQHWv9/UOC3u+kslTOx1UY8M363Y6fFgXRMLImggrz765jx3/LHvs2IAJ/Fi9eOgbpSbq26FhTA/Y2HhSUU3A1iM2s21C1VfY6m8fgqbQSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlWJ706p; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768227520; x=1799763520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WiCA5KWXATI3ZzkvYpNlDieIhtSPhjJAOOUIJgDP6BU=;
  b=DlWJ706pCGMInkwnYYKxcDxrtl7GKa3gIHvYS+j8ajGBmpA4i2EbIU67
   x0iPr6EXDWHu7Xp+X32bUKT78EaKqfHsveiyObb2fYCU/Pcc0aMxGyMmY
   vbSO0A+wVzqRDAV+aj3YeDNbUVud8W7YVKjypMjSiIxeI60RswBHGmRjp
   vsBBOWA8tsWPcst7k1pvSMByvUCo9Aw09xfEq3t8aTxbAyUk2FZK1X2ZP
   lfNRAZe1BgBjaupIs3/HQksEGMNk1Oaczxagg9dQJx7joZtvFIS584l/x
   2g1vCvZzLREeSME32kPyqLgqZqeBaioXKjL6eGG1sED1UQKBxDWfDana8
   Q==;
X-CSE-ConnectionGUID: G7JWkXq1RAyWi2DedWOYHQ==
X-CSE-MsgGUID: tvEGqKIuSUi13uzYzYXbGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73352283"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73352283"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 06:18:40 -0800
X-CSE-ConnectionGUID: wOZCr0P8QWyFatxfp3FLeA==
X-CSE-MsgGUID: H55u1D9+R1+RKmvOYlnQ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="227355630"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jan 2026 06:18:39 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v1 2/7] ixgbe: E610: use new version of 0x601 ACI command buffer
Date: Mon, 12 Jan 2026 15:01:03 +0100
Message-Id: <20260112140108.1173835-3-jedrzej.jagielski@intel.com>
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

Since FW version 1.40, buffer size of the 0x601 cmd has been increased
by 2B - from 24 to 26B. Buffer has been extended with new field
which can be used to configure EEE entry delay.

Pre-1.40 FW versions still expect 24B buffer and throws error when
receipts 26B buffer. To keep compatibility, check whether EEE
device capability flag is set and basing on it use appropriate
size of the command buffer.

Additionally place Set PHY Config capabilities defines out of
structs definitions.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c   | 17 ++++++++++++++++-
 .../net/ethernet/intel/ixgbe/ixgbe_type_e610.h  | 15 +++++++++------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 98982d3d87c7..71409a0ac2fe 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1096,11 +1096,16 @@ int ixgbe_aci_set_phy_cfg(struct ixgbe_hw *hw,
 {
 	struct ixgbe_aci_cmd_set_phy_cfg *cmd;
 	struct libie_aq_desc desc;
+	bool use_buff_eee_field;
+	u16 buf_size;
 	int err;
 
 	if (!cfg)
 		return -EINVAL;
 
+	/* If FW supports EEE, we have to use buffer with EEE field. */
+	use_buff_eee_field = hw->dev_caps.common_cap.eee_support;
+
 	cmd = libie_aq_raw(&desc);
 	/* Ensure that only valid bits of cfg->caps can be turned on. */
 	cfg->caps &= IXGBE_ACI_PHY_ENA_VALID_MASK;
@@ -1109,7 +1114,17 @@ int ixgbe_aci_set_phy_cfg(struct ixgbe_hw *hw,
 	cmd->lport_num = hw->bus.func;
 	desc.flags |= cpu_to_le16(LIBIE_AQ_FLAG_RD);
 
-	err = ixgbe_aci_send_cmd(hw, &desc, cfg, sizeof(*cfg));
+	if (use_buff_eee_field)
+		buf_size = sizeof(*cfg);
+	else
+		/* Buffer w/o eee_entry_delay field is 2B smaller. */
+		buf_size = sizeof(*cfg) - sizeof(u16);
+
+	err = ixgbe_aci_send_cmd(hw, &desc, cfg, buf_size);
+
+	/* 1.40 config format is compatible with pre-1.40, just extends
+	 * it at the end.
+	 */
 	if (!err)
 		hw->phy.curr_user_phy_cfg = *cfg;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 767d04a3f106..e790974bc3d3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -382,6 +382,15 @@ struct ixgbe_aci_cmd_set_phy_cfg_data {
 	__le64 phy_type_low; /* Use values from IXGBE_PHY_TYPE_LOW_* */
 	__le64 phy_type_high; /* Use values from IXGBE_PHY_TYPE_HIGH_* */
 	u8 caps;
+	u8 low_power_ctrl_an;
+	__le16 eee_cap; /* Value from ixgbe_aci_get_phy_caps */
+	__le16 eeer_value; /* Use defines from ixgbe_aci_get_phy_caps */
+	u8 link_fec_opt; /* Use defines from ixgbe_aci_get_phy_caps */
+	u8 module_compliance_enforcement;
+	__le16  eee_entry_delay;
+} __packed;
+
+/* Set PHY config capabilities (@caps) defines */
 #define IXGBE_ACI_PHY_ENA_VALID_MASK		0xef
 #define IXGBE_ACI_PHY_ENA_TX_PAUSE_ABILITY	BIT(0)
 #define IXGBE_ACI_PHY_ENA_RX_PAUSE_ABILITY	BIT(1)
@@ -390,12 +399,6 @@ struct ixgbe_aci_cmd_set_phy_cfg_data {
 #define IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT	BIT(5)
 #define IXGBE_ACI_PHY_ENA_LESM			BIT(6)
 #define IXGBE_ACI_PHY_ENA_AUTO_FEC		BIT(7)
-	u8 low_power_ctrl_an;
-	__le16 eee_cap; /* Value from ixgbe_aci_get_phy_caps */
-	__le16 eeer_value; /* Use defines from ixgbe_aci_get_phy_caps */
-	u8 link_fec_opt; /* Use defines from ixgbe_aci_get_phy_caps */
-	u8 module_compliance_enforcement;
-};
 
 /* Restart AN command data structure (direct 0x0605)
  * Also used for response, with only the lport_num field present.
-- 
2.31.1


