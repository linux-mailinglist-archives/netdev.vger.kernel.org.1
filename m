Return-Path: <netdev+bounces-134109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D99A99805D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A261C2465F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230BD1CC899;
	Thu, 10 Oct 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yvULkrbV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C961CBE9F;
	Thu, 10 Oct 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548595; cv=none; b=XK53zcSKC969BfOp+VRjrpIwHic8MqF/DSQ14NHMJ1WynL9Ir9Sfe3sr3sXHdHB2uGnSA6p8gaRgvH4c/XSkduMyzVo32AHtT3OoNXx5ZdEaDpiA3XfDKP5EtgHeQBZ66XCbiprWADxzBCzU+6WDrsHVGrqNcXp+C+5J2eR31GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548595; c=relaxed/simple;
	bh=so3vazU+kWnaRGDyW/mPgxy+A2iYe9UlJUu37xFaU5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUWdfLiGRpwFbi+SNhb7tOue/wiDtK4f4RWlDW3QepH0YW9/oEN9VzX+g9AzX0PQYCyfhfbKJZuQ0S3vmFneXq51Ga0n7wcyzJufgrbFseDHXuSB7cI3YrsSvCYMVoAYU+3lhItiL11+HmDV+uue58EMHrp2oXYWunaf6OpYQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yvULkrbV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728548592; x=1760084592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=so3vazU+kWnaRGDyW/mPgxy+A2iYe9UlJUu37xFaU5Q=;
  b=yvULkrbVatHoqYxuCZ2PFMzAWQirXYlApo7E7qExZY6jJwlR/V3HfI6o
   rsWf6kULsfmgmC8ndTJ5OWJaIgo7b+5VC5iFEhNaWRedRPC5jyQpi1LMV
   AwqUhoc8hye03U8/tZuVrKrUF4+E6mJB3Lx9nsu+ss7SVRpynazIa6Faj
   mq6yX/KkknWWlQgYgJWVndNx8cCH+oLbW84toW177sNU8WIadM1Orys+T
   gHt8foQ96pHSHAOYbTiN4IiRnUeaMdoaSS/A22DrU/nmcPRPWqL//eCQu
   40KM4gJWwlNbudG0+oe1uuIeSXBZpMvkC//QImk3frQDx9Kt5s/aKBVha
   w==;
X-CSE-ConnectionGUID: 0Oq6o7p0RZi/Peoa7+MFHw==
X-CSE-MsgGUID: QmiUCtYMTPyP8V68ZyBZCA==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="36163260"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 01:23:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 01:22:57 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 01:22:53 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v4 7/7] net: phy: microchip_t1s: configure collision detection based on PLCA mode
Date: Thu, 10 Oct 2024 13:52:05 +0530
Message-ID: <20241010082205.221493-8-parthiban.veerasooran@microchip.com>
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

As per LAN8650/1 Rev.B0/B1 AN1760 (Revision F (DS60001760G - June 2024))
and LAN8670/1/2 Rev.C1/C2 AN1699 (Revision E (DS60001699F - June 2024)),
under normal operation, the device should be operated in PLCA mode.
Disabling collision detection is recommended to allow the device to
operate in noisy environments or when reflections and other inherent
transmission line distortion cause poor signal quality. Collision
detection must be re-enabled if the device is configured to operate in
CSMA/CD mode.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 42 ++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index d305c2b1fcd0..75d291154b4c 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -26,6 +26,12 @@
 #define LAN865X_REG_CFGPARAM_CTRL 0x00DA
 #define LAN865X_REG_STS2 0x0019
 
+/* Collision Detector Control 0 Register */
+#define LAN86XX_REG_COL_DET_CTRL0	0x0087
+#define COL_DET_CTRL0_ENABLE_BIT_MASK	BIT(15)
+#define COL_DET_ENABLE			BIT(15)
+#define COL_DET_DISABLE			0x0000
+
 #define LAN865X_CFGPARAM_READ_ENABLE BIT(1)
 
 /* The arrays below are pulled from the following table from AN1699
@@ -371,6 +377,36 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+/* As per LAN8650/1 Rev.B0/B1 AN1760 (Revision F (DS60001760G - June 2024)) and
+ * LAN8670/1/2 Rev.C1/C2 AN1699 (Revision E (DS60001699F - June 2024)), under
+ * normal operation, the device should be operated in PLCA mode. Disabling
+ * collision detection is recommended to allow the device to operate in noisy
+ * environments or when reflections and other inherent transmission line
+ * distortion cause poor signal quality. Collision detection must be re-enabled
+ * if the device is configured to operate in CSMA/CD mode.
+ *
+ * AN1760: https://www.microchip.com/en-us/application-notes/an1760
+ * AN1699: https://www.microchip.com/en-us/application-notes/an1699
+ */
+static int lan86xx_plca_set_cfg(struct phy_device *phydev,
+				const struct phy_plca_cfg *plca_cfg)
+{
+	int ret;
+
+	ret = genphy_c45_plca_set_cfg(phydev, plca_cfg);
+	if (ret)
+		return ret;
+
+	if (plca_cfg->enabled)
+		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+				      LAN86XX_REG_COL_DET_CTRL0,
+				      COL_DET_CTRL0_ENABLE_BIT_MASK,
+				      COL_DET_DISABLE);
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
+			      COL_DET_CTRL0_ENABLE_BIT_MASK, COL_DET_ENABLE);
+}
+
 static int lan86xx_read_status(struct phy_device *phydev)
 {
 	/* The phy has some limitations, namely:
@@ -432,7 +468,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 	{
@@ -442,7 +478,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 	{
@@ -454,7 +490,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.read_mmd           = lan865x_phy_read_mmd,
 		.write_mmd          = lan865x_phy_write_mmd,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 };
-- 
2.34.1


