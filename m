Return-Path: <netdev+bounces-98781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D218D2719
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CB01F247D0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1584717B421;
	Tue, 28 May 2024 21:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CGFebcQl"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64F17B414;
	Tue, 28 May 2024 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932031; cv=none; b=B0dXLeNOSBCFjkLuMLJkH4FSkremfgCXzd52B/bLRPDgxCEjRA89pC1ENk4Sl1DPX8dF03A92FcI2pZ/ZDFG4mwNpc2S6GkgRpUkiKM0MdXbCA5PQOTmsiPM09frGDSAC82UnW812v6KhnaAev9i0GScyk2EXmMq2QUTdKJl88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932031; c=relaxed/simple;
	bh=C3NNE7YrkGqYzxJz0dFrHqlrvx3sXS2Sk13NyrD/kkY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D5eu1dPqBueuEWq28+DdhyvtMucu+d0hA96+V0ED8jX0aezE65cG2B/HNiwH5RumVJ3yDQpzQ6Qc0QY/XyCzZVluFEwKTvlOc0eUuywhLOQNpy8te600gGmyOnogz8Se5EYhO3LHILn32XdsKtK4ry+4M6BvOW7FmDC598NHLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CGFebcQl; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716932029; x=1748468029;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=C3NNE7YrkGqYzxJz0dFrHqlrvx3sXS2Sk13NyrD/kkY=;
  b=CGFebcQlp1jTZmKd292M3uhJuRaKcsIfeKYsD93upm+etILa4lFn7Am8
   WmQ58xepOccYQN7A1uluU1rcUQvtu/OT/IA+TNj2iOI6P1vB1FijruJnj
   Sv2fwqcyvHSksX4wAKmBWy2GhiZW8ze3zYmmpKalTdmRYnbYut2YP6N5q
   h1idU6v2pO0lDUgRFcSeogS/s7q2xwxDCJxCuMs/0JRapSZxjwslGigy7
   qN9wmUSBQxs52Iikx84Y/1l66MDLRFg3AE7aZW5LHXMIiL65xD1cNbNY1
   dOQydcI89ZZelCasiMRVR4UU0soEQOnZqLocFisA7v95LOTKeuS1b8D18
   g==;
X-CSE-ConnectionGUID: 0qU0OGtxR26d9eErQO6dUw==
X-CSE-MsgGUID: 7Tjtpp5vTqifS0uytiHkSQ==
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="194022040"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 14:33:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 May 2024 14:33:39 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 28 May 2024 14:33:38 -0700
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
Subject: [PATCH net] net: phy: micrel: fix KSZ9477 PHY issues after suspend/resume
Date: Tue, 28 May 2024 14:37:00 -0700
Message-ID: <1716932220-3622-1-git-send-email-Tristram.Ha@microchip.com>
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
 drivers/net/phy/micrel.c | 60 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 2b8f8b7f1517..902d9a262c8a 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1918,7 +1918,7 @@ static const struct ksz9477_errata_write ksz9477_errata_writes[] = {
 	{0x01, 0x75, 0x0060},
 	{0x01, 0xd3, 0x7777},
 	{0x1c, 0x06, 0x3008},
-	{0x1c, 0x08, 0x2000},
+	{0x1c, 0x08, 0x2001},
 
 	/* Transmit waveform amplitude can be improved (1000BASE-T, 100BASE-TX, 10BASE-Te) */
 	{0x1c, 0x04, 0x00d0},
@@ -1939,7 +1939,7 @@ static const struct ksz9477_errata_write ksz9477_errata_writes[] = {
 	{0x1c, 0x20, 0xeeee},
 };
 
-static int ksz9477_config_init(struct phy_device *phydev)
+static int ksz9477_phy_errata(struct phy_device *phydev)
 {
 	int err;
 	int i;
@@ -1967,16 +1967,26 @@ static int ksz9477_config_init(struct phy_device *phydev)
 			return err;
 	}
 
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
 
@@ -2085,6 +2095,42 @@ static int kszphy_resume(struct phy_device *phydev)
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
@@ -5493,7 +5539,7 @@ static struct phy_driver ksphy_driver[] = {
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= genphy_suspend,
-	.resume		= genphy_resume,
+	.resume		= ksz9477_resume,
 	.get_features	= ksz9477_get_features,
 } };
 
-- 
2.34.1


