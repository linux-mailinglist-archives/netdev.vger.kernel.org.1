Return-Path: <netdev+bounces-132590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBF799250E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43EF28154D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 06:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92FA136E09;
	Mon,  7 Oct 2024 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WVaEUOUJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD01E492;
	Mon,  7 Oct 2024 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283577; cv=none; b=b5AOz+sdZ+QEkiLV2QpOgaHr9IAQ2vpx1C2w4938G+5pi1j+A57DvgMJJe+NG0D/N7O/Zgu3rR9sMH4iC4+Mni/ExldktGHrJ89TyV4Qgf3oX0GtbgVmp3+hDLeuzufiP7x1YD9Ea9sOOxbm6Q8OiwojujagPHpQY3HGUS0MeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283577; c=relaxed/simple;
	bh=278a9bEsg2ZwJylr+Q8SFA/qm1X7QDS861sZ5ZBNWOs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z7T4n0jp9P9KXZajI/DFd7+5jnGNO6Ab111oiE/gEv5xpMvEURiVg3ZdjXmxd8e+aPM0VoS5QiC3HyR2yXvK4x/nCrnLBPBZuMEvyCCYPEbTwjX6IT1DrXGOi/Td/0U4wXePvuYFDRS5jFuK9SPQ7Eq5U5RmSpYso2lnw9UKF3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WVaEUOUJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728283575; x=1759819575;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=278a9bEsg2ZwJylr+Q8SFA/qm1X7QDS861sZ5ZBNWOs=;
  b=WVaEUOUJVGbT72TUp/10CqNLb1FgpYaXa63IMzdILjAaAeRlQLiF2nQc
   kFJ63ai29TWQdf2EIdO+r7xg4Ggcky0HWMMlYKrj++8xWMXobQWopWc57
   NDb4ZysrMqEoZ5kZvdyanoVNiypafeLZeIBN6VnIWkhmsO3GG4Ez60BpS
   QEiBo+OiNZ8SJFV9pFgthfnjpOzWj6wU5Tb+r0+cD7vcUCsv/ATPfbshW
   Ex9zVCMfsJ+iHVAFQIJRDbwPZb6zizXGW8WB6WyhFxp1NleScYVlcXUgm
   LIIqhbWKzqPnfRkTalY3P2z22sqirdIKKLhQ6sp9mpiIGQ9fynIZ3ri31
   g==;
X-CSE-ConnectionGUID: FbNH1uqRRG6+IQwRq8SrWw==
X-CSE-MsgGUID: BAHnr4L/QhSNSHItRVOiZg==
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; 
   d="scan'208";a="35969237"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2024 23:45:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 6 Oct 2024 23:44:36 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 6 Oct 2024 23:44:32 -0700
From: Tarun Alle <tarun.alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6] net: phy: microchip_t1: SQI support for LAN887x
Date: Mon, 7 Oct 2024 12:09:43 +0530
Message-ID: <20241007063943.3233-1-tarun.alle@microchip.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v5 -> v6
- Removed unneccesary braces.

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
 drivers/net/phy/microchip_t1.c | 171 +++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index f99f37634d5e..71d6050b2833 100644
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
@@ -238,6 +239,35 @@
 #define LAN887X_MX_CHIP_TOP_ALL_MSK	(LAN887X_INT_MSK_T1_PHY_INT_MSK |\
 					 LAN887X_MX_CHIP_TOP_LINK_MSK)
 
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
 
@@ -1889,6 +1919,145 @@ static int lan887x_cable_test_get_status(struct phy_device *phydev,
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
+	    phydev->speed != SPEED_100)
+		return -ENETDOWN;
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
@@ -1942,6 +2111,8 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.cable_test_get_status = lan887x_cable_test_get_status,
 		.config_intr    = lan887x_config_intr,
 		.handle_interrupt = lan887x_handle_interrupt,
+		.get_sqi	= lan887x_get_sqi,
+		.get_sqi_max	= lan87xx_get_sqi_max,
 	}
 };
 
-- 
2.34.1


