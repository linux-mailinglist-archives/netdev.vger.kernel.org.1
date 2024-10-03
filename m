Return-Path: <netdev+bounces-131688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C6798F43C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33B9B23080
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687B51A7046;
	Thu,  3 Oct 2024 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hRoFIT8v"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C81A3AB7;
	Thu,  3 Oct 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972799; cv=none; b=kgF129q7cUAyttAnqVAfr7ltBX2WvDQL0PCDVRqLAs60U1arlAIXUzTchL2Z4LusV9qarwG03+gVXBXtw7SdOcAnOrnlCXlgCojsU9FwsuE98DED2eJSq9i7434Uk11FDcUOF888O94Qw/JayPglKAZvCtL1oftJDRKdlbsedMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972799; c=relaxed/simple;
	bh=+EWm9ovp3FONrNswzRV2ocgiTP0QhZsdLG0Iv6QGQTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G8Tk7dJeOTQEkp25MxDQhC8UHAKPuWMEvJsUgcFRH6icPUCdOna8PNe1zHzSY7ZaVOCQISIS5TJ9HfKXbS/9h3zRe2GBkx4IujHo63BM0hnnVUvEXB00jIWyLuB/0/S5BigfXd6oWuLXcg7BnC4+WXKx42D5uMa5xNQN59Ab5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hRoFIT8v; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727972797; x=1759508797;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+EWm9ovp3FONrNswzRV2ocgiTP0QhZsdLG0Iv6QGQTk=;
  b=hRoFIT8vO/zWe8GjufeMus8W7UkGjCaYtTV6yv/aIF7yEGk0KW1qgemO
   DMewxe0Auo8B7mOZPamExRmCTc6DTAhxJuVMVzNTFBjqecXn+enLAwxTa
   a2YnBJUGn1uEAGh0QExRlXJ1WZHFY8UUROC5TWK9IBv71radkjUr1F0Js
   D4T7w/5Fi6Rk+yZClloY1+3doaZsYqsKCv5O7kJNfG8E7DA3y5T0lEz3P
   cEc0Gg0+TMqUIjsZwVoZTtHq5+WldPmFJqIMqptom7xAbtei+3ieWvpaD
   E8AwrnNu5uJDQnZCSMkd8jeZMNPbfa/79cWNbx09xPN+Lptq6lU/I1c9l
   g==;
X-CSE-ConnectionGUID: EJyWgJZ7TvOBIF+vRJDc2A==
X-CSE-MsgGUID: S8KfLE8gR3OHapzlvornXg==
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="263610546"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2024 09:26:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 3 Oct 2024 09:26:09 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 3 Oct 2024 09:26:06 -0700
From: Tarun Alle <tarun.alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5] net: phy: microchip_t1: SQI support for LAN887x
Date: Thu, 3 Oct 2024 21:51:18 +0530
Message-ID: <20241003162118.232123-1-tarun.alle@microchip.com>
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
v4 -> v5
- Renamed and organised the macros of SQI samples.

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
 drivers/net/phy/microchip_t1.c | 172 +++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index a5ef8fe50704..69e01692db65 100644
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
@@ -226,6 +227,35 @@
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
+/* SQI raw samples count */
+#define SQI_SAMPLES 200
+
+/* Samples percentage considered for SQI calculation */
+#define SQI_INLINERS_PERCENT 60
+
+/* Samples count considered for SQI calculation */
+#define SQI_INLIERS_NUM (SQI_SAMPLES * SQI_INLINERS_PERCENT / 100)
+
+/* Start offset of samples */
+#define SQI_INLIERS_START ((SQI_SAMPLES - SQI_INLIERS_NUM) / 2)
+
+/* End offset of samples */
+#define SQI_INLIERS_END (SQI_INLIERS_START + SQI_INLIERS_NUM)
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN87XX/LAN937x/LAN887x T1 PHY driver"
 
@@ -1830,6 +1860,146 @@ static int lan887x_cable_test_get_status(struct phy_device *phydev,
 	return lan887x_cable_test_report(phydev);
 }
 
+/* Compare block to sort in ascending order */
+static int sqi_compare(const void *a, const void *b)
+{
+	return  *(u16 *)a - *(u16 *)b;
+}
+
+static int lan887x_get_sqi_100M(struct phy_device *phydev)
+{
+	u16 rawtable[SQI_SAMPLES];
+	u32 sqiavg = 0;
+	u8 sqinum = 0;
+	int rc, i;
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
+	for (i = 0; i < SQI_SAMPLES; i++) {
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
+	sort(rawtable, SQI_SAMPLES, sizeof(u16), sqi_compare, NULL);
+
+	/* Keep inliers and discard outliers */
+	for (i = SQI_INLIERS_START; i < SQI_INLIERS_END; i++)
+		sqiavg += rawtable[i];
+
+	/* Handle invalid samples */
+	if (sqiavg != 0) {
+		/* Get SQI average */
+		sqiavg /= SQI_INLIERS_NUM;
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
@@ -1881,6 +2051,8 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.read_status	= genphy_c45_read_status,
 		.cable_test_start = lan887x_cable_test_start,
 		.cable_test_get_status = lan887x_cable_test_get_status,
+		.get_sqi	= lan887x_get_sqi,
+		.get_sqi_max	= lan87xx_get_sqi_max,
 	}
 };
 
-- 
2.34.1


