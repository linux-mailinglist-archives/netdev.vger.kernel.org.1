Return-Path: <netdev+bounces-134107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1357998058
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C19728280B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A0C1CBE9D;
	Thu, 10 Oct 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ld3XqlK+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA521CBE80;
	Thu, 10 Oct 2024 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548592; cv=none; b=Y6/AU7n4BZVnTydr3lxaMhssHrm+d9Y/2kZgrkUxySj6ucpX/JpGZtqPMdaRhDXJv4IVAJfdPW1zllpcSCSe7lXlzKyRlKwPZWEEVg4+9Culk2Yq9VTu/DSEAILlgIm2qtB08xSY1SfKCFYacNCF1IWYolYxrg050/hhWr3w4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548592; c=relaxed/simple;
	bh=nr8O7SeOMyURt8Zh8wTaKBS87EZRqml+xFICGCFhnpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eb4jl5LAcwTe44ckLQ2UByqm0CRBqCyhor9vq7Z0m/zGq8s3VVHSOM9Gfg+Xt51gp967x6ep8D0LgS8G1rKAIiWXVKUbztVuxmmEjQ+Rk0Dy8wZfQi8Mvs5d+I05qpFT2+UvhiRSEkXKEOvdMfFUP+KbOTCojg3GI2Q+Ne0B53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ld3XqlK+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728548590; x=1760084590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nr8O7SeOMyURt8Zh8wTaKBS87EZRqml+xFICGCFhnpI=;
  b=Ld3XqlK+tiih+iM7qNt8y46gr1v+5+3kjg+/ZGi7tl0VDaGcDRPYQrgO
   CvoCU/zXRYbH0AsuRtYuJMzA6bS5WQ26eKq2/JqRcZOrc8qnpSLEzL+By
   MS0xQow7/J58LRW2SvSkwiMabwMA5HC+LzIFbzvJ9+UTnCQuCrdJu1dVA
   ll5yrlEiwq7z4wMbMtPg2FqP7NwLSCe7o+rE9x5lFQOdq3u+PE5AAyhY5
   j+tvDTz74scPEjLnt0z2lnWzmUYLwMuO8VzfsSIt9XAnSGsTWQ3vBCOj5
   VsiRQWNqInq2fApqFxAaBMiLTCV59k5hHdAtV2pWpGMeSFQ25zUlaUG+l
   g==;
X-CSE-ConnectionGUID: 0Oq6o7p0RZi/Peoa7+MFHw==
X-CSE-MsgGUID: 8awDXCyrQqOZeObM4aHt+w==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="36163257"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 01:23:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 01:22:53 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 01:22:49 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v4 6/7] net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C2
Date: Thu, 10 Oct 2024 13:52:04 +0530
Message-ID: <20241010082205.221493-7-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010082205.221493-1-parthiban.veerasooran@microchip.com>
References: <20241010082205.221493-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for LAN8670/1/2 Rev.C2 as per the latest configuration note
AN1699 released (Revision E (DS60001699F - June 2024)) for Rev.C1 is also
applicable for Rev.C2. Refer hardware revisions list in the latest AN1699
Revision E (DS60001699F - June 2024).
https://www.microchip.com/en-us/application-notes/an1699

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/Kconfig         |  4 ++--
 drivers/net/phy/microchip_t1s.c | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 04f605606a8a..ee3ea0b56d48 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -292,8 +292,8 @@ config MICREL_PHY
 config MICROCHIP_T1S_PHY
 	tristate "Microchip 10BASE-T1S Ethernet PHYs"
 	help
-	  Currently supports the LAN8670/1/2 Rev.B1/C1 and LAN8650/1 Rev.B0/B1
-	  Internal PHYs.
+	  Currently supports the LAN8670/1/2 Rev.B1/C1/C2 and
+	  LAN8650/1 Rev.B0/B1 Internal PHYs.
 
 config MICROCHIP_PHY
 	tristate "Microchip PHYs"
diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index f4081886ac1e..d305c2b1fcd0 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -3,7 +3,7 @@
  * Driver for Microchip 10BASE-T1S PHYs
  *
  * Support: Microchip Phys:
- *  lan8670/1/2 Rev.B1/C1
+ *  lan8670/1/2 Rev.B1/C1/C2
  *  lan8650/1 Rev.B0/B1 Internal PHYs
  */
 
@@ -13,6 +13,7 @@
 
 #define PHY_ID_LAN867X_REVB1 0x0007C162
 #define PHY_ID_LAN867X_REVC1 0x0007C164
+#define PHY_ID_LAN867X_REVC2 0x0007C165
 /* Both Rev.B0 and B1 clause 22 PHYID's are same due to B1 chip limitation */
 #define PHY_ID_LAN865X_REVB 0x0007C1B3
 
@@ -292,7 +293,7 @@ static int lan867x_check_reset_complete(struct phy_device *phydev)
 	return 0;
 }
 
-static int lan867x_revc1_config_init(struct phy_device *phydev)
+static int lan867x_revc_config_init(struct phy_device *phydev)
 {
 	s8 offsets[2];
 	int ret;
@@ -305,10 +306,10 @@ static int lan867x_revc1_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	/* LAN867x Rev.C1 configuration settings are equal to the first 9
+	/* LAN867x Rev.C1/C2 configuration settings are equal to the first 9
 	 * configuration settings and all the sqi fixup settings from LAN865x
 	 * Rev.B0/B1. So the same fixup registers and values from LAN865x
-	 * Rev.B0/B1 are used for LAN867x Rev.C1 to avoid duplication.
+	 * Rev.B0/B1 are used for LAN867x Rev.C1/C2 to avoid duplication.
 	 * Refer the below links for the comparison.
 	 * https://www.microchip.com/en-us/application-notes/an1760
 	 * Revision F (DS60001760G - June 2024)
@@ -428,7 +429,17 @@ static struct phy_driver microchip_t1s_driver[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1),
 		.name               = "LAN867X Rev.C1",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
-		.config_init        = lan867x_revc1_config_init,
+		.config_init        = lan867x_revc_config_init,
+		.read_status        = lan86xx_read_status,
+		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
+		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.get_plca_status    = genphy_c45_plca_get_status,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC2),
+		.name               = "LAN867X Rev.C2",
+		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
@@ -453,6 +464,7 @@ module_phy_driver(microchip_t1s_driver);
 static struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC2) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB) },
 	{ }
 };
-- 
2.34.1


