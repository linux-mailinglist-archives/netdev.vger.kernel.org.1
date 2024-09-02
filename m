Return-Path: <netdev+bounces-124224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CDB968A13
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF948B223BC
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2663E2139DF;
	Mon,  2 Sep 2024 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wTnfDUYs"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802619F10D;
	Mon,  2 Sep 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287742; cv=none; b=TdRcX3+FV2QNFHCJ1I80uEs2u0vPogtMVKz7P1KNVCMVZqwboRe4RmIZnjm7nT1sZHPqqaSnp/DnYPURBIEmwYjkGDd1D4E034KVUuHNQYiN7XyT8RdTIRlRsshlB8D93lpT/cAnwECHsr9BiPMt991LS0YuL6hAyL9Mot9/mHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287742; c=relaxed/simple;
	bh=B7HIRP88K/8mjF5MdEEtNAGe3d9MWhEFanHflKsGIgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdlUkDb+nZ/ruujxOflaI8mpXW1oEVnNtJ0Xr/C3jxADriUxmiep1oWoDTa3gtueAEEqCCVTGiUjO+BGU+AIhXptS59NUMF8pcognudzpcPz+Rwq6P/6MBjeTmpfgNqxnXLvqlcjfjgTh8vjTQDk14/bRnDbvC1Vccg8uNwpYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wTnfDUYs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725287740; x=1756823740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B7HIRP88K/8mjF5MdEEtNAGe3d9MWhEFanHflKsGIgA=;
  b=wTnfDUYstNF3BYPPxCoVQwHhpFF9mm587aLcB1q7nokZlbszBbCorW3S
   mMAaOBXX3HVZ9FcP1QkS4ho5diBNgeHvpT22roorMuQR6wS0M4rFQagjI
   HDi5Nkqems4Gv4KbYNobssG+r0Hbp+0oFbd/yshxv5KSD2001aiS0mWpF
   z0+q7SuUameKKldimZZNcdThevNPpYTiBKELEeOFZz44r0plM1sr/qERI
   sCquGAKG8ZpUbpsZLaznCQ8bj4FDf+Jw8IEDah9PumZ6BiwpNIwqEoLlZ
   QrkZNgVRXJaqd4TeK1Gx2MAlwdHv3EvBZC4d/wg97ucHnmKSEkrUO437A
   Q==;
X-CSE-ConnectionGUID: ocGO3RCOTkuOSmOfjK4K+g==
X-CSE-MsgGUID: ZYQnPYmMQ2WeEKDHtwVgPQ==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34270505"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:35:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:35:30 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 07:35:26 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 5/7] net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C1
Date: Mon, 2 Sep 2024 20:04:56 +0530
Message-ID: <20240902143458.601578-6-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch adds support for LAN8670/1/2 Rev.C1 as per the latest
configuration note AN1699 released (Revision E (DS60001699F - June 2024))
https://www.microchip.com/en-us/application-notes/an1699

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/Kconfig         |  2 +-
 drivers/net/phy/microchip_t1s.c | 66 ++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index f18defab70cf..04f605606a8a 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -292,7 +292,7 @@ config MICREL_PHY
 config MICROCHIP_T1S_PHY
 	tristate "Microchip 10BASE-T1S Ethernet PHYs"
 	help
-	  Currently supports the LAN8670/1/2 Rev.B1 and LAN8650/1 Rev.B0/B1
+	  Currently supports the LAN8670/1/2 Rev.B1/C1 and LAN8650/1 Rev.B0/B1
 	  Internal PHYs.
 
 config MICROCHIP_PHY
diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 5d133261dd69..62f5ce548c6a 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -3,7 +3,7 @@
  * Driver for Microchip 10BASE-T1S PHYs
  *
  * Support: Microchip Phys:
- *  lan8670/1/2 Rev.B1
+ *  lan8670/1/2 Rev.B1/C1
  *  lan8650/1 Rev.B0/B1 Internal PHYs
  */
 
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 
 #define PHY_ID_LAN867X_REVB1 0x0007C162
+#define PHY_ID_LAN867X_REVC1 0x0007C164
 /* Both Rev.B0 and B1 clause 22 PHYID's are same due to B1 chip limitation */
 #define PHY_ID_LAN865X_REVB 0x0007C1B3
 
@@ -290,6 +291,58 @@ static int lan867x_check_reset_complete(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan867x_revc1_config_init(struct phy_device *phydev)
+{
+	s8 offsets[2];
+	int ret;
+
+	ret = lan867x_check_reset_complete(phydev);
+	if (ret)
+		return ret;
+
+	ret = lan865x_generate_cfg_offsets(phydev, offsets);
+	if (ret)
+		return ret;
+
+	/* LAN867x Rev.C1 configuration settings are equal to the first 9
+	 * configuration settings and all the sqi fixup settings from LAN865x
+	 * Rev.B0/B1. So the same fixup registers and values from LAN865x
+	 * Rev.B0/B1 are used for LAN867x Rev.C1 to avoid duplication.
+	 * Refer the below links for the comparision.
+	 * https://www.microchip.com/en-us/application-notes/an1760
+	 * Revision F (DS60001760G - June 2024)
+	 * https://www.microchip.com/en-us/application-notes/an1699
+	 * Revision E (DS60001699F - June 2024)
+	 */
+	for (int i = 0; i < 9; i++) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+				    lan865x_revb_fixup_registers[i],
+				    lan865x_revb_fixup_values[i]);
+		if (ret)
+			return ret;
+
+		if (i == 1) {
+			ret = lan865x_setup_cfgparam(phydev, offsets);
+			if (ret)
+				return ret;
+		}
+	}
+
+	ret = lan865x_setup_sqi_cfgparam(phydev, offsets);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < ARRAY_SIZE(lan865x_revb_sqi_fixup_regs); i++) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+				    lan865x_revb_sqi_fixup_regs[i],
+				    lan865x_revb_sqi_fixup_values[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int lan867x_revb1_config_init(struct phy_device *phydev)
 {
 	int err;
@@ -342,6 +395,16 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1),
+		.name               = "LAN867X Rev.C1",
+		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.config_init        = lan867x_revc1_config_init,
+		.read_status        = lan86xx_read_status,
+		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
+		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.get_plca_status    = genphy_c45_plca_get_status,
+	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
 		.name               = "LAN865X Rev.B0/B1 Internal Phy",
@@ -358,6 +421,7 @@ module_phy_driver(microchip_t1s_driver);
 
 static struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB) },
 	{ }
 };
-- 
2.34.1


