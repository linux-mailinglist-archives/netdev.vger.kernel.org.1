Return-Path: <netdev+bounces-161253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E523A2035B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 04:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FEF3A6E73
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 03:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D9D194A65;
	Tue, 28 Jan 2025 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kxqKWIXb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FB2D7BF;
	Tue, 28 Jan 2025 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738035180; cv=none; b=TmqjIOhuaiZkTCFGvngwr1IZkkWpz+HDGM0x/mIj4jG44cYG5WfOv/J5+MTM80nzNEqEAdJxOsoFLtKWX7EuhP/VzOcbuNCbSvZt1WvyYHABx338FwY9OanOovvIy2DFnuoYPmeElNWCEkw2neKQAEVzuWFFx3Sm3FZxBD8oKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738035180; c=relaxed/simple;
	bh=foJVYt7U2pEqFvH+p/Uu8vcGX+mnNGY1pT32pTUtXvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtDDWC9NQ58MuUwivHKIPEm+zhhrvDS1TvvOI79HgLct9WljSwchKE65FsLMNZPSj7n1jGBggcVTz7ztrC+MrmlQyJobsYsd0rSS+npDdP4P597qTtHAJV8s8m6nPAu02Zkvf1w9R2JXMR2+Ksk0FoLUp3NDgVHUoOFIepfU/Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kxqKWIXb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738035179; x=1769571179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=foJVYt7U2pEqFvH+p/Uu8vcGX+mnNGY1pT32pTUtXvU=;
  b=kxqKWIXbsLLQst8hoBR+/08o/ssj3AREkeC4u0TKFHXadbzdUZeXv7US
   I3Xw+6bKQrwx1kQlOMMYW6c0LhjRNZY27m1W+liRjjCfKYy5TsOEBAKWM
   BigX/uWk/uJaic4X7FLup9nuGJ1tQwaZKkrVkaaxmGEU1fB/Ed7LWh5he
   WdNsCZP6rl/Ex9dGUTGbE3PwBQ3gB2Fic52mGMBqK2cg3FgseHQnTQOa5
   S7VPWeV0rTK8/a/AKt5tQp0r2N/okmDIXCDxkBtqJ80bLoIc3nfIPNLMi
   iedbJgqBaWtWy9CZFGMno1AIga8nQCYJcmB/ZQ8xezuVwAPFgl3MV7D0p
   g==;
X-CSE-ConnectionGUID: YiGSDTCPSFu7LwZMtoWv2g==
X-CSE-MsgGUID: Lue6LmkjSDK9t59CJdokCA==
X-IronPort-AV: E=Sophos;i="6.13,240,1732604400"; 
   d="scan'208";a="204506389"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2025 20:32:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 Jan 2025 20:32:15 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 27 Jan 2025 20:32:15 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Date: Mon, 27 Jan 2025 19:32:25 -0800
Message-ID: <20250128033226.70866-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128033226.70866-1-Tristram.Ha@microchip.com>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

It was recommended to use this XPCS driver for Microchip KSZ9477 switch
to operate its SGMII port as the SGMII implementation uses the same
Synopsys DesignWare IP, but current code does not work in some cases.
The only solution is to add a quirk field and use that to operate KSZ
specific code.

For 1000BaseX mode setting neg_mode to false works, but that does not
work for SGMII mode.  Setting 0x18 value in register 0x1f8001 allows
1000BaseX mode to work with auto-negotiation enabled.

However SGMII mode in KSZ9477 has a bug in which the current speed
needs to be set in MII_BMCR to pass traffic.  The current driver code
does not do anything when link is up with auto-negotiation enabled, so
that code needs to be changed for KSZ9477.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/pcs/pcs-xpcs.c   | 52 ++++++++++++++++++++++++++++++++++--
 drivers/net/pcs/pcs-xpcs.h   |  2 ++
 include/linux/pcs/pcs-xpcs.h |  6 +++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 1faa37f0e7b9..ddf6cd4b37a7 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -768,6 +768,14 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 		val |= DW_VR_MII_AN_INTR_EN;
 	}
 
+	if (xpcs->quirk == DW_XPCS_QUIRK_MICROCHIP_KSZ &&
+	    neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+		mask |= DW_VR_MII_SGMII_LINK_STS | DW_VR_MII_TX_CONFIG_MASK;
+		val |= FIELD_PREP(DW_VR_MII_TX_CONFIG_MASK,
+				  DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII);
+		val |= DW_VR_MII_SGMII_LINK_STS;
+	}
+
 	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, mask, val);
 	if (ret < 0)
 		return ret;
@@ -982,6 +990,15 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
+	/* DW_VR_MII_AN_STS_C37_ANCMPLT_INTR just means link change in SGMII
+	 * mode, so needs to be cleared.  It can appear just by itself, which
+	 * does not mean the link is up.
+	 */
+	if (xpcs->quirk == DW_XPCS_QUIRK_MICROCHIP_KSZ &&
+	    (ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR)) {
+		ret &= ~DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
+		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
+	}
 	if (ret & DW_VR_MII_C37_ANSGM_SP_LNKSTS) {
 		int speed_value;
 
@@ -1037,6 +1054,18 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
 {
 	int lpa, bmsr;
 
+	/* DW_VR_MII_AN_STS_C37_ANCMPLT_INTR just means link change, so needs
+	 * to be cleared.  If polling is not used then it is cleared by
+	 * following code.
+	 */
+	if (xpcs->quirk == DW_XPCS_QUIRK_MICROCHIP_KSZ && xpcs->pcs.poll) {
+		int val;
+
+		val = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS);
+		if (val & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR)
+			xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS,
+				   0);
+	}
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			      state->advertising)) {
 		/* Reset link state */
@@ -1138,9 +1167,14 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 					 phy_interface_t interface,
 					 int speed, int duplex)
 {
+	u16 val = 0;
 	int ret;
 
-	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+	/* Microchip KSZ SGMII implementation has a bug that needs MII_BMCR
+	 * register to be updated with current speed to pass traffic.
+	 */
+	if (xpcs->quirk != DW_XPCS_QUIRK_MICROCHIP_KSZ &&
+	    neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 		return;
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
@@ -1155,10 +1189,18 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 			dev_err(&xpcs->mdiodev->dev,
 				"%s: half duplex not supported\n",
 				__func__);
+
+		/* No need to update MII_BMCR register if not in SGMII mode. */
+		if (xpcs->quirk == DW_XPCS_QUIRK_MICROCHIP_KSZ &&
+		    neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+			return;
 	}
 
+	if (xpcs->quirk == DW_XPCS_QUIRK_MICROCHIP_KSZ &&
+	    neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		val = BMCR_ANENABLE;
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
-			 mii_bmcr_encode_fixed(speed, duplex));
+			 val | mii_bmcr_encode_fixed(speed, duplex));
 	if (ret)
 		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_write returned %pe\n",
 			__func__, ERR_PTR(ret));
@@ -1563,5 +1605,11 @@ void xpcs_destroy_pcs(struct phylink_pcs *pcs)
 }
 EXPORT_SYMBOL_GPL(xpcs_destroy_pcs);
 
+void xpcs_set_quirk(struct dw_xpcs *xpcs, int quirk)
+{
+	xpcs->quirk = quirk;
+}
+EXPORT_SYMBOL_GPL(xpcs_set_quirk);
+
 MODULE_DESCRIPTION("Synopsys DesignWare XPCS library");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index adc5a0b3c883..1348a9a05ca6 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -73,6 +73,7 @@
 
 /* VR_MII_AN_CTRL */
 #define DW_VR_MII_AN_CTRL_8BIT			BIT(8)
+#define DW_VR_MII_SGMII_LINK_STS		BIT(4)
 #define DW_VR_MII_TX_CONFIG_MASK		BIT(3)
 #define DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII	0x1
 #define DW_VR_MII_TX_CONFIG_MAC_SIDE_SGMII	0x0
@@ -122,6 +123,7 @@ struct dw_xpcs {
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
 	bool need_reset;
+	int quirk;
 };
 
 int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg);
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 733f4ddd2ef1..7fccbff2383d 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -41,6 +41,10 @@ enum dw_xpcs_pma_id {
 	WX_TXGBE_XPCS_PMA_10G_ID = 0x0018fc80,
 };
 
+enum dw_xpcs_quirks {
+	DW_XPCS_QUIRK_MICROCHIP_KSZ = 1,
+};
+
 struct dw_xpcs_info {
 	u32 pcs;
 	u32 pma;
@@ -59,4 +63,6 @@ void xpcs_destroy(struct dw_xpcs *xpcs);
 struct phylink_pcs *xpcs_create_pcs_mdiodev(struct mii_bus *bus, int addr);
 void xpcs_destroy_pcs(struct phylink_pcs *pcs);
 
+void xpcs_set_quirk(struct dw_xpcs *xpcs, int quirk);
+
 #endif /* __LINUX_PCS_XPCS_H */
-- 
2.34.1


