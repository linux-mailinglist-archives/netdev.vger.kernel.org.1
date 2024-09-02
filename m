Return-Path: <netdev+bounces-124226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3843B968A18
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AB0282C98
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E819F10C;
	Mon,  2 Sep 2024 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fmAJfuq6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEC1A264D;
	Mon,  2 Sep 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287770; cv=none; b=V35t7cTwnpvS3uEVvxJjmsSKfogXglj7qriwd2dMV5FOW7bvZfLcYTN2RJzKO1yJ3jtHoIMTsiUL+RvdXaeWBP9xKDL/IzFZvNvFjO2z3fj/KH0Fl6Vjm0D0vs2zqDy3KSrSEwoKhkmUPa1vIj5IWMYZWQSCf2q27yWod/agwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287770; c=relaxed/simple;
	bh=FU2s2IazRvyJuJ6eR3DYyCxYE4wFwIzeJ3sKgDBVtog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3bzxWBWj/cEUOYNy3GSUSHkt2U/IDUhVeanaafhSqLon/VtJFc/Bsq/QQngUQ2/xjmdhze19b16OKpZRh2eydXXF4arK3LjK6q1CGmFduLYmaem27UpN2A22xkMfXbI2GH4EGvoTZLDYWPoD0/pRD97P6r4H3oiJUhKQhxSYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fmAJfuq6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725287768; x=1756823768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FU2s2IazRvyJuJ6eR3DYyCxYE4wFwIzeJ3sKgDBVtog=;
  b=fmAJfuq6CGBg8PmYuQHIoO5HtMWeKqzLUTWQi2a4quYgPYkeutLW9Pfx
   1bUFQamhTsXS8Ay929GJ+I30d0fRHXwz3Cr0TtNbraMizcgH9fP+Ocw4d
   0QKwmJigN3ykGst8+Vhj5C2x5jhcxULk45KXISOlZ0F2k62cfPVC7KYSL
   g9gbatFAoEi/Zs3Szkc2R5RoMajWoewyiEMuweROLzOOmELpUnvnqrJXF
   WJ09yx38rcq9lJUDZhItWv1mGLssGKmk8mCmqmjLAqHScQZqwrcYcqhjV
   /agQBPeClg6kCM4ZMtnunn0HhMrcMw0E/wxSDp4zlaCtTawi25vLW6gFU
   A==;
X-CSE-ConnectionGUID: nwmy61OOT8aTto41TmdklQ==
X-CSE-MsgGUID: mdDKCsvUR2uVvioHd4NJdg==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="31855351"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:36:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:35:40 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 07:35:35 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 7/7] net: phy: microchip_t1s: configure collision detection based on PLCA mode
Date: Mon, 2 Sep 2024 20:04:58 +0530
Message-ID: <20240902143458.601578-8-Parthiban.Veerasooran@microchip.com>
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

As per LAN8650/1 Rev.B0/B1 AN1760 (Revision F (DS60001760G - June 2024))
and LAN8670/1/2 Rev.C1/C2 AN1699 (Revision E (DS60001699F - June 2024)),
under normal operation, the device should be operated in PLCA mode.
Disabling collision detection is recommended to allow the device to
operate in noisy environments or when reflections and other inherent
transmission line distortion cause poor signal quality. Collision
detection must be re-enabled if the device is configured to operate in
CSMA/CD mode.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 42 ++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index bd0c768df0af..a0565508d7d2 100644
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
@@ -370,6 +376,36 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
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
@@ -403,7 +439,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 	{
@@ -413,7 +449,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 	{
@@ -423,7 +459,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.config_init        = lan865x_revb_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 };
-- 
2.34.1


