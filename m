Return-Path: <netdev+bounces-98845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBB48D2AB2
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 04:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41318285016
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E9315ADB3;
	Wed, 29 May 2024 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t7s9lkad"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C415AAD7;
	Wed, 29 May 2024 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949039; cv=none; b=u1JkI20gH6NoLxLNpMb1MihkkQESMxLOHDrNdootNMuh8ib/wNdw/4Ld7JZqyB3+I9VGG5XPaOqNnjxgzOr3ZDWr6WtmCJT+9hCGuX2YVGlB4psCAR4SZ7eSqvIRtmsKf9L366dUWrmGPs8IuHy5NkJ6E3Y5MQFlFMdifgL8V/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949039; c=relaxed/simple;
	bh=34eSlQKHCn8By2FSveem/MuMJRk0WabJBZDj10rsQgY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=brahBvQJbOEoTueIYesNfutiExdrBMhD7FNuc8zhk0RFO2D++v45YylryeiQBeGpOiNmq1U4mELY/8PWKLtDJ0ViHnfwbcReRkSK6p/51qNAxa+K7lsTnTBW8RgIKp3gCr4ZoX8T4IFuIBlWXLtlNOhxIUoCDhbn6p0kYrCID7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t7s9lkad; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716949036; x=1748485036;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=34eSlQKHCn8By2FSveem/MuMJRk0WabJBZDj10rsQgY=;
  b=t7s9lkadrYZUQ+j3XNjAkIMPwXcY+yS9VsszgSfRNdaHVVLNq8Jazesf
   ctx2DT9XL3mssokFv41Sz1s51NoqsdOSPg4VovAgq0mVzxxWMre6J4GfT
   1QeWFViXO1/HdyC8Fg+4HeHEGJDmB4UCwY/mYh1iv1fBj+nrUcm40P8w7
   KWH/iczysin0C/HYJhdsd5AvGGliiYe1gOYuFvf8rIkwnN0rZf+GYGcT7
   +Slw+lzswebSd86EPm//A7Ida6Y+Ie1qkJkFrSAaAh+Q+2CmSwrcl4vRz
   efNntNUU01oVKWJz19FHxBf5y850QEDTOo3PfRhK6yeRAGdlYW7MRFWAY
   g==;
X-CSE-ConnectionGUID: OFQuk28LRuK+2e1hiRiHpA==
X-CSE-MsgGUID: 402bAtDKRfqgld3jqBP74Q==
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="26661639"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 19:17:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 May 2024 19:17:01 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 28 May 2024 19:17:01 -0700
From: <Tristram.Ha@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Robert Hancock
	<robert.hancock@calian.com>
CC: Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH v1 net] net: phy: micrel: fix KSZ9477 PHY issues after suspend/resume
Date: Tue, 28 May 2024 19:20:23 -0700
Message-ID: <1716949223-4250-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

When the PHY is powered up after powered down most of the registers are
reset, so the PHY setup code needs to be done again.  In addition the
interrupt register will need to be setup again so that link status
indication works again.

Fixes: 26dd2974c5b5 ("net: phy: micrel: Move KSZ9477 errata fixes to PHY driver")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v1
 - put back genphy_restart_ange() in ksz9477_phy_errata()
 - do not change MMD 0x1c reg 0x8 value

 drivers/net/phy/micrel.c | 62 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 2b8f8b7f1517..8c20cf937530 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1939,7 +1939,7 @@ static const struct ksz9477_errata_write ksz9477_errata_writes[] = {
 	{0x1c, 0x20, 0xeeee},
 };
 
-static int ksz9477_config_init(struct phy_device *phydev)
+static int ksz9477_phy_errata(struct phy_device *phydev)
 {
 	int err;
 	int i;
@@ -1967,16 +1967,30 @@ static int ksz9477_config_init(struct phy_device *phydev)
 			return err;
 	}
 
+	err = genphy_restart_aneg(phydev);
+	if (err)
+		return err;
+
+	return err;
+}
+
+static int ksz9477_config_init(struct phy_device *phydev)
+{
+	int err;
+
+	/* Only KSZ9897 family of switches needs this fix. */
+	if ((phydev->phy_id & 0xf) == 1) {
+		err = ksz9477_phy_errata(phydev);
+		if (err)
+			return err;
+	}
+
 	/* According to KSZ9477 Errata DS80000754C (Module 4) all EEE modes
 	 * in this switch shall be regarded as broken.
 	 */
 	if (phydev->dev_flags & MICREL_NO_EEE)
 		phydev->eee_broken_modes = -1;
 
-	err = genphy_restart_aneg(phydev);
-	if (err)
-		return err;
-
 	return kszphy_config_init(phydev);
 }
 
@@ -2085,6 +2099,42 @@ static int kszphy_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz9477_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	/* No need to initialize registers if not powered down. */
+	ret = phy_read(phydev, MII_BMCR);
+	if (ret < 0)
+		return ret;
+	if (!(ret & BMCR_PDOWN))
+		return 0;
+
+	genphy_resume(phydev);
+
+	/* After switching from power-down to normal mode, an internal global
+	 * reset is automatically generated. Wait a minimum of 1 ms before
+	 * read/write access to the PHY registers.
+	 */
+	usleep_range(1000, 2000);
+
+	/* Only KSZ9897 family of switches needs this fix. */
+	if ((phydev->phy_id & 0xf) == 1) {
+		ret = ksz9477_phy_errata(phydev);
+		if (ret)
+			return ret;
+	}
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
@@ -5493,7 +5543,7 @@ static struct phy_driver ksphy_driver[] = {
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= genphy_suspend,
-	.resume		= genphy_resume,
+	.resume		= ksz9477_resume,
 	.get_features	= ksz9477_get_features,
 } };
 
-- 
2.34.1


