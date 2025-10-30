Return-Path: <netdev+bounces-234335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ECEC1F817
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68821A20E87
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49587350D7B;
	Thu, 30 Oct 2025 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2H0TaDZW"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53218DB26;
	Thu, 30 Oct 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819828; cv=none; b=li8leEfjTmwxTdiz5xblbQ13qVEytpfBaHbAiehYyPJNAi/ZQeBgNYP47Ds5ewkugKzmbkxyuTbDINIp/nxuJlpqeeM/G9zwhyy+MuYkF4kdVqWIwpXSidbIBEsNDs6hzHgN9uMNQZ7cn24nNCAEUOqrlnHJrUK2GFwCErdbg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819828; c=relaxed/simple;
	bh=3V2aV4nPB0UyjK6VToKg9MDzdV9a8nUWRDj7DNXyej0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WErZCcLAPH/hWZ8WjBfb7AMqfLPAwjfa/gtqhFockEUCEUa2h7oJjNdqAX8m9PBREYSXx15qvZ5akj39QnV/+hZsmixUPUVjsUPAk4bZ9cg7dDMpEUzZlIVCejWp9u40PtXfoRCltxamOLCZkYBbG8ep6wS8EIJ2g3TuiqY2klA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2H0TaDZW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761819826; x=1793355826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3V2aV4nPB0UyjK6VToKg9MDzdV9a8nUWRDj7DNXyej0=;
  b=2H0TaDZW1d9T9IEm14nwL5WohmwO7GrtoCgWnU6VDQ6E1QcPDAo/lfvb
   vv3osVPHUHUgxkMsGYXtw9/o9AcTYr1Sp2w2vtO+loTBNEZeUFzMyBFlV
   DhrkJrbRvIiddTWJw6OtqOJA1GSTM0/kfBxCXK+eDrkOVKAuibQBArVRS
   qFZmSjtjNzGJN/iiHzwHAEsCeMr++Edf/nLlbBwfPneiLfvIZ6co4+2A8
   fX6Ch4W3UbLp7EpfpEF/XizUdlBz4epbM4tQCnLfTbC8HEmxSWzKxRfSp
   xMB08h6oAYOBOGcTyMoT8lUJ8gcAxY1Tty+d/FYhKMfvsy3c4YAkYCoBZ
   w==;
X-CSE-ConnectionGUID: HzbPEBY6R+miNabt6yV/EA==
X-CSE-MsgGUID: ENrRBZ2kSBq4dDskuqF/gw==
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="215806960"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 03:23:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 30 Oct 2025 03:23:09 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 30 Oct 2025 03:23:05 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next 1/2] net: phy: microchip_t1s: add support for Microchip LAN867X Rev.D0 PHY
Date: Thu, 30 Oct 2025 15:52:57 +0530
Message-ID: <20251030102258.180061-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030102258.180061-1-parthiban.veerasooran@microchip.com>
References: <20251030102258.180061-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Add support for the LAN8670/1/2 Rev.D0 10BASE-T1S PHYs from Microchip.
The new Rev.D0 silicon requires a specific set of initialization
settings to be configured for optimal performance and compliance with
OPEN Alliance specifications, as described in Microchip Application Note
AN1699 (Revision G, DS60001699G – October 2025).
https://www.microchip.com/en-us/application-notes/an1699

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/Kconfig         |  2 +-
 drivers/net/phy/microchip_t1s.c | 47 ++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 98700d069191..a7ade7b95a2e 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -308,7 +308,7 @@ config MICREL_PHY
 config MICROCHIP_T1S_PHY
 	tristate "Microchip 10BASE-T1S Ethernet PHYs"
 	help
-	  Currently supports the LAN8670/1/2 Rev.B1/C1/C2 and
+	  Currently supports the LAN8670/1/2 Rev.B1/C1/C2/D0 and
 	  LAN8650/1 Rev.B0/B1 Internal PHYs.
 
 config MICROCHIP_PHY
diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index e50a0c102a86..03e3bacb02bd 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -3,7 +3,7 @@
  * Driver for Microchip 10BASE-T1S PHYs
  *
  * Support: Microchip Phys:
- *  lan8670/1/2 Rev.B1/C1/C2
+ *  lan8670/1/2 Rev.B1/C1/C2/D0
  *  lan8650/1 Rev.B0/B1 Internal PHYs
  */
 
@@ -14,6 +14,7 @@
 #define PHY_ID_LAN867X_REVB1 0x0007C162
 #define PHY_ID_LAN867X_REVC1 0x0007C164
 #define PHY_ID_LAN867X_REVC2 0x0007C165
+#define PHY_ID_LAN867X_REVD0 0x0007C166
 /* Both Rev.B0 and B1 clause 22 PHYID's are same due to B1 chip limitation */
 #define PHY_ID_LAN865X_REVB 0x0007C1B3
 
@@ -109,6 +110,21 @@ static const u16 lan865x_revb_sqi_fixup_cfg_regs[3] = {
 	0x00AD, 0x00AE, 0x00AF,
 };
 
+/* LAN867x Rev.D0 configuration parameters from AN1699
+ * As per the Configuration Application Note AN1699 published in the below link,
+ * https://www.microchip.com/en-us/application-notes/an1699
+ * Revision G (DS60001699G - October 2025)
+ */
+static const u16 lan867x_revd0_fixup_regs[8] = {
+	0x0037, 0x008A, 0x0118, 0x00D6,
+	0x0082, 0x00FD, 0x00FD, 0x0091,
+};
+
+static const u16 lan867x_revd0_fixup_values[8] = {
+	0x0800, 0xBFC0, 0x029C, 0x1001,
+	0x001C, 0x0C0B, 0x8C07, 0x9660,
+};
+
 /* Pulled from AN1760 describing 'indirect read'
  *
  * write_register(0x4, 0x00D8, addr)
@@ -407,6 +423,25 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
 			      COL_DET_CTRL0_ENABLE_BIT_MASK, COL_DET_ENABLE);
 }
 
+static int lan867x_revd0_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = lan867x_check_reset_complete(phydev);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < ARRAY_SIZE(lan867x_revd0_fixup_regs); i++) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+				    lan867x_revd0_fixup_regs[i],
+				    lan867x_revd0_fixup_values[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int lan86xx_read_status(struct phy_device *phydev)
 {
 	/* The phy has some limitations, namely:
@@ -481,6 +516,15 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVD0),
+		.name               = "LAN867X Rev.D0",
+		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.config_init        = lan867x_revd0_config_init,
+		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
+		.get_plca_status    = genphy_c45_plca_get_status,
+	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
 		.name               = "LAN865X Rev.B0/B1 Internal Phy",
@@ -501,6 +545,7 @@ static const struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC2) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVD0) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB) },
 	{ }
 };
-- 
2.34.1


