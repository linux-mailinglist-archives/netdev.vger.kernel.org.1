Return-Path: <netdev+bounces-99617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0240C8D582D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F2DB22F8C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A973BDF6C;
	Fri, 31 May 2024 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lSo6f6vn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AE5C89;
	Fri, 31 May 2024 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119312; cv=none; b=rbt4aYcpR4n3VHdFKk/hFL0WZ5u/aN+xdTym48wqyYF6OH+UtK4ci8G5VjUN24tw62lFpYw7wjDnYIuDi50gpRLQ2sWGZ/tnSJz5ZL7pk32DUN6uvT9IVRcf9ymzB8xXaVJ3HNAfElDqyplZ0cZKgHGA3w4wnL8QbyCnNxnkTSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119312; c=relaxed/simple;
	bh=TKphNDbRBuukut1Ep2302cA61A0z6FOESwmZlyo0rOw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AA/WhMzg7vSpEwIL1gI6EDEMGLV9vMFicQ5Y5eGdwVHRJgg3bddDHV+aMmEDyfwVtVHH59T6mX9iQsKcXBqYrfApBkiHfV1uXt1gRGqA92OmAFqhcjhI+jHkFb8UtFLHyZ+Rev3VS8N0Hs1QC9pHlc3/PLeOiB6OZ4/TpYk4B+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lSo6f6vn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717119311; x=1748655311;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=TKphNDbRBuukut1Ep2302cA61A0z6FOESwmZlyo0rOw=;
  b=lSo6f6vnqE6pRgZ1ccpAN/06ZVeTjMsdkgRlKEIoohoLt6Jzr0tqK1WY
   VxxGJ9KxyacPsj6rcSH7rON8tX+W1aPp2ikCOvDEXcDbpFZOrjZ9qnmZ4
   d3ZD1RU+Yc7WnkV2LcFWL+M/C7rcJX1x5U6HV/1LxcEoFUS67MWM5bkOk
   glsxmA48RWUsWnlUwpH3X1FABolprzvMoRnmQoTua07bEH+sizb6aD2C8
   CTLZ9hwWIMQGyKXmInv78VKPruwNEvG7gD1Wh/fgfYV74WeICs6WFIV4b
   e3FTG/mz6hgIh7OVRJeux+Rt2oBRJ1q1ql1wJ6FmPl3uAdkwPORdPODdd
   g==;
X-CSE-ConnectionGUID: /B7No0VXTMuuzRK/V9lgdw==
X-CSE-MsgGUID: 01GfK7jXSBOKQb7FeaLGVA==
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="26781072"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2024 18:35:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 18:34:39 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 30 May 2024 18:34:38 -0700
From: <Tristram.Ha@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH v1 net] net: phy: Micrel KSZ8061: fix errata solution not taking effect problem
Date: Thu, 30 May 2024 18:38:01 -0700
Message-ID: <1717119481-3353-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8061 needs to write to a MMD register at driver initialization to fix
an errata.  This worked in 5.0 kernel but not in newer kernels.  The
issue is the main phylib code no longer resets PHY at the very beginning.
Calling phy resuming code later will reset the chip if it is already
powered down at the beginning.  This wipes out the MMD register write.
Solution is to implement a phy resume function for KSZ8061 to take care
of this problem.

Fixes: 232ba3a51cc2 ("net: phy: Micrel KSZ8061: link failure after cable connect")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v1
 - Correct the kernel version to 5.0

 drivers/net/phy/micrel.c | 42 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 2b8f8b7f1517..618e532ee5d7 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -866,6 +866,17 @@ static int ksz8061_config_init(struct phy_device *phydev)
 {
 	int ret;
 
+	/* Chip can be powered down by the bootstrap code. */
+	ret = phy_read(phydev, MII_BMCR);
+	if (ret < 0)
+		return ret;
+	if (ret & BMCR_PDOWN) {
+		ret = phy_write(phydev, MII_BMCR, ret & ~BMCR_PDOWN);
+		if (ret < 0)
+			return ret;
+		usleep_range(1000, 2000);
+	}
+
 	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_DEVID1, 0xB61A);
 	if (ret)
 		return ret;
@@ -2085,6 +2096,35 @@ static int kszphy_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz8061_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	/* This function can be called twice when the Ethernet device is on. */
+	ret = phy_read(phydev, MII_BMCR);
+	if (ret < 0)
+		return ret;
+	if (!(ret & BMCR_PDOWN))
+		return 0;
+
+	genphy_resume(phydev);
+	usleep_range(1000, 2000);
+
+	/* Re-program the value after chip is reset. */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_DEVID1, 0xB61A);
+	if (ret)
+		return ret;
+
+	/* Enable PHY Interrupts */
+	if (phy_interrupt_is_valid(phydev)) {
+		phydev->interrupts = PHY_INTERRUPT_ENABLED;
+		if (phydev->drv->config_intr)
+			phydev->drv->config_intr(phydev);
+	}
+
+	return 0;
+}
+
 static int kszphy_probe(struct phy_device *phydev)
 {
 	const struct kszphy_type *type = phydev->drv->driver_data;
@@ -5339,7 +5379,7 @@ static struct phy_driver ksphy_driver[] = {
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= kszphy_suspend,
-	.resume		= kszphy_resume,
+	.resume		= ksz8061_resume,
 }, {
 	.phy_id		= PHY_ID_KSZ9021,
 	.phy_id_mask	= 0x000ffffe,
-- 
2.34.1


