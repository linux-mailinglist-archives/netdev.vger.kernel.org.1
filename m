Return-Path: <netdev+bounces-128691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0029097AFE7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 14:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7672C1F24D27
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F619170A3F;
	Tue, 17 Sep 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tIvPlhCx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD08E57D;
	Tue, 17 Sep 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574556; cv=none; b=sBlvaZm6D6yCj106xnsvZ6JK3mYNiOFNT623bwj544Y3Y6g6BB9J/xf4yWSNaqexsqnxt6L09ud4F516BNuUrV6EPYe0/r2tuZI2BtaoKx3ZF2cfeAhEP8La7VY6xd7DVjEiu6TN5thWdUihmLqUphXKCeOKXvJPNX6MmoY68Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574556; c=relaxed/simple;
	bh=luqxYTH6BUDwfFwhpgXXrSF9yuT8UjjLcfN5E5jNujg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZWCGtOAKVh753vRhHaKVZfprUHoF9Jeck8tr9beHuVucIeX0iL6zet7dHG66O9Dw8OVfmlrPHx5EFOYVrdZg8ZmzliHfjgBYrPZd0h7GdIUvwTcj9eptQi+4bRTYlOhvzQ6AlxkZF/dArN8SpjakS5lw1a65l/TkiuafY6eJ2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tIvPlhCx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726574553; x=1758110553;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=luqxYTH6BUDwfFwhpgXXrSF9yuT8UjjLcfN5E5jNujg=;
  b=tIvPlhCxrwKOgiavZANkjKK+N85lTqoWtTjoWQgnxmMMmJ3RJl/Og7c3
   ebe1tsS3+lypcVokbfFRgShHO1A3Q2D7GBYPek+g9mFuGR3hf9dmDhwVk
   Jz0hd49GTvLDy03ZvEBVYlHi++0TWQQgvmjsLukde9KXkYcbIcBVtjUpt
   DcEJbFJ0OeM2ZWmMlDDTcbSg09ZcCBmkAhnAazJIdeFSB/ppRwHgqjzDl
   uLGKH00QpAN+BZ6QBPGwHcfHezWXNI+IxrjJFGOqBKzkcw9Kg+h5mVqAl
   y/sQFoLpYBjD0xIdHgQO4XSLSlTbDJsD/a3THZavnKgaSBpxpoRgb2sbr
   Q==;
X-CSE-ConnectionGUID: ZbeW3DQISYCZ2DnmZ/K/oA==
X-CSE-MsgGUID: A/6RSKm8Q4SGgHiCZOqTbQ==
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="35073308"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2024 05:02:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Sep 2024 05:01:49 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 17 Sep 2024 05:01:46 -0700
From: Tarun Alle <tarun.alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V4] net: phy: microchip_t1: SQI support for LAN887x
Date: Tue, 17 Sep 2024 17:26:57 +0530
Message-ID: <20240917115657.51041-1-tarun.alle@microchip.com>
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
v3 -> v4
- Added check to handle invalid samples.
- Added macro for ARRAY_SIZE(rawtable).

v2 -> v3
- Replaced hard-coded values with ARRAY_SIZE(rawtable).

v1 -> v2
- Replaced hard-coded 200 with ARRAY_SIZE(rawtable).
- Replaced return value -EINVAL with -ENETDOWN.
- Changed link checks.
---
 drivers/net/phy/microchip_t1.c | 161 +++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index a5ef8fe50704..e5cc4c8b2265 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
+#include <linux/sort.h>
 #include <linux/ethtool.h>
 #include <linux/ethtool_netlink.h>
 #include <linux/bitfield.h>
@@ -226,6 +227,22 @@
 #define MICROCHIP_CABLE_MAX_TIME_DIFF	\
 	(MICROCHIP_CABLE_MIN_TIME_DIFF + MICROCHIP_CABLE_TIME_MARGIN)
 
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
+#define SQI100M_SAMPLE_INIT(x, t)	(ARRAY_SIZE(t) / (x))
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN87XX/LAN937x/LAN887x T1 PHY driver"
 
@@ -1830,6 +1847,148 @@ static int lan887x_cable_test_get_status(struct phy_device *phydev,
 	return lan887x_cable_test_report(phydev);
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
+	u8 sqinum = 0;
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
+		rawtable[i] = (u16)rc;
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
+	for (int i = SQI100M_SAMPLE_INIT(5, rawtable);
+	     i < SQI100M_SAMPLE_INIT(5, rawtable) * 4; i++)
+		sqiavg += rawtable[i];
+
+	/* Handle invalid samples */
+	if (sqiavg != 0) {
+		/* Get SQI average */
+		sqiavg /= SQI100M_SAMPLE_INIT(5, rawtable) * 4 -
+				SQI100M_SAMPLE_INIT(5, rawtable);
+
+		if (sqiavg < 75)
+			sqinum = 7;
+		else if (sqiavg < 94)
+			sqinum = 6;
+		else if (sqiavg < 119)
+			sqinum = 5;
+		else if (sqiavg < 150)
+			sqinum = 4;
+		else if (sqiavg < 189)
+			sqinum = 3;
+		else if (sqiavg < 237)
+			sqinum = 2;
+		else if (sqiavg < 299)
+			sqinum = 1;
+		else
+			sqinum = 0;
+	}
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
@@ -1881,6 +2040,8 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.read_status	= genphy_c45_read_status,
 		.cable_test_start = lan887x_cable_test_start,
 		.cable_test_get_status = lan887x_cable_test_get_status,
+		.get_sqi	= lan887x_get_sqi,
+		.get_sqi_max	= lan87xx_get_sqi_max,
 	}
 };
 
-- 
2.34.1


