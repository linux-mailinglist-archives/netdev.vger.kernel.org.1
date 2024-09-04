Return-Path: <netdev+bounces-124990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7776096B88E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9DFB25783
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349E1CC887;
	Wed,  4 Sep 2024 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="frG8bexu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA34126C01;
	Wed,  4 Sep 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445846; cv=none; b=l87l+Kh3XpkH81OsEd7DXLrVB5tGpjrlX3goa9rzzn4ozGL+OL/Dgl+vF0UizBZa0jyXqO87RafN4ym/5ReBXrlFJGVvvTEAzZg9eDDFtV679zk5wdHeR3w6T6qV7gFcsyYuLfgAWguH08Nssrf+fqe6VOlNhmG4f6G1nSFBYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445846; c=relaxed/simple;
	bh=Kqs/rtR/ZYEIbehKp6eU3zceRyY4RAprXn7yHk1aXCs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iVRAyhI9CIq1y6HfzQRY09OLBvG56F8AxUBqCUQRtRv2TOx9P0TBHxc+CfFztA9AgnLRYuM1x7RHcJvT/h5OTSnzxBHMKhxidp80YrrdXkhXjH0fFj8lQ9bDX7HbUxrWrvr/fGGw8eJdmbbidU9TGen0EGVcKG4CAPtEyXVkX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=frG8bexu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725445844; x=1756981844;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kqs/rtR/ZYEIbehKp6eU3zceRyY4RAprXn7yHk1aXCs=;
  b=frG8bexuQEuHZ8Um+h04AO/tZ8BwS0k6E0IzEgtPjLIgec05BpwBu1Om
   1DK/Kbh+1k4Hdf+uUJi9hfI8ETvOAVY6gAd4J3nqS65dxm+ksoh/oUMLq
   bJsIrsZCo1UYSEjiEIeHyfxx8Ymu+3k8BddL87mBWORPf+OAscobeu8Hw
   4+yrA9tFv9NTPwOixB3gKxyKDvE/IRZRV9n0eFD1KsP+fzhu8AUwh4fMl
   3UoaymCAR2Li0DvcDU4Ycqjcew2xATz9OJiSbokt6pPx0F5hlhSbPfADE
   I5T8hhZedt2awQtHyXvhFNIW4xGIuoZgn71Zl+gOUgEJA1jnHHjDXnpak
   g==;
X-CSE-ConnectionGUID: V6nEgGxzRtOcs172XO07mQ==
X-CSE-MsgGUID: x+HcQ5fCR0614IlIxO/wHg==
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="31216194"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 03:30:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Sep 2024 03:30:42 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 4 Sep 2024 03:30:38 -0700
From: Tarun Alle <tarun.alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: phy: microchip_t1: SQI support for LAN887x
Date: Wed, 4 Sep 2024 15:56:06 +0530
Message-ID: <20240904102606.136874-1-tarun.alle@microchip.com>
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
 drivers/net/phy/microchip_t1.c | 144 +++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 5732ad65e7f9..01e0e71fca48 100644
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
 
@@ -1420,6 +1435,133 @@ static void lan887x_get_strings(struct phy_device *phydev, u8 *data)
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
+	/* Get 200 SQI raw readings */
+	for (int i = 0; i < 200; i++) {
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
+		rc = genphy_c45_read_link(phydev);
+		if (rc < 0)
+			return rc;
+
+		if (!phydev->link)
+			return -ENETDOWN;
+	}
+
+	/* Sort SQI raw readings in ascending order */
+	sort(rawtable, 200, sizeof(u16), data_compare, NULL);
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
+		return -EINVAL;
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
@@ -1468,6 +1610,8 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_status	= genphy_c45_read_status,
+		.get_sqi	= lan887x_get_sqi,
+		.get_sqi_max	= lan87xx_get_sqi_max,
 	}
 };
 
-- 
2.34.1


