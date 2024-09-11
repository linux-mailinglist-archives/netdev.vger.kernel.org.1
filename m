Return-Path: <netdev+bounces-127357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B9975361
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF57289909
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1218DF97;
	Wed, 11 Sep 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dwhjibgK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB161714AC;
	Wed, 11 Sep 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060608; cv=none; b=fY4LuYd7tImxXGxWDpE2daB/tlMxJC1G7/T20CVU4PrrOaok1194gS7WtDphS0T0lgSL3S2eC1jzjHQ6iGP82fV2CUGF5dz9/XMZ5E81hmTSV1zp/T6LsjM8jgCVZKKcwA5KrE+TEEEGB5QW/5kM/BxQeT36j2ylCn8EZPz9Mbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060608; c=relaxed/simple;
	bh=GVeidM8o4ega2wg1yFoIZMqzVWIF2rHgnizr5mTMjy0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Df6MwIl0aej8k0a+A9KFBE/p76TsA803NBAqoySw+tPYMu8jc+C7FroqhHnzi2HwkDpFEsChCX0WwbdiRPabV6n2bycUGFUL+7xxfvJdopZM1+mirC24v4Au2NQWv4aL+a6RTJU+kF/i+vBA8BUZAXVWwkyZlQDEApsy9DHtV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dwhjibgK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726060606; x=1757596606;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GVeidM8o4ega2wg1yFoIZMqzVWIF2rHgnizr5mTMjy0=;
  b=dwhjibgK3SEyjy93nSNDvlGuKDb5Xqo0BDlnQEyTLCb0A2tERXHdm2Wv
   qm3MDlEyaNbI1gJZcJFH6cNTrqBW8bh+YmZw1jxCKH7llZqMu4QMoJ8vG
   vuJZQqnkPsoqT0WiQHuI33gK2PjODWoWUa9p1PVT6dqq8hMwh6xjmAEfr
   j3rmcDtQkBXMaju6bqUknAvs38xPYPZunes5U8p1y8OLI3azr3FCHjKd/
   ODVbovtfG/+iI7XVxi6L19/CoQgNv7zvlNc+mXb0Xw3gPsKGL9rT3ZzFq
   X5hYFwyG7JHt5JA8CJMmCpj5Z38jcRtWY0xdX+dgK1fTaLL2M6YhJ7lvk
   A==;
X-CSE-ConnectionGUID: s3pohALoT4KsIphbLOcJTg==
X-CSE-MsgGUID: mUuEqcJAS+e4nNrD5qXyrw==
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="262630041"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 06:16:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 06:16:04 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Sep 2024 06:16:01 -0700
From: Tarun Alle <tarun.alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V3] net: phy: microchip_t1: SQI support for LAN887x
Date: Wed, 11 Sep 2024 18:41:24 +0530
Message-ID: <20240911131124.203290-1-tarun.alle@microchip.com>
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
v2 -> v3
Addressed below review comment
- Replaced hard-coded values with ARRAY_SIZE(rawtable).
---
v1 -> v2
Addressed below review comments
- Replaced hard-coded 200 with ARRAY_SIZE(rawtable).
- Replaced return value -EINVAL with -ENETDOWN.
- Changed link checks.
---
 drivers/net/phy/microchip_t1.c | 155 +++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 5732ad65e7f9..29ab45b919dc 100644
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
 
@@ -1420,6 +1435,144 @@ static void lan887x_get_strings(struct phy_device *phydev, u8 *data)
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
+	for (int i = ARRAY_SIZE(rawtable) / 5;
+	     i < ARRAY_SIZE(rawtable) / 5 * 4; i++)
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
@@ -1468,6 +1621,8 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_status	= genphy_c45_read_status,
+		.get_sqi	= lan887x_get_sqi,
+		.get_sqi_max	= lan87xx_get_sqi_max,
 	}
 };
 
-- 
2.34.1


