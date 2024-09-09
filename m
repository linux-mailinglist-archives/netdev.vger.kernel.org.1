Return-Path: <netdev+bounces-126591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC81971EE3
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B91B23CE2
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F813B791;
	Mon,  9 Sep 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B+PJqDF8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D913B797;
	Mon,  9 Sep 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898505; cv=none; b=acnZwTPS7QK/RHbFMDaHCAJCbXTpMMVUd2JfA/3sGH0hXyVYmozhVV2AgJZY9XQzGACBhanhvU62v8y35Bn/YIwvQWnRYf0d/l711xi03w9XVln5uQRSp8UHVeIJsO6WL+szM+p0eBdQRxtb9P90oK2h+AyqhQpoSD73qCTs4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898505; c=relaxed/simple;
	bh=s0SRACD5cJWhVk2UVXJJxtcwx52keFG+0hezbZQuQv0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rNnXjAmimLeobHupNQDTDKJPEZ16/w6f0p9Hv/yI2emfYfb9DcfDLfDJ7JqBFJHSjQLwBDdCiZm7BBi1joQguRunNQ/k4f3h/g0shBwKVj+KEH2CnOT9UINvAaLtd85eZppFwjPIYc6eY+ptn3YnSYUuuD8KwbnPNMTaU2mBmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B+PJqDF8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725898504; x=1757434504;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s0SRACD5cJWhVk2UVXJJxtcwx52keFG+0hezbZQuQv0=;
  b=B+PJqDF8zj4CMMGtt5P9n44QZK4MITCRaxzvgv7nAsgYd5qUlDbVQFwy
   Jl+k9F8JNIoaWKzZrrVO6jDrw6fwIYCPU1D+1sVDRQwcsnZWo24NuenHy
   fdejXX72l+f46BAAdNH496gycZFgRj9iK1MagevXgwJ8rkcetpikudu/d
   iAnZ87frHlh0cxSDZ7yk33RSNAh2yII3hswq+a0gtqqa1U97MMog+8f12
   O4xn3We5PGcdXlOn0tMN0uLU4uxP6J4K7PBP8UgNASMu2WkbtpOpLp6HX
   GXum3dcNYAXajcKrnAQziUwULSoFSoW2FXqhNRjrD26hgj+xoq6dwQzKO
   Q==;
X-CSE-ConnectionGUID: /l7ZEX7ESFyFyUXrQHRLEQ==
X-CSE-MsgGUID: YZZLYTS6S3emqsSsllcWMg==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="32161723"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 09:15:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 09:14:47 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 09:14:43 -0700
From: Tarun Alle <tarun.alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2] net: phy: microchip_t1: SQI support for LAN887x
Date: Mon, 9 Sep 2024 21:40:05 +0530
Message-ID: <20240909161005.185122-1-tarun.alle@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tarun Alle <Tarun.Alle@microchip.com>

Add support for measuring Signal Quality Index for LAN887x T1 PHY.
Signal Quality Index (SQI) is measure of Link Channel Quality from
0 to 7, with 7 as the best. By default, a link loss event shall
indicate an SQI of 0.

Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>
---
v1->v2
Addressed below review comments
- Replaced hard-coded 200 with ARRAY_SIZE(rawtable).
- Replaced return value -EINVAL with -ENETDOWN.
- Changed link checks.
---
 drivers/net/phy/microchip_t1.c | 154 +++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 5732ad65e7f9..22a5214acf86 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2018 Microchip Technology
 
 #include <linux/kernel.h>
+#include <linux/sort.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/mii.h>
@@ -188,6 +189,20 @@
 #define LAN887X_EFUSE_READ_DAT9_SGMII_DIS	BIT(9)
 #define LAN887X_EFUSE_READ_DAT9_MAC_MODE	GENMASK(1, 0)
 
+#define LAN887X_COEFF_PWR_DN_CONFIG_100		0x0404
+#define LAN887X_COEFF_PWR_DN_CONFIG_100_V	0x16d6
+#define LAN887X_SQI_CONFIG_100			0x042e
+#define LAN887X_SQI_CONFIG_100_V		0x9572
+#define LAN887X_SQI_MSE_100			0x483
+
+#define LAN887X_POKE_PEEK_100			0x040d
+#define LAN887X_POKE_PEEK_100_EN		BIT(0)
+
+#define LAN887X_COEFF_MOD_CONFIG		0x080d
+#define LAN887X_COEFF_MOD_CONFIG_DCQ_COEFF_EN	BIT(8)
+
+#define LAN887X_DCQ_SQI_STATUS			0x08b2
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN87XX/LAN937x/LAN887x T1 PHY driver"
 
@@ -1420,6 +1435,143 @@ static void lan887x_get_strings(struct phy_device *phydev, u8 *data)
 		ethtool_puts(&data, lan887x_hw_stats[i].string);
 }
 
+/* Compare block to sort in ascending order */
+static int data_compare(const void *a, const void *b)
+{
+	return  *(u16 *)a - *(u16 *)b;
+}
+
+static int lan887x_get_sqi_100M(struct phy_device *phydev)
+{
+	u16 rawtable[200];
+	u32 sqiavg = 0;
+	u8 sqinum;
+	int rc;
+
+	/* Configuration of SQI 100M */
+	rc = phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			   LAN887X_COEFF_PWR_DN_CONFIG_100,
+			   LAN887X_COEFF_PWR_DN_CONFIG_100_V);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_write_mmd(phydev, MDIO_MMD_VEND1, LAN887X_SQI_CONFIG_100,
+			   LAN887X_SQI_CONFIG_100_V);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_SQI_CONFIG_100);
+	if (rc != LAN887X_SQI_CONFIG_100_V)
+		return -EINVAL;
+
+	rc = phy_modify_mmd(phydev, MDIO_MMD_VEND1, LAN887X_POKE_PEEK_100,
+			    LAN887X_POKE_PEEK_100_EN,
+			    LAN887X_POKE_PEEK_100_EN);
+	if (rc < 0)
+		return rc;
+
+	/* Required before reading register
+	 * otherwise it will return high value
+	 */
+	msleep(50);
+
+	/* Link check before raw readings */
+	rc = genphy_c45_read_link(phydev);
+	if (rc < 0)
+		return rc;
+
+	if (!phydev->link)
+		return -ENETDOWN;
+
+	/* Get 200 SQI raw readings */
+	for (int i = 0; i < ARRAY_SIZE(rawtable); i++) {
+		rc = phy_write_mmd(phydev, MDIO_MMD_VEND1,
+				   LAN887X_POKE_PEEK_100,
+				   LAN887X_POKE_PEEK_100_EN);
+		if (rc < 0)
+			return rc;
+
+		rc = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				  LAN887X_SQI_MSE_100);
+		if (rc < 0)
+			return rc;
+
+		rawtable[i] = rc;
+	}
+
+	/* Link check after raw readings */
+	rc = genphy_c45_read_link(phydev);
+	if (rc < 0)
+		return rc;
+
+	if (!phydev->link)
+		return -ENETDOWN;
+
+	/* Sort SQI raw readings in ascending order */
+	sort(rawtable, ARRAY_SIZE(rawtable), sizeof(u16), data_compare, NULL);
+
+	/* Keep inliers and discard outliers */
+	for (int i = 40; i < 160; i++)
+		sqiavg += rawtable[i];
+
+	/* Get SQI average */
+	sqiavg /= 120;
+
+	if (sqiavg < 75)
+		sqinum = 7;
+	else if (sqiavg < 94)
+		sqinum = 6;
+	else if (sqiavg < 119)
+		sqinum = 5;
+	else if (sqiavg < 150)
+		sqinum = 4;
+	else if (sqiavg < 189)
+		sqinum = 3;
+	else if (sqiavg < 237)
+		sqinum = 2;
+	else if (sqiavg < 299)
+		sqinum = 1;
+	else
+		sqinum = 0;
+
+	return sqinum;
+}
+
+static int lan887x_get_sqi(struct phy_device *phydev)
+{
+	int rc, val;
+
+	if (phydev->speed != SPEED_1000 &&
+	    phydev->speed != SPEED_100) {
+		return -ENETDOWN;
+	}
+
+	if (phydev->speed == SPEED_100)
+		return lan887x_get_sqi_100M(phydev);
+
+	/* Writing DCQ_COEFF_EN to trigger a SQI read */
+	rc = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+			      LAN887X_COEFF_MOD_CONFIG,
+			      LAN887X_COEFF_MOD_CONFIG_DCQ_COEFF_EN);
+	if (rc < 0)
+		return rc;
+
+	/* Wait for DCQ done */
+	rc = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+				       LAN887X_COEFF_MOD_CONFIG, val, ((val &
+				       LAN887X_COEFF_MOD_CONFIG_DCQ_COEFF_EN) !=
+				       LAN887X_COEFF_MOD_CONFIG_DCQ_COEFF_EN),
+				       10, 200, true);
+	if (rc < 0)
+		return rc;
+
+	rc = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_DCQ_SQI_STATUS);
+	if (rc < 0)
+		return rc;
+
+	return FIELD_GET(T1_DCQ_SQI_MSK, rc);
+}
+
 static struct phy_driver microchip_t1_phy_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX),
@@ -1468,6 +1620,8 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_status	= genphy_c45_read_status,
+		.get_sqi	= lan887x_get_sqi,
+		.get_sqi_max	= lan87xx_get_sqi_max,
 	}
 };
 
-- 
2.34.1


