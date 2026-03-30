Return-Path: <netdev+bounces-273197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKSuDOSAymnX9QUAu9opvQ
	(envelope-from <netdev+bounces-273197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:55:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B3F35C677
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F8103060805
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641F33D413D;
	Mon, 30 Mar 2026 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wxvm2Q1M"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29C3C3BF5;
	Mon, 30 Mar 2026 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878173; cv=none; b=mSioTexAjgomngAAQ2AJi4IgEDm3wK1H301M8++S9RxdZDh8vGlX6JWFOcv8fe584DcrnD86c/LRbwYDc/wY6A3RG0169n1NSieT1xfXEkPXAo/8LYo3lozcQFIULPv4lhTS3SaktQ3X+3VwrB0EFCoQgX8WosX5XW8FUzlsPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878173; c=relaxed/simple;
	bh=6WyDdf9nV0dqmMqVDTAoyvqS7YdZ1GxP1RZutyBw8yU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXWVisbWTCUTKvc5A7WP6Ors97W022h5LhCATCE2ahIUGEbKBCwFL5hb3SOWnrDH9xPhfHEPLQzquPuQrP2kB4c9WFJqk5ojB5960/lM7THXF/AoympTZHCa+2fUhYAj22e9mAa+8rsHANnzq0CkE+pZQKhuvK1bjfvrdLKNDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wxvm2Q1M; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774878171; x=1806414171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6WyDdf9nV0dqmMqVDTAoyvqS7YdZ1GxP1RZutyBw8yU=;
  b=Wxvm2Q1MoeNOjoVBNtXjaeC3MB9aEBGgz3M8mgLlmVkdDKylGknGUhJB
   8iTCw9hDm1gKLgBVaKz1uV5Mp+34vnfvFBGwPjxu8eeEvCS1mrTtJz7fL
   QuZrDM9R4xyQ92u8bSgJ34LSTqmAXSzKyxp/hCS/iXiWueXZThKM5av5s
   pP4jCnGfvUtBvCOK7UfMBn4t1QBoCEW6UYvLXEvYX2tS7XkPvfD7UseJV
   p/X/xAt3/dM4QchXqnYgOz0+4TAgyvB34dVHEDzoP8PnSldHeiHg1DvW+
   VF5AobMO35vqyNPJ8EnpgZtPsR1zRYcG1H+sGF/VWS880/EcazuVBGc0A
   w==;
X-CSE-ConnectionGUID: 8rpL+xwkQsmCO/TnwCZ14w==
X-CSE-MsgGUID: OnLKcJdzR1a8YPxEZIfTtg==
X-IronPort-AV: E=Sophos;i="6.23,150,1770620400"; 
   d="scan'208";a="222664074"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:42:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 30 Mar 2026 06:42:35 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 30 Mar 2026 06:42:30 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <parthiban.veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <steve.glendinning@shawell.net>,
	<UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH net-next 1/3] net: phy: phy-c45: add OATC10 Sleep/Wakeup support in 10BASE-T1S PHYs
Date: Mon, 30 Mar 2026 19:12:20 +0530
Message-ID: <20260330134222.67597-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
References: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273197-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,shawell.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[parthiban.veerasooran@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	HAS_WP_URI(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,opensig.org:url,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Queue-Id: F1B3F35C677
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add generic Clause 45 helpers to support the Open Alliance TC10
10BASE-T1S Sleep/Wake-up specification. This patch introduces
register definitions for the TC10 sleep/wake status and control
registers and adds generic suspend/resume helpers for
OATC10-compliant PHYs.

The new genphy_c45_oatc10_suspend() helper verifies low-power
capability, caches the current PLCA configuration, and requests entry
into the low-power sleep state. Since all PHY configuration is lost
while sleeping, the PLCA configuration is stored in the phy_device
structure for restoration after wake-up.

The corresponding genphy_c45_oatc10_resume() helper reinitializes the
PHY after wake-up and restores the cached PLCA configuration using
driver callbacks.

Additionally, the PLCA configuration structure is moved into
struct phy_device to allow persistent storage across suspend/resume
cycles.

These helpers allow PHY drivers for TC10 10BASE-T1S devices to
implement sleep and wake-up handling in a consistent way without
duplicating common logic.

Open Alliance TC10 10BASE-T1S Sleep/Wake-up Specification ref:
https://opensig.org/wp-content/uploads/2024/01/TC14_TC10_JWG_10BASE-T1S-Sleep-Wake-up-Specification_1.0_final.pdf

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/mdio-open-alliance.h | 13 ++++
 drivers/net/phy/phy-c45.c            | 82 ++++++++++++++++++++++++++
 include/linux/phy.h                  | 88 +++++++++++++++-------------
 3 files changed, 141 insertions(+), 42 deletions(-)

diff --git a/drivers/net/phy/mdio-open-alliance.h b/drivers/net/phy/mdio-open-alliance.h
index 449d0fb67093..62946be9fb78 100644
--- a/drivers/net/phy/mdio-open-alliance.h
+++ b/drivers/net/phy/mdio-open-alliance.h
@@ -78,6 +78,19 @@
 /* SQI is supported using 3 bits means 8 levels (0-7) */
 #define OATC14_SQI_MAX_LEVEL		7
 
+/* Open Alliance 10BASE-T1S Sleep/Wake-up Registers
+ * Specification:
+ *   "10BASE-T1S Sleep/Wake-up Specification"
+ *   https://opensig.org/wp-content/uploads/2024/01/TC14_TC10_JWG_10BASE-T1S-Sleep-Wake-up-Specification_1.0_final.pdf
+ */
+/* Sleep/Wake-up Status Register */
+#define MDIO_OATC10_WS_STATUS		0xd000
+#define OATC10_WS_STATUS_LPCAP		BIT(15)	/* PM client capability */
+
+/* Sleep/Wake-up Control Register */
+#define MDIO_OATC10_WS_CONTROL		0xd001
+#define OATC10_WS_CONTROL_LPREQ		BIT(15)	/* Request low power */
+
 /* Bus Short/Open Status:
  * 0 0 - no fault; everything is ok. (Default)
  * 0 1 - detected as an open or missing termination(s)
diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index d48aa7231b37..627eaae9e60f 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1832,3 +1832,85 @@ int genphy_c45_oatc14_get_sqi(struct phy_device *phydev)
 	return ret & OATC14_DCQ_SQI_VALUE;
 }
 EXPORT_SYMBOL(genphy_c45_oatc14_get_sqi);
+
+/**
+ * genphy_c45_oatc10_suspend - Suspend OATC10 PHY into low power state
+ * @phydev: PHY device to suspend
+ *
+ * Puts an OATC10 PHY into low power sleep state.
+ *
+ * The function performs the following steps:
+ * 1. Verify low power capability is supported
+ * 2. Cache current PLCA configuration for restoration on wake
+ * 3. Set the low power request bit to enter sleep state
+ *
+ * Return:
+ * * 0 on successful entry to low power state
+ * * -EOPNOTSUPP if PHY doesn't support low power capability
+ * * Negative error code on register read/write failures
+ */
+int genphy_c45_oatc10_suspend(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Check for Low Power capability */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC10_WS_STATUS);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & OATC10_WS_STATUS_LPCAP))
+		return -EOPNOTSUPP;
+
+	/* Cache PLCA settings for later use. These values must be restored when
+	 * the PHY wakes up from the low-power sleep state, as all configured
+	 * settings are lost.
+	 */
+	ret = genphy_c45_plca_get_cfg(phydev, &phydev->plca_cfg);
+	if (ret)
+		return ret;
+
+	phydev->plca_cfg.version = -1;
+
+	if (phydev->state == PHY_UP)
+		/* Put the PHY into low power sleep state */
+		return phy_set_bits_mmd(phydev, MDIO_MMD_VEND2,
+					MDIO_OATC10_WS_CONTROL,
+					OATC10_WS_CONTROL_LPREQ);
+
+	return 0;
+}
+EXPORT_SYMBOL(genphy_c45_oatc10_suspend);
+
+/**
+ * genphy_c45_oatc10_resume - Resume OATC10 PHY from low-power sleep state
+ * @phydev: PHY device to resume
+ *
+ * Resume a PHY from suspend state. When the PHY wakes up from the low-power
+ * sleep state, all configured settings are lost. This function reinitializes
+ * the PHY configuration settings.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int genphy_c45_oatc10_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	if (!phydev->suspended)
+		return 0;
+
+	/* When the PHY wakes up from the low-power sleep state, it needs to be
+	 * reinitialized as all configured settings are lost.
+	 */
+	if (phydev->drv->config_init) {
+		ret = phydev->drv->config_init(phydev);
+		if (ret)
+			return ret;
+	}
+
+	/* Reconfigure the PHY with cached PLCA settings */
+	if (phydev->drv->set_plca_cfg)
+		return phydev->drv->set_plca_cfg(phydev, &phydev->plca_cfg);
+
+	return 0;
+}
+EXPORT_SYMBOL(genphy_c45_oatc10_resume);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5de4b172cd0b..9bee520ac421 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -555,6 +555,48 @@ struct phy_oatc14_sqi_capability {
 	u8 sqiplus_bits;
 };
 
+/**
+ * struct phy_plca_cfg - Configuration of the PLCA (Physical Layer Collision
+ * Avoidance) Reconciliation Sublayer.
+ *
+ * @version: read-only PLCA register map version. -1 = not available. Ignored
+ *   when setting the configuration. Format is the same as reported by the PLCA
+ *   IDVER register (31.CA00). -1 = not available.
+ * @enabled: PLCA configured mode (enabled/disabled). -1 = not available / don't
+ *   set. 0 = disabled, anything else = enabled.
+ * @node_id: the PLCA local node identifier. -1 = not available / don't set.
+ *   Allowed values [0 .. 254]. 255 = node disabled.
+ * @node_cnt: the PLCA node count (maximum number of nodes having a TO). Only
+ *   meaningful for the coordinator (node_id = 0). -1 = not available / don't
+ *   set. Allowed values [1 .. 255].
+ * @to_tmr: The value of the PLCA to_timer in bit-times, which determines the
+ *   PLCA transmit opportunity window opening. See IEEE802.3 Clause 148 for
+ *   more details. The to_timer shall be set equal over all nodes.
+ *   -1 = not available / don't set. Allowed values [0 .. 255].
+ * @burst_cnt: controls how many additional frames a node is allowed to send in
+ *   single transmit opportunity (TO). The default value of 0 means that the
+ *   node is allowed exactly one frame per TO. A value of 1 allows two frames
+ *   per TO, and so on. -1 = not available / don't set.
+ *   Allowed values [0 .. 255].
+ * @burst_tmr: controls how many bit times to wait for the MAC to send a new
+ *   frame before interrupting the burst. This value should be set to a value
+ *   greater than the MAC inter-packet gap (which is typically 96 bits).
+ *   -1 = not available / don't set. Allowed values [0 .. 255].
+ *
+ * A structure containing configuration parameters for setting/getting the PLCA
+ * RS configuration. The driver does not need to implement all the parameters,
+ * but should report what is actually used.
+ */
+struct phy_plca_cfg {
+	int version;
+	int enabled;
+	int node_id;
+	int node_cnt;
+	int to_tmr;
+	int burst_cnt;
+	int burst_tmr;
+};
+
 /**
  * struct phy_device - An instance of a PHY
  *
@@ -655,6 +697,7 @@ struct phy_oatc14_sqi_capability {
  * @shared: Pointer to private data shared by phys in one package
  * @priv: Pointer to driver private data
  * @oatc14_sqi_capability: SQI capability information for OATC14 10Base-T1S PHY
+ * @plca_cfg: Cache PLCA configuration for OATC10 compliance 10Base-T1S PHY
  *
  * interrupts currently only supports enabled or disabled,
  * but could be changed in the future to support enabling
@@ -807,6 +850,7 @@ struct phy_device {
 #endif
 
 	struct phy_oatc14_sqi_capability oatc14_sqi_capability;
+	struct phy_plca_cfg plca_cfg;
 };
 
 /* Generic phy_device::dev_flags */
@@ -858,48 +902,6 @@ enum link_inband_signalling {
 	LINK_INBAND_BYPASS		= BIT(2),
 };
 
-/**
- * struct phy_plca_cfg - Configuration of the PLCA (Physical Layer Collision
- * Avoidance) Reconciliation Sublayer.
- *
- * @version: read-only PLCA register map version. -1 = not available. Ignored
- *   when setting the configuration. Format is the same as reported by the PLCA
- *   IDVER register (31.CA00). -1 = not available.
- * @enabled: PLCA configured mode (enabled/disabled). -1 = not available / don't
- *   set. 0 = disabled, anything else = enabled.
- * @node_id: the PLCA local node identifier. -1 = not available / don't set.
- *   Allowed values [0 .. 254]. 255 = node disabled.
- * @node_cnt: the PLCA node count (maximum number of nodes having a TO). Only
- *   meaningful for the coordinator (node_id = 0). -1 = not available / don't
- *   set. Allowed values [1 .. 255].
- * @to_tmr: The value of the PLCA to_timer in bit-times, which determines the
- *   PLCA transmit opportunity window opening. See IEEE802.3 Clause 148 for
- *   more details. The to_timer shall be set equal over all nodes.
- *   -1 = not available / don't set. Allowed values [0 .. 255].
- * @burst_cnt: controls how many additional frames a node is allowed to send in
- *   single transmit opportunity (TO). The default value of 0 means that the
- *   node is allowed exactly one frame per TO. A value of 1 allows two frames
- *   per TO, and so on. -1 = not available / don't set.
- *   Allowed values [0 .. 255].
- * @burst_tmr: controls how many bit times to wait for the MAC to send a new
- *   frame before interrupting the burst. This value should be set to a value
- *   greater than the MAC inter-packet gap (which is typically 96 bits).
- *   -1 = not available / don't set. Allowed values [0 .. 255].
- *
- * A structure containing configuration parameters for setting/getting the PLCA
- * RS configuration. The driver does not need to implement all the parameters,
- * but should report what is actually used.
- */
-struct phy_plca_cfg {
-	int version;
-	int enabled;
-	int node_id;
-	int node_cnt;
-	int to_tmr;
-	int burst_cnt;
-	int burst_tmr;
-};
-
 /**
  * struct phy_plca_status - Status of the PLCA (Physical Layer Collision
  * Avoidance) Reconciliation Sublayer.
@@ -2333,6 +2335,8 @@ int genphy_c45_oatc14_cable_test_get_status(struct phy_device *phydev,
 					    bool *finished);
 int genphy_c45_oatc14_get_sqi_max(struct phy_device *phydev);
 int genphy_c45_oatc14_get_sqi(struct phy_device *phydev);
+int genphy_c45_oatc10_suspend(struct phy_device *phydev);
+int genphy_c45_oatc10_resume(struct phy_device *phydev);
 
 /* The gen10g_* functions are the old Clause 45 stub */
 int gen10g_config_aneg(struct phy_device *phydev);
-- 
2.34.1


