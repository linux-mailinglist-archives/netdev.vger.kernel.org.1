Return-Path: <netdev+bounces-231095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91853BF4E3D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FCB850160A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 07:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4962773D8;
	Tue, 21 Oct 2025 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wBGzEkyZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE92765DF;
	Tue, 21 Oct 2025 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030638; cv=none; b=j+eD7yfYUKrUAJtvw06JQuKFydZLwUKUJS+d/v44XIeAgVu3409sMrCoubvezIpBq7d6mwYYFSI2dCo7Eb4cFpnC2KWEP4+eoYcD/qbzBOXOV8dCGHhuVzRhUMS4hCi2X+FeOBxv1eyze8aJaVZxN5PE1ZjZC8H53g4E4fMxWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030638; c=relaxed/simple;
	bh=QJVAHHAkn8DjN7mbBznFDlr0cmLp94neJvA+bm6qe18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=idXp9iw2CiR0vj3HumT2CyPqLJ9nKLQYt2OqC7p5F9zHmQ4Q5R1RSLIw5Pg/Qs9UeOeEbdO8GAIY9H5+uDrpskbFRYSysnneqmY9GGlTsS3idz2R1CJ5u7bIEkwOfXwOEvJYgUa/S8vGwI2s3rH8pLzu7t7amKdrajRQVfHnQu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wBGzEkyZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761030636; x=1792566636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QJVAHHAkn8DjN7mbBznFDlr0cmLp94neJvA+bm6qe18=;
  b=wBGzEkyZGAut+Z8lStVSRJV9/GFh2nySVAj/QycoN8E2Wkuy/hoNNHXN
   ZfKH61xv/XBbBMA/Ae/j/54aEe/JtW7U6zBy7ATuh26bumuzKMtpk9zAH
   yXS0YKI6zMK+ISmAQNglbSZYkCDrQt1gbXcnzup2tPFjw+8N8QfrFYhRJ
   1ww1tMgcu686eX41OegU6YcNL0fX0YkL0zO280Fkmu+1pZrpQ4THzIbQN
   IOc3usloAcmnAzQj+5ELt1oVKDdk6k7dE0CkAzlqYRSD3ALEU7qARaRma
   m4hrI/FVinXQksaBlV3Dg7gHiOyy7mt8L5iAxOaPg3CkKGywivkZ+sl89
   Q==;
X-CSE-ConnectionGUID: L27ecwcOQ5S4FUTyPcNyjw==
X-CSE-MsgGUID: kDU4YAQaQnqZqxkTvZ0Sfw==
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="279421702"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2025 00:09:27 -0700
Received: from chn-vm-ex4.mchp-main.com (10.10.87.33) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 21 Oct 2025 00:08:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Tue, 21 Oct 2025 00:08:56 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 21 Oct 2025 00:08:54 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<gerhard@engleder-embedded.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2] net: phy: micrel: Add support for non PTP SKUs for lan8814
Date: Tue, 21 Oct 2025 09:07:26 +0200
Message-ID: <20251021070726.3690685-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The lan8814 has 4 different SKUs and for 2 of these SKUs the PTP is
disabled. All these SKUs have the same value in the register 2 and 3.
Meaning that we can't differentiate them based on device id, therefore
check the SKU register and based on this allow or not to create a PTP
device.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

---
v1->v2:
- fix commmit message by rephrasing it.
---
 drivers/net/phy/micrel.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 5f2c7e5c314f5..a47e55c228155 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -101,6 +101,8 @@
 #define LAN8814_CABLE_DIAG_VCT_DATA_MASK	GENMASK(7, 0)
 #define LAN8814_PAIR_BIT_SHIFT			12
 
+#define LAN8814_SKUS				0xB
+
 #define LAN8814_WIRE_PAIR_MASK			0xF
 
 /* Lan8814 general Interrupt control/status reg in GPHY specific block. */
@@ -367,6 +369,9 @@
 
 #define LAN8842_REV_8832			0x8832
 
+#define LAN8814_REV_LAN8814			0x8814
+#define LAN8814_REV_LAN8818			0x8818
+
 struct kszphy_hw_stat {
 	const char *string;
 	u8 reg;
@@ -449,6 +454,7 @@ struct kszphy_priv {
 	bool rmii_ref_clk_sel;
 	bool rmii_ref_clk_sel_val;
 	bool clk_enable;
+	bool is_ptp_available;
 	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
 	struct kszphy_phy_stats phy_stats;
 };
@@ -4126,6 +4132,17 @@ static int lan8804_config_intr(struct phy_device *phydev)
 	return 0;
 }
 
+/* Check if the PHY has 1588 support. There are multiple skus of the PHY and
+ * some of them support PTP while others don't support it. This function will
+ * return true is the sku supports it, otherwise will return false.
+ */
+static bool lan8814_has_ptp(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	return priv->is_ptp_available;
+}
+
 static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
 {
 	int ret = IRQ_NONE;
@@ -4142,6 +4159,9 @@ static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
 		ret = IRQ_HANDLED;
 	}
 
+	if (!lan8814_has_ptp(phydev))
+		return ret;
+
 	while (true) {
 		irq_status = lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
 						  PTP_TSU_INT_STS);
@@ -4203,6 +4223,9 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	    !IS_ENABLED(CONFIG_NETWORK_PHY_TIMESTAMPING))
 		return;
 
+	if (!lan8814_has_ptp(phydev))
+		return;
+
 	lanphy_write_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
 			      TSU_HARD_RESET, TSU_HARD_RESET_);
 
@@ -4332,6 +4355,9 @@ static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
 
 static int lan8814_ptp_probe_once(struct phy_device *phydev)
 {
+	if (!lan8814_has_ptp(phydev))
+		return 0;
+
 	return __lan8814_ptp_probe_once(phydev, "lan8814_ptp_pin",
 					LAN8814_PTP_GPIO_NUM);
 }
@@ -4446,6 +4472,18 @@ static int lan8814_probe(struct phy_device *phydev)
 	devm_phy_package_join(&phydev->mdio.dev, phydev,
 			      addr, sizeof(struct lan8814_shared_priv));
 
+	/* There are lan8814 SKUs that don't support PTP. Make sure that for
+	 * those skus no PTP device is created. Here we check if the SKU
+	 * supports PTP.
+	 */
+	err = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				   LAN8814_SKUS);
+	if (err < 0)
+		return err;
+
+	priv->is_ptp_available = err == LAN8814_REV_LAN8814 ||
+				 err == LAN8814_REV_LAN8818;
+
 	if (phy_package_init_once(phydev)) {
 		err = lan8814_release_coma_mode(phydev);
 		if (err)
-- 
2.34.1


