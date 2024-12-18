Return-Path: <netdev+bounces-152788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C09F5C91
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D4A7A3302
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AED42048;
	Wed, 18 Dec 2024 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g0s6flsF"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D435949;
	Wed, 18 Dec 2024 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487377; cv=none; b=r3751jjK7F//Kazm2BwrvGyohf45ljBCJy31aRtk/3HaTuY69F16gvwQOara1E4ASOEtHCAHNPRpDgB7on4/hFkPJ8dqM8gG2f5tE9GT7rs9mUvzya8C5QWA0xinMmvSwDjgv6Rr10UfCYviNAuuWGy5cpTR/UodfL9C16R9VSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487377; c=relaxed/simple;
	bh=CkztOJypNzOHapYhzul2pjQ4wmSLpA3mKHVDBfFOkis=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RW/sl8Tw07z05d5B7Dkgs59xmsFHA5VltPryE9+knC3Pu3BEeKyfgmBt2e+fDzj1Fd88V5ATzWpzE4crI9wTdMhPMaCdV9nj9MhQqgXKTqkMV4ogUT6P3Iv1OCifPTzMSldgDAbLGRNFEV7fF5GC7A9kzVKnEbgOCNjwLwu9xAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g0s6flsF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734487375; x=1766023375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CkztOJypNzOHapYhzul2pjQ4wmSLpA3mKHVDBfFOkis=;
  b=g0s6flsF3wBcXkR5b5yd6k2lbfUzIsPB5G4O6aOdsYBw71ulC5qNuXJw
   ZbCamLqtsKJylNPSXO4Y0Cd+Ox7KbaWt2t+Jau2ZLwDl9BydGiVR8GCKk
   klKiMTbZ04LDC/IMifenjmDSqEHOTjxR8NFvAZZcgnIYwYWgD9BNBeFQV
   hPKKrE543c8Adb92Ju4/USVbUA3TIcFpUWnqMnZhS96UoxdQ9vQoWrjSa
   JwM8gh5KxSbsCXrg6mbpHpXcDYg8XNtIaWNbAUvKFFaimwAcDzACcJw72
   8SNh6kiTK+e3ybhx2DmxvSgtelvNNidS1JhbkzgtZGkk+SdHwfnDEQ71O
   Q==;
X-CSE-ConnectionGUID: Re11vxomR/a0J49cWbJkUQ==
X-CSE-MsgGUID: c3p5AkhdRy6Ny4VFH45rsA==
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="35342117"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2024 19:02:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Dec 2024 19:02:39 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 17 Dec 2024 19:02:39 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
	<arun.ramadoss@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next] net: dsa: microchip: Do not execute PTP driver code for unsupported switches
Date: Tue, 17 Dec 2024 18:02:40 -0800
Message-ID: <20241218020240.70601-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The PTP driver code only works for certain KSZ switches like KSZ9477,
KSZ9567, LAN937X and their varieties.  This code is enabled by kernel
configuration CONFIG_NET_DSA_MICROCHIP_KSZ_PTP.  As the DSA driver is
common to work with all KSZ switches this PTP code is not appropriate
for other unsupported switches.  The ptp_capable indication is added to
the chip data structure to signal whether to execute those code.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 40 +++++++++++++++++++-------
 drivers/net/dsa/microchip/ksz_common.h |  1 +
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index df314724e6a7..2c465c466222 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1339,6 +1339,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rgmii = {false, false, true},
 		.internal_phy = {true, true, false},
 		.gbit_capable = {false, false, true},
+		.ptp_capable = true,
 		.wr_table = &ksz8563_register_set,
 		.rd_table = &ksz8563_register_set,
 	},
@@ -1550,6 +1551,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
+		.ptp_capable = true,
 		.wr_table = &ksz9477_register_set,
 		.rd_table = &ksz9477_register_set,
 	},
@@ -1677,6 +1679,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rgmii = {false, false, true},
 		.internal_phy = {true, true, false},
 		.gbit_capable = {true, true, true},
+		.ptp_capable = true,
 	},
 
 	[KSZ8567] = {
@@ -1712,6 +1715,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, false, false},
 		.gbit_capable	= {false, false, false, false, false,
 				   true, true},
+		.ptp_capable = true,
 	},
 
 	[KSZ9567] = {
@@ -1744,6 +1748,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
+		.ptp_capable = true,
 	},
 
 	[LAN9370] = {
@@ -1773,6 +1778,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rmii = {false, false, false, false, true},
 		.supports_rgmii = {false, false, false, false, true},
 		.internal_phy = {true, true, true, true, false},
+		.ptp_capable = true,
 	},
 
 	[LAN9371] = {
@@ -1802,6 +1808,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.supports_rmii = {false, false, false, false, true, true},
 		.supports_rgmii = {false, false, false, false, true, true},
 		.internal_phy = {true, true, true, true, false, false},
+		.ptp_capable = true,
 	},
 
 	[LAN9372] = {
@@ -1835,6 +1842,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, true, false, false},
 		.internal_phy	= {true, true, true, true,
 				   false, false, true, true},
+		.ptp_capable = true,
 	},
 
 	[LAN9373] = {
@@ -1868,6 +1876,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, true, false, false},
 		.internal_phy	= {true, true, true, false,
 				   false, false, true, true},
+		.ptp_capable = true,
 	},
 
 	[LAN9374] = {
@@ -1901,6 +1910,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, true, false, false},
 		.internal_phy	= {true, true, true, true,
 				   false, false, true, true},
+		.ptp_capable = true,
 	},
 
 	[LAN9646] = {
@@ -2809,16 +2819,21 @@ static int ksz_setup(struct dsa_switch *ds)
 			if (ret)
 				goto out_girq;
 
-			ret = ksz_ptp_irq_setup(ds, dp->index);
-			if (ret)
-				goto out_pirq;
+			if (dev->info->ptp_capable) {
+				ret = ksz_ptp_irq_setup(ds, dp->index);
+				if (ret)
+					goto out_pirq;
+			}
 		}
 	}
 
-	ret = ksz_ptp_clock_register(ds);
-	if (ret) {
-		dev_err(dev->dev, "Failed to register PTP clock: %d\n", ret);
-		goto out_ptpirq;
+	if (dev->info->ptp_capable) {
+		ret = ksz_ptp_clock_register(ds);
+		if (ret) {
+			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
+				ret);
+			goto out_ptpirq;
+		}
 	}
 
 	ret = ksz_mdio_register(dev);
@@ -2838,9 +2853,10 @@ static int ksz_setup(struct dsa_switch *ds)
 	return 0;
 
 out_ptp_clock_unregister:
-	ksz_ptp_clock_unregister(ds);
+	if (dev->info->ptp_capable)
+		ksz_ptp_clock_unregister(ds);
 out_ptpirq:
-	if (dev->irq > 0)
+	if (dev->irq > 0 && dev->info->ptp_capable)
 		dsa_switch_for_each_user_port(dp, dev->ds)
 			ksz_ptp_irq_free(ds, dp->index);
 out_pirq:
@@ -2859,11 +2875,13 @@ static void ksz_teardown(struct dsa_switch *ds)
 	struct ksz_device *dev = ds->priv;
 	struct dsa_port *dp;
 
-	ksz_ptp_clock_unregister(ds);
+	if (dev->info->ptp_capable)
+		ksz_ptp_clock_unregister(ds);
 
 	if (dev->irq > 0) {
 		dsa_switch_for_each_user_port(dp, dev->ds) {
-			ksz_ptp_irq_free(ds, dp->index);
+			if (dev->info->ptp_capable)
+				ksz_ptp_irq_free(ds, dp->index);
 
 			ksz_irq_free(&dev->ports[dp->index].pirq);
 		}
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index b3bb75ca0796..97f0ff16dc50 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -92,6 +92,7 @@ struct ksz_chip_data {
 	bool supports_rgmii[KSZ_MAX_NUM_PORTS];
 	bool internal_phy[KSZ_MAX_NUM_PORTS];
 	bool gbit_capable[KSZ_MAX_NUM_PORTS];
+	bool ptp_capable;
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 };
-- 
2.34.1


