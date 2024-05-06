Return-Path: <netdev+bounces-93622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5396C8BC785
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 08:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07F31F20F68
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BDC4C634;
	Mon,  6 May 2024 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="XXiSYuiI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pT+Lj619"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC7482D8;
	Mon,  6 May 2024 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714976689; cv=none; b=q4LCr+4OQFMkWjyeUvUPlsqtH7OvawfORgsdo977XjJG2DHdTSe4bpDzhaIfRrbnH1pn8hvg7i8TroAXuX4ONLXWVfLvhcI03yhTWpOzOczrw6ECGKoILJ05aGMbt2JmQgfrljL1fKK4LrJG9sJr8+snyQAzGQXhOIlrEnfoGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714976689; c=relaxed/simple;
	bh=99wCcr5j1fMdVVJWEMEin5eoQXJctZVFHMgoOllds4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fVC/O2UNRbjQGf6W71VQ6PC203QsDucAJbDBkYCB+lIBNKqzAbhr9jL9v7aTSsh2JN7Zkwp/m9j4xFRqBA5i8YAQkDPLXALlebcDn4aY37+GwgOLbn9D2V45DxJlfyNuJCWz+e5J8kO0xSPV/EdMLne5+roOmF2pkPY7PJqZfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=XXiSYuiI; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=pT+Lj619 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714976687; x=1746512687;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=hFvec8RHwfbecZbWl4y8XMXl+nHWiScbi0lqX4wyrMM=;
  b=XXiSYuiIE7/SCodW8VbDMmfVr688kJlUXpcCJblhyum8+++uEmHX7LfW
   XVl/j0AKE36ZuvYXwme8b3hw0/dQl9USO0jtbrWATLsrUdUNdDPazg4du
   AnLXFWx6nYbrshL6jHDeU9dOscJ3LyMMVgDIxXm/L6WwUQOwaM1ggfeNL
   Qs83dwcxgYqbHGdoehU8qhF86N/AIjBDz9ZYIGBmX0rWMLv8s7hgg921h
   1OXr72teVfvcZeRPvvij20zQRgaNr5D/v4fu5XUCH1JQCkdE+k+At1NP/
   TLs7Njh75QtUPGbk/AQM1IJErOn+1H5jPWIWOGS0wRRDT6K9NclPY9IYj
   w==;
X-CSE-ConnectionGUID: 9R+EfGmvSimO7V5a3kHoIg==
X-CSE-MsgGUID: Z3EJZBuvSAGriXB8UUeo7Q==
X-IronPort-AV: E=Sophos;i="6.07,257,1708383600"; 
   d="scan'208";a="36752066"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 06 May 2024 08:24:44 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB58C175A79;
	Mon,  6 May 2024 08:24:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714976680;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=hFvec8RHwfbecZbWl4y8XMXl+nHWiScbi0lqX4wyrMM=;
	b=pT+Lj619DbJxEf3KWN+wvEMXsIFcqjM8dpZ03iyOJLnjkMklaN8JkUAT1yUOi05UDKTdF3
	Hl821sWiPs4nHIuxI51JYGPBTQZIQisnpVabszSYVoe9p8bgUVF/rNfXn7XBVu8ldKxOmB
	uxVklz3OiOoJ5MjaSBgsWpsxjkuLs3W4Yrp0XSldayWnDD8Ujpt1N/qYBK46WLIdIPuhts
	9GkljyG8YWzQaa8h4PZmrxTjuLHWmdp87Op0A1TURWhpvja6LDB2KHndY2EUzEtRgm/OBt
	cACxjGEBkWr8dTjTiYxEPOYHxCVF1GPddCeMU3DSPGWt978FjNr5r1W5Wl9dkg==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Mon, 06 May 2024 08:24:33 +0200
Subject: [PATCH v3] net: phy: marvell-88q2xxx: add support for Rev B1 and
 B2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240506-mv88q222x-revb1-b2-init-v3-1-6fa407c2e0bc@ew.tq-group.com>
X-B4-Tracking: v=1; b=H4sIAKB3OGYC/4XNQQ6CMBAF0KuQrh1Ch0KrK+9hXEBpoQsotFgxh
 LtbWJkY42aSP/nzZiVeOaM8uSQrcSoYb+wQQ35KiOyqoVVgmpgJZsgyluXQByEmRFwg1msKNYI
 ZzAznc0kblDoOTuL16JQ2yyHf7jF3xs/WvY5Hge7b/2agQIGJWhQFK5nM+VU903mC1tnHmErbk
 10O+KFR/lvDqHGlGdWCc8TqW9u27Q21+lylEgEAAA==
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714976678; l=7229;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=99wCcr5j1fMdVVJWEMEin5eoQXJctZVFHMgoOllds4s=;
 b=WvTS3sGdHgk9/rMe/NRzHncKL8Us5tiH9hCKtvpoXyv4IEM9kJsUffAi0ne3vfh5btfWxJc6n
 Tj2BvJMQh9wCapUz/WbgKxhY0s+1CAyyEUHJKhr2+C6RQAPoYfN7SQg
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

Different revisions of the Marvell 88q2xxx phy needs different init
sequences.

Add init sequence for Rev B1 and Rev B2. Rev B2 init sequence skips one
register write.

Tested-by: Dimitri Fedrau <dima.fedrau@gmail.com>
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
Hi,

as discussed when adding support for Marvell 88Q2220 Revision B0 [1],
newer revisions need different init sequences. So add support for Rev B1
and B2 with this patch.

[1] https://lore.kernel.org/netdev/20240216205302.GC3873@debian/

Best regards
Gregor
---
Changes in v3:
- change hex values to lower case
- Collect Tested-by
- Link to v2: https://lore.kernel.org/r/20240417-mv88q222x-revb1-b2-init-v2-1-7ef41f87722a@ew.tq-group.com

Changes in v2:
- Add helper function to write phy mmd sequences
- Link to v1: https://lore.kernel.org/r/20240403-mv88q222x-revb1-b2-init-v1-1-48b855464c37@ew.tq-group.com
---
 drivers/net/phy/marvell-88q2xxx.c | 119 +++++++++++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 6b4bd9883304..c812f16eaa3a 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -12,6 +12,8 @@
 #include <linux/hwmon.h>
 
 #define PHY_ID_88Q2220_REVB0	(MARVELL_PHY_ID_88Q2220 | 0x1)
+#define PHY_ID_88Q2220_REVB1	(MARVELL_PHY_ID_88Q2220 | 0x2)
+#define PHY_ID_88Q2220_REVB2	(MARVELL_PHY_ID_88Q2220 | 0x3)
 
 #define MDIO_MMD_AN_MV_STAT			32769
 #define MDIO_MMD_AN_MV_STAT_ANEG		0x0100
@@ -129,6 +131,49 @@ static const struct mmd_val mv88q222x_revb0_init_seq1[] = {
 	{ MDIO_MMD_PCS, 0xfe05, 0x755c },
 };
 
+static const struct mmd_val mv88q222x_revb1_init_seq0[] = {
+	{ MDIO_MMD_PCS, 0xffe4, 0x0007 },
+	{ MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0 },
+	{ MDIO_MMD_PCS, 0xffe3, 0x7000 },
+	{ MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0840 },
+};
+
+static const struct mmd_val mv88q222x_revb2_init_seq0[] = {
+	{ MDIO_MMD_PCS, 0xffe4, 0x0007 },
+	{ MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0 },
+	{ MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0840 },
+};
+
+static const struct mmd_val mv88q222x_revb1_revb2_init_seq1[] = {
+	{ MDIO_MMD_PCS, 0xfe07, 0x125a },
+	{ MDIO_MMD_PCS, 0xfe09, 0x1288 },
+	{ MDIO_MMD_PCS, 0xfe08, 0x2588 },
+	{ MDIO_MMD_PCS, 0xfe72, 0x042c },
+	{ MDIO_MMD_PCS, 0xffe4, 0x0071 },
+	{ MDIO_MMD_PCS, 0xffe4, 0x0001 },
+	{ MDIO_MMD_PCS, 0xfe1b, 0x0048 },
+	{ MDIO_MMD_PMAPMD, 0x0000, 0x0000 },
+	{ MDIO_MMD_PCS, 0x0000, 0x0000 },
+	{ MDIO_MMD_PCS, 0xffdb, 0xfc10 },
+	{ MDIO_MMD_PCS, 0xfe1b, 0x58 },
+	{ MDIO_MMD_PCS, 0xfcad, 0x030c },
+	{ MDIO_MMD_PCS, 0x8032, 0x6001 },
+	{ MDIO_MMD_PCS, 0xfdff, 0x05a5 },
+	{ MDIO_MMD_PCS, 0xfdec, 0xdbaf },
+	{ MDIO_MMD_PCS, 0xfcab, 0x1054 },
+	{ MDIO_MMD_PCS, 0xfcac, 0x1483 },
+	{ MDIO_MMD_PCS, 0x8033, 0xc801 },
+	{ MDIO_MMD_AN, 0x8032, 0x2020 },
+	{ MDIO_MMD_AN, 0x8031, 0xa28 },
+	{ MDIO_MMD_AN, 0x8031, 0xc28 },
+	{ MDIO_MMD_PCS, 0xfbba, 0x0cb2 },
+	{ MDIO_MMD_PCS, 0xfbbb, 0x0c4a },
+	{ MDIO_MMD_PCS, 0xfe5f, 0xe8 },
+	{ MDIO_MMD_PCS, 0xfe05, 0x755c },
+	{ MDIO_MMD_PCS, 0xfa20, 0x002a },
+	{ MDIO_MMD_PCS, 0xfe11, 0x1105 },
+};
+
 static int mv88q2xxx_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -687,31 +732,72 @@ static int mv88q222x_soft_reset(struct phy_device *phydev)
 	return 0;
 }
 
-static int mv88q222x_revb0_config_init(struct phy_device *phydev)
+static int mv88q222x_write_mmd_vals(struct phy_device *phydev,
+				    const struct mmd_val *vals, size_t len)
 {
-	int ret, i;
+	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb0_init_seq0); i++) {
-		ret = phy_write_mmd(phydev, mv88q222x_revb0_init_seq0[i].devad,
-				    mv88q222x_revb0_init_seq0[i].regnum,
-				    mv88q222x_revb0_init_seq0[i].val);
+	for (; len; vals++, len--) {
+		ret = phy_write_mmd(phydev, vals->devad, vals->regnum,
+				    vals->val);
 		if (ret < 0)
 			return ret;
 	}
 
+	return 0;
+}
+
+static int mv88q222x_revb0_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb0_init_seq0,
+				       ARRAY_SIZE(mv88q222x_revb0_init_seq0));
+	if (ret < 0)
+		return ret;
+
 	usleep_range(5000, 10000);
 
-	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb0_init_seq1); i++) {
-		ret = phy_write_mmd(phydev, mv88q222x_revb0_init_seq1[i].devad,
-				    mv88q222x_revb0_init_seq1[i].regnum,
-				    mv88q222x_revb0_init_seq1[i].val);
-		if (ret < 0)
-			return ret;
-	}
+	ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb0_init_seq1,
+				       ARRAY_SIZE(mv88q222x_revb0_init_seq1));
+	if (ret < 0)
+		return ret;
 
 	return mv88q2xxx_config_init(phydev);
 }
 
+static int mv88q222x_revb1_revb2_config_init(struct phy_device *phydev)
+{
+	bool is_rev_b1 = phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB1;
+	int ret;
+
+	if (is_rev_b1)
+		ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb1_init_seq0,
+					       ARRAY_SIZE(mv88q222x_revb1_init_seq0));
+	else
+		ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb2_init_seq0,
+					       ARRAY_SIZE(mv88q222x_revb2_init_seq0));
+	if (ret < 0)
+		return ret;
+
+	usleep_range(3000, 5000);
+
+	ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb1_revb2_init_seq1,
+				       ARRAY_SIZE(mv88q222x_revb1_revb2_init_seq1));
+	if (ret < 0)
+		return ret;
+
+	return mv88q2xxx_config_init(phydev);
+}
+
+static int mv88q222x_config_init(struct phy_device *phydev)
+{
+	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
+		return mv88q222x_revb0_config_init(phydev);
+	else
+		return mv88q222x_revb1_revb2_config_init(phydev);
+}
+
 static int mv88q222x_cable_test_start(struct phy_device *phydev)
 {
 	int ret;
@@ -810,14 +896,15 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 	},
 	{
-		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
+		.phy_id			= MARVELL_PHY_ID_88Q2220,
+		.phy_id_mask		= MARVELL_PHY_ID_MASK,
 		.name			= "mv88q2220",
 		.flags			= PHY_POLL_CABLE_TEST,
 		.probe			= mv88q2xxx_probe,
 		.get_features		= mv88q2xxx_get_features,
 		.config_aneg		= mv88q2xxx_config_aneg,
 		.aneg_done		= genphy_c45_aneg_done,
-		.config_init		= mv88q222x_revb0_config_init,
+		.config_init		= mv88q222x_config_init,
 		.read_status		= mv88q2xxx_read_status,
 		.soft_reset		= mv88q222x_soft_reset,
 		.config_intr		= mv88q2xxx_config_intr,
@@ -836,7 +923,7 @@ module_phy_driver(mv88q2xxx_driver);
 
 static struct mdio_device_id __maybe_unused mv88q2xxx_tbl[] = {
 	{ MARVELL_PHY_ID_88Q2110, MARVELL_PHY_ID_MASK },
-	{ PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0), },
+	{ MARVELL_PHY_ID_88Q2220, MARVELL_PHY_ID_MASK },
 	{ /*sentinel*/ }
 };
 MODULE_DEVICE_TABLE(mdio, mv88q2xxx_tbl);

---
base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
change-id: 20240403-mv88q222x-revb1-b2-init-9961d2cf1d27

Best regards,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


