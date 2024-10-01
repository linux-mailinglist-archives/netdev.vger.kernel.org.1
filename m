Return-Path: <netdev+bounces-130856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDECA98BC51
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB4C1F226BB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E091C3F21;
	Tue,  1 Oct 2024 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bQZz/xKK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4811C244C;
	Tue,  1 Oct 2024 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786306; cv=none; b=poEDXePRBG42TvVp8Ali2M7dldncje48B+eia0FMEHoTHcwmDEsCL5SMoryoekz6nQxHVRfARuwpF+AzLG/aI6TExBlIbn/lfbB30fWpwwc7G1UXueccU5ZJth+QGqJ2PmrFi9zJkQtuGgdEiNwA8JBylnDqMFHcYt9cxaNPX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786306; c=relaxed/simple;
	bh=N4ChhPgh9o0JDooR9XpnsoFIXb5oUbtzRpvfmh+Ad3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=silr2FUCo9+WBwMBRBgqKPSerBQqagdHcM5Lp/rvSE5N4jGjZ7tuEsN+m9UIh112xOM3sIQbvA//pej6n9txXT8b55/t0fBf0wWi5aZrZjo3COD9h60oxc2q2lkhHcnskNmRyT48qnYpGEUw//PX06r8lDT9gOPhkB5jqYxDRes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bQZz/xKK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727786305; x=1759322305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N4ChhPgh9o0JDooR9XpnsoFIXb5oUbtzRpvfmh+Ad3g=;
  b=bQZz/xKKuNIe8/Dd+PNMtVKKWpdjXRIqbA9iIoad8iOx84FhMPuRnqSW
   fwGVENzGHAOuo6HCodZnWiw6d/2yj4mIDha2Aq/CUyh04qj/RZHqfeicK
   A9SyHQmSF0NES/QZJ4GQmAPoxNBbcEEjfv6/M8Mwr4FjMyP9T0sFtbzm+
   V/Fa7oWj2mzYhwwA59jopO64ctj+rGXXe2qUpj9R+0ZCixcmmbSvwg9+Q
   Dh+sg7gsRLjkM0N6GSOn23yBfr7M5kN9TcTkKal0sMnUFGpNMWdZ6gPqh
   vrM3+yPLE9RrtsLpdDgLODnuIb6GETZdBTMZq56JTAav9POtLGrGc9mnG
   Q==;
X-CSE-ConnectionGUID: F9WgwppkTm6IvTcz3axUkw==
X-CSE-MsgGUID: d7SUYREaSxyZthDb7L+1Ag==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="33054352"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 05:38:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 05:38:08 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 05:38:04 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v3 5/7] net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C1
Date: Tue, 1 Oct 2024 18:07:32 +0530
Message-ID: <20241001123734.1667581-6-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
References: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for LAN8670/1/2 Rev.C1 as per the latest configuration note
AN1699 released (Revision E (DS60001699F - June 2024)).
https://www.microchip.com/en-us/application-notes/an1699

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
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
index a874ac87ce10..003aecaf35b2 100644
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
+	 * Refer the below links for the comparison.
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
@@ -370,6 +423,16 @@ static struct phy_driver microchip_t1s_driver[] = {
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
@@ -388,6 +451,7 @@ module_phy_driver(microchip_t1s_driver);
 
 static struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB) },
 	{ }
 };
-- 
2.34.1


