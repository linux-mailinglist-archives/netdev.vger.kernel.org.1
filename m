Return-Path: <netdev+bounces-111730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379369325D0
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772A4B20AFA
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5745199389;
	Tue, 16 Jul 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="azTzTkSY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9554C1991A3;
	Tue, 16 Jul 2024 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129852; cv=none; b=uAhjz6uGVBDyyrvXX8R/5nkAPQG8v/Ulqe7Hbq0z9Mb7CUh7jZmraTESq1MnvlEhGgr+WQW8caMdkGqQ0rwiHxu6MpgGIE7QQqZQqKLAmCJ5IPsYAFRwzvRdUE2kRVUVp5UPhl8XOWuZTyCvIe3+caXiSLNC6yztCIs9OeichLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129852; c=relaxed/simple;
	bh=DTZVF0TD9HzA4HAWJQ/BniAtqJDgRFsJo+Gj0EbFxwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkhgG0iwZgO+seZSsgw9bUO6EjouPsqJ+EBk0/IhTc36x0JHgAdBpCTGpLCehorfE/r16BgqF1dMhiiHdHmP8LJlyCSgcCCOkAxAKzDsU0JGdcCbfcJPvSjY0+Jk8FA5iE93S+iycYBlI4/eP8giXTKwYLc1x8S9MXNQZ2SfL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=azTzTkSY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721129850; x=1752665850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DTZVF0TD9HzA4HAWJQ/BniAtqJDgRFsJo+Gj0EbFxwo=;
  b=azTzTkSYy1Fd3uaTYXmDKxa1/FCXwOH5hPP5oxWrGDystl4KnqgnquJM
   pXe/bAzkTqhE48QSix2xZpOZ82jOlnTByeXkMwRlOJvhrQie7xEWT2sJ8
   T6dUx1ZLD98hmY409uHJrw7c6vj1jKT7E2ZTLgOuBTTy4B8Ck9hpDpH+D
   diOtWJ+4HhADiiEnnBUSVfijA7yCBlkERLwtMQkZ2LST/rTvfKQz7kidl
   ZGnrw9VrYK3e/SFMBVU0kRgnfi5D7CEqIQbjcvYUnLlNM3hSILJ2C2xeo
   qucN7ElvujXzJg6QH8juMSxmdkx73NOyZvndmhkHGOBJ8D4chwuR5nBBk
   A==;
X-CSE-ConnectionGUID: wiqq30pxTLCqYtWfMI+eUQ==
X-CSE-MsgGUID: V5AJQY9YQRWj84vjSaqIhw==
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="196701709"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2024 04:37:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jul 2024 04:37:20 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jul 2024 04:37:16 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <andrew@lunn.ch>,
	<horms@kernel.org>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <linux@armlinux.org.uk>,
	<bryan.whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V2 1/4] net: lan743x: Create separate PCS power reset function
Date: Tue, 16 Jul 2024 17:03:46 +0530
Message-ID: <20240716113349.25527-2-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Create separate PCS power reset function from lan743x_sgmii_config () to use
as subroutine.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
============
V1 -> V2:
  - No changes

 drivers/net/ethernet/microchip/lan743x_main.c | 55 ++++++++++---------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index e418539565b1..ce1e104adc20 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1147,12 +1147,39 @@ static int lan743x_pcs_seq_state(struct lan743x_adapter *adapter, u8 state)
 	return 0;
 }
 
+static int lan743x_pcs_power_reset(struct lan743x_adapter *adapter)
+{
+	int mii_ctl;
+	int ret;
+
+	/* SGMII/1000/2500BASE-X PCS power down */
+	mii_ctl = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMCR);
+	if (mii_ctl < 0)
+		return mii_ctl;
+
+	mii_ctl |= BMCR_PDOWN;
+	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
+	if (ret < 0)
+		return ret;
+
+	ret = lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_DOWN);
+	if (ret < 0)
+		return ret;
+
+	/* SGMII/1000/2500BASE-X PCS power up */
+	mii_ctl &= ~BMCR_PDOWN;
+	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
+	if (ret < 0)
+		return ret;
+
+	return lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_UP);
+}
+
 static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct phy_device *phydev = netdev->phydev;
 	enum lan743x_sgmii_lsd lsd = POWER_DOWN;
-	int mii_ctl;
 	bool status;
 	int ret;
 
@@ -1209,31 +1236,7 @@ static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
 		netif_dbg(adapter, drv, adapter->netdev,
 			  "SGMII 1G mode enable\n");
 
-	/* SGMII/1000/2500BASE-X PCS power down */
-	mii_ctl = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMCR);
-	if (mii_ctl < 0)
-		return mii_ctl;
-
-	mii_ctl |= BMCR_PDOWN;
-	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
-	if (ret < 0)
-		return ret;
-
-	ret = lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_DOWN);
-	if (ret < 0)
-		return ret;
-
-	/* SGMII/1000/2500BASE-X PCS power up */
-	mii_ctl &= ~BMCR_PDOWN;
-	ret = lan743x_sgmii_write(adapter, MDIO_MMD_VEND2, MII_BMCR, mii_ctl);
-	if (ret < 0)
-		return ret;
-
-	ret = lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_UP);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return lan743x_pcs_power_reset(adapter);
 }
 
 static void lan743x_mac_set_address(struct lan743x_adapter *adapter,
-- 
2.34.1


